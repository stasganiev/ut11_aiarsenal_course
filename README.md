# ut11_aiarsenal_course

> **In English.** Demo configuration for the course "AI Arsenal for the 1C Developer". It is 1C:Trade Management 11.5 exported to files. Course workshops extend it with the help of AI tools. The rest of this page is in Russian.

Демо-конфигурация курса [«AI-арсенал для разработчика 1С»](https://cors.su/ai-arsenal-dlya-razrabotchika-1s/). Это «1С:Управление торговлей» 11.5.19.74, выгруженная в файлы. На ней участники курса разбирают работу с AI: документирование модулей, декомпозицию задач, разработку, ревью и тесты.

## Ветки

| Ветка | Что в ней |
| --- | --- |
| `main` | Конфигурация на старте курса |
| `develop` | Ход курса: доработки конфигурации, инструкции для AI (`CLAUDE.md`, папка `.claude/`) и материалы воркшопов |

## Как открыть

Репозиторий большой, поэтому историю лучше не скачивать:

```text
git clone --depth 1 --branch develop https://github.com/stasganiev/ut11_aiarsenal_course.git
```

1. Создайте пустую информационную базу на платформе 8.3.27.
2. Откройте её в конфигураторе и выберите **Конфигурация - Загрузить конфигурацию из файлов**.
3. Укажите папку `src` из репозитория.
4. Обновите конфигурацию базы данных (F7).

## Автор

Стас Ганиев, автор курса. Telegram-канал: [OneSCast](https://t.me/OneSCast).
