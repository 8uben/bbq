# BBQ

## About
BBQ app is study project of events management.

In the app create an event, set mark on the map, add photos, write comments and subscribe to the event so get email notifications about activity on event page.

## Main used gems
 - [**devise**](https://github.com/heartcombo/devise) - authentication users

 - [**rails-i18n**](https://github.com/svenfuchs/rails-i18n) - app locales

 - [**carrierwave**](https://github.com/carrierwaveuploader/carrierwave) - upload files

 - [**rmagick**](https://github.com/rmagick/rmagick) - for images processing

 - [**fog-aws**](https://github.com/fog/fog-aws) - provider AWS storage

 - [**mailjet-gem**](https://github.com/mailjet/mailjet-gem) - email notifications

 - [**pundit**](https://github.com/varvet/pundit) - authorization system

 - [**resque**](https://github.com/resque/resque) - [Redis](https://redis.io/)-backed library for creating background jobs

 - [**rspec-rails**](https://github.com/rspec/rspec-rails) - testing framework

 - [**capistrano**](https://github.com/capistrano/capistrano) - deployment automation tool

 - [**factory_bot_rails**](https://github.com/thoughtbot/factory_bot_rails) - fixtures replacement

 - [**omniauth**](https://github.com/mkdynamic/omniauth) - OAuth

## Version

```
$ rails -v
> Rails 6.1.4.1

$ ruby -v
> ruby 2.7.3
```

## Lauching
pre-installation required: [PostgreSQL](https://www.postgresql.org/), [Redis](https://redis.io/), [Node.js](https://nodejs.org/), [Yarn](https://yarnpkg.com/)

Run install gems
```
$ bundle
```

Run install nodejs dependent
```
$ yarn
```

Create database and run migrations
```
$ rails db:create db:migrate
```

Private services keys are in credentials so must generate pair files `master.key` and `credentials.yml.enc`
```
EDITOR=nano rails credentials:edit
```
After open credentials file need write this data, enter your values: (this structure is example)

```
aws:
  S3_ACCESS_KEY: <value>
  S3_SECRET_KEY: <value>
  S3_BUCKET_NAME: <value>

action_mailer:
  mailer_host: <value>
  mail_from: <value>
  user_name: <value>
  password: <value>
  apikey_public: <value>
  apikey_private: <value>

yandex_maps:
  apikey: <value>

database:
  user: <value>
  password: <value>
  name: <value>

oauth:
  facebook: <value>
    app_id: <value>
    secret: <value>
  vkontakte:
    app_id: <value>
    secret: <value>

cap:
  domain: <value>
  user: <value>
```

Start sever
```
$ rails s
```

In browser open `localhost:3000`

## Demo
deploy on [**VPS**](https://vladfdv.ru/)
