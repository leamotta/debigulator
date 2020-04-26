# Debigulator
### Debig your URLs! (Rebigulator included)

### Shorten your links visiting https://debigulator.herokuapp.com/ or contact me at https://debigulator.herokuapp.com/we04zkO to have special access to the API ;)

# How to colaborate with the project

## Running local server

### 1- Installing Ruby

- Clone the repository by running `git clone git@github.com:leamotta/debigulator.git`
- Go to the project root by running `cd debigulator`
- Download and install [Rbenv](https://github.com/rbenv/rbenv#basic-github-checkout).
- Download and install [Ruby-Build](https://github.com/rbenv/ruby-build#installing-as-an-rbenv-plugin-recommended).
- Install the appropriate Ruby version by running `rbenv install [version]` where `version` is the one located in [.ruby-version](.ruby-version)

### 2- Installing Rails gems

- Install [Bundler](http://bundler.io/).

```bash
  gem install bundler
  rbenv rehash
```

- Install all the gems included in the project.

```bash
  bundle install
```

### Database Setup

Run in terminal:

For Linux:
```bash
  sudo -u postgres psql
  CREATE ROLE "debigulator" LOGIN CREATEDB PASSWORD 'debigulator';
```

On MacOS:
```bash
  psql postgres
  CREATE ROLE "debigulaotr" LOGIN CREATEDB PASSWORD 'debigulator';
```

Log out from postgres and run:

```bash
  bundle exec rake db:create db:migrate
```

Your server is ready to run. You can do this by executing `rails server` and going to [http://localhost:3000](http://localhost:3000). Happy coding!

## Dotenv

We use [dotenv](https://github.com/bkeepers/dotenv) to set up our environment variables in combination with `secrets.yml`.

For example, you could have the following `secrets.yml`:

```yml
production: &production
  foo: <%= ENV['FOO'] %>
  bar: <%= ENV['BAR'] %>
```

and a `.env` file in the project root that looks like this:

```
FOO=1
BAR=2
```

When you load up your application, `Rails.application.secrets.foo` will equal `ENV['FOO']`, making your environment variables reachable across your Rails app.
The `.env` will be ignored by `git` so it won't be pushed into the repository, thus keeping your tokens and passwords safe.

## About

This project was written by [Leandro Motta](https://www.linkedin.com/in/leandro-motta/).
