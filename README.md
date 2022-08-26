# EDM Scraper

Scripts for:
- Scraping lists of concerts from several websites
- Storing the scraped shows in a database
- Compiling new shows into an email, sent using PostageApp

## Running in production

Install Ruby 3.1.1.

Install PhantomJS.

Install PostgreSQL, then create a database called `edm-scraper` and a user called `user`.

Run `bundle` to install dependencies.

Create a file called `.env` in the project's root directory or otherwise set up these environment variables:

```
DATABASE_ENV=production
DATABASE_URL=postgres://user:[password]@localhost:5432/edm-scraper
POSTAGEAPP_API_KEY=[API key]
```

Run `ruby bin/migrate up` to apply migrations to the PostgreSQL database.

### Running the code

Invoke `ruby bin/TASK` to run a specific task.

## Development

Install Ruby 3.1.1.

### No database

Install PostgreSQL. This is necessary for installing the `pg` gem.

Create a file called `.env` in the project's root directory:

```
DATABASE_ENV=test
```

This will run EDM Scraper using [NullDB](https://github.com/nulldb/nulldb).

### With a database

Install PostgreSQL, then create a database called `edm-scraper` and a user called `user`.

Create a file called `.env` in the project's root directory:

```
DATABASE_ENV=development
POSTAGEAPP_API_KEY=key
```

### Running the code

Invoke `ruby bin/TASK` to run a specific task.

Invoke `rake test` to run the tests once or `bundle exec guard` to rerun them every time a file changes. Invoke `rake lint` to lint the Ruby code.
