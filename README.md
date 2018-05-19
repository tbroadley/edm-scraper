# EDM Scraper

Scripts for:
- Scraping lists of concerts from several websites
- Storing the scraped shows in a database
- Compiling new shows into an email, sent using PostageApp

The project is hosted on [Heroku](https://dashboard.heroku.com/apps/edm-scraper).

## Development

Install PostgreSQL, then create a database called `edm-scraper` and a user called `user`.

Create a file called `.env` in the project's root directory. This contains environment variables in the format `KEY=VALUE`. For example:

```
DATABASE_ENV=development
POSTAGEAPP_API_KEY=key
```

Invoke `ruby bin/TASK` to run a specific task.

Invoke `rake test` to run the tests once or `bundle exec guard` to rerun them every time a file changes.
