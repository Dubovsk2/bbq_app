BBQ Ruby on Rails приложение для создания событий, приглашения друзей на мероприятие, для общения внутри мероприятия, для отправки информации о мероприятии, размещения фотографий.

Запуск программы

Клонировать репозиторий: git clone https://github.com/Dubovsk2/bbq_app.git

Установить библиотеки:

bundle install

Запустите миграции: rails db:migrate

Соберите js файлы: yarn install, yarn buld:css

Установить mini_magick: sudo apt install ruby-mini-magick Запустите сервер: rails s

Реализованный функционал: Интернационализация (ru, en), i18n Мероприятия: создание, редактирование, удаление Комментарии для события Подписки на событие Отправка почты (yandex) Редактирование профиля Работа с изображениями (mini_magick, carrierwave, lightbox2) Аутентификация (Devise)
____________________________________________________
Если после этого не запустится, попробуйте убрать строку "<%= javascript_include_tag "application", "data-turbo-track": "reload", type: "module" %>" в app/views/layouts/application.html.erb
