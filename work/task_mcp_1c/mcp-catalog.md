# MCP-серверы экосистемы 1С — справочник для учащихся

Дата: 2026-08-13. Источник: [каталог Untru/1c-mcp](https://github.com/Untru/1c-mcp)

**MCP (Model Context Protocol)** — стандарт, по которому AI-агент (Claude, Cursor, Copilot)
получает доступ к внешним инструментам и данным.

Серверы делятся на три группы по тому, **куда** они дают доступ.

---

## Группа 1. Доступ в живую базу

Читают и пишут реальные данные: справочники, документы, регистры.

| Сервер | Как подключается | Коротко |
|---|---|---|
| [aprovodka](https://github.com/theYahia/1c-rest-mcp) | OData, `npx` | 34 инструмента, данные и запись с подтверждением. Нужен веб-сервер |
| [1c-mcp-toolkit](https://github.com/ROCTUP/1c-mcp-toolkit) | обработка `.epf` | Язык запросов 1С, метаданные, журнал регистрации. Веб-сервер не нужен |
| [http1c / MCP-DB-Client](https://github.com/DitriXNew/MCP-DB-Client) | DLL + расширение | Выполнение кода и запросов. Требует сборки C++ |
| [1c_mcp](https://github.com/vladimir-kharin/1c_mcp) | расширение + Python | Каркас: инструменты пишете сами под свою задачу |
| [mcp-1c](https://github.com/feenlace/mcp-1c) | Go-бинарник | Метаданные, формы, запросы с параметрами |
| [v8-session-manager](https://github.com/1c-neurofish/v8-session-manager) | Rust | Собирает несколько сеансов 1С в одну точку доступа |
| [ARQA](https://arqa.cc/ru/mcp-server) | HTTP | Документы и отчёты голосом. Коммерческий, закрытый |

## Группа 2. Работа с кодом и метаданными

Живая база не нужна — работают с выгрузкой конфигурации и справкой.

| Сервер | Коротко |
|---|---|
| [bsl-analyzer](https://github.com/itrous/bsl-analyzer) | 180 проверок качества кода BSL |
| [mcp-bsl-platform-context](https://github.com/alkoleft/mcp-bsl-platform-context) | Синтакс-помощник платформы: типы, методы, объектная модель |
| [onec-help-mcp](https://github.com/rzateev/onec-help-mcp) | Поиск по официальной документации 1С |
| [bsl-mcp](https://github.com/phsin/mcp-bsl-ls) | Анализ и форматирование BSL через Language Server |
| [1c-mcp-metacode](https://github.com/ROCTUP/1c-mcp-metacode) | Метаданные в граф Neo4j, иерархия вызовов |
| [bsl-graph](https://github.com/alkoleft/bsl-graph) | Граф знаний по коду с веб-визуализацией |
| [mcp-1c-v1](https://github.com/FSerg/mcp-1c-v1) | Семантический поиск по коду (RAG, Qdrant) |
| [rlm-tools-bsl](https://github.com/Dach-Coin/rlm-tools-bsl) | Анализ BSL без RAG, 62 хелпера |
| [1c-buddy](https://github.com/ROCTUP/1c-buddy) | Шлюз к 1С:Напарник — объясняет синтаксис, проверяет код |
| [1c-templates-mcp](https://yellowmcp.com/servers/1c-templates-mcp) | Поиск по 2200+ шаблонам кода |

## Группа 3. IDE и инфраструктура

| Сервер | Коротко |
|---|---|
| [EDT-MCP](https://github.com/DitriXNew/EDT-MCP) | Плагин 1C:EDT: AST, формы, диагностики прямо в IDE |
| [1C: Platform Tools MCP](https://github.com/yellow-hammer/mcp-1c-platform-tools) | Мост команд VS Code в MCP |
| [CodePilot1C](https://github.com/ondysss/codepilot1c-edt) | Чат и agent-режим внутри EDT |
| [v8-runner](https://github.com/alkoleft/v8-runner-rust) | Сборка, проверка синтаксиса, запуск тестов |
| [1c-log-checker](https://github.com/SteelMorgan/1c-log-checker) | Разбор техножурнала через ClickHouse + Grafana |
| [compose4mcp](https://github.com/pravets/compose4mcp) | Оркестрация нескольких MCP через Docker Compose |
| [1c-accounting-mcp](https://github.com/tarasov46/1c-accounting-mcp) | Интеграция с бухгалтерией. Ранняя стадия |

---

## Как выбрать

| Задача | Что брать |
|---|---|
| Посмотреть данные в базе, есть веб-сервер | aprovodka |
| Посмотреть данные, веб-сервера нет | 1c-mcp-toolkit |
| Разбор и рефакторинг кода конфигурации | bsl-analyzer + mcp-bsl-platform-context |
| Работа в 1C:EDT | EDT-MCP |
| Свои доменные инструменты | 1c_mcp или http1c |

## Что выбрано в этом курсе

База: `C:\dev\bases1c\ut11aiarsenal_course` (УТ 11.5). Установлены **оба** сервера
из группы 1 — они закрывают разные задачи и дополняют друг друга:

- **aprovodka** (имя в конфиге `onec-data`) — OData 3.0 поверх веб-публикации.
  Основной канал для работы с данными: справочники, документы, регистры,
  виртуальные таблицы остатков/оборотов.
- **1c-mcp-toolkit** (имя в конфиге `onec-toolkit`) — обработка `.epf`,
  встроенный сервер внутри самой 1С. Дополняет aprovodka там, где нужен
  язык запросов, метаданные, журнал регистрации или права доступа.

Настройка обоих: [setup.md](setup.md).

## О чём помнить

- `execute_code` и подобные инструменты выполняют **произвольный код в базе**. Только на тестовой копии.
- Обработка работает **под правами открывшего её пользователя**.
- Сторонний `.epf` исполняется внутри вашей базы — фиксируйте версию.
- Порт MCP-сервера наружу не публиковать.
