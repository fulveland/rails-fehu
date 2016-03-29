# Fehu

Stinks. On Rails.

# Todo

Totem Perf
  Hide rows that are out of the viewport
  On desktop, we need 5 totem items
  On mobile, we need 3
  
Wholesale
  Made to order — no stocks
  
  Email Freyja when an order is delivered
    the body of the email is the linesheet

  
## Dev
Here be the needed env vars:

```
ASSET_HOST=http://www.rails-fehu.dev
DOMAIN=www.frails.dev
IMAGEPATH=/product-images/
PORT=3000
POSTMARK_API_KEY=(secret — get from Postmark)
RACK_ENV=development
RAILS_ENV=development
S3_PATH=https://d8bjlz07mgiyc.cloudfront.net
SECRET_KEY_BASE=(rake secret)
SKYLIGHT_AUTHENTICATION=(secret — get from Skylight)
STINKCODE=s
STINKNAME=(rake secret)
STRIPE_KEY=(secret — get from stripe)
```



# Development

### To erase and rebuild the Development DB:
```bash
pg_ctl restart -m fast && rake db:drop db:create db:migrate db:seed
```


# Staging


### To erase and rebuild the Staging DB:
```bash
heroku pg:reset DATABASE --remote staging --confirm fehu-staging
heroku run rake db:migrate db:seed --remote staging
```



# Deployment

### Config Vars
```
ASSET_HOST=https://d2z3gzdp2lgn3a.cloudfront.net
DATABASE_URL=(secret — get from Heroku Postgres)
DOMAIN=www.fehuleather.com
ERROR_PAGE_URL=https://d8bjlz07mgiyc.cloudfront.net/rails/static/error.html
IMAGEPATH=https://d8bjlz07mgiyc.cloudfront.net/rails/products/
MAINTENANCE_PAGE_URL=https://d8bjlz07mgiyc.cloudfront.net/rails/static/maintenance.html
MAX_THREADS=1
MIN_THREADS=1
PORT=3000
POSTMARK_API_KEY=(secret — get from Postmark)
S3_PATH=https://d8bjlz07mgiyc.cloudfront.net
SECRET_KEY_BASE=(rake secret)
SKYLIGHT_AUTHENTICATION=(secret — get from Skylight)
STINKCODE=(rake secret)
STINKNAME=(rake secret)
STRIPE_KEY=(secret — get from stripe)
WEB_CONCURRENCY=3
```



### To erase and rebuild the Production DB:
```bash
heroku pg:reset DATABASE --app fehu --confirm fehu
heroku run rake db:migrate db:seed --app fehu
```

### Maintenance Mode
```bash
heroku maintenance:on
# Later...
heroku maintenance:off
```
