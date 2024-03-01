# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:
  This is test project.
```
  Request:
    GET /data
    JSON params:
    {
        "url": "https://www.alza.cz/aeg-7000-prosteam-lfr73964cc-d7635493.htm",
        "fields": {
            "price": ".price-box__price",
            "rating_count": ".ratingCount",
            "rating_value": ".ratingValue"
        }
    }
  Response:
    {
        "price": "18290,-",
        "rating_value": "4,9",
        "rating_count": "7 hodnocení"
    }

---------------------------

    Request:
    {
        "url": "https://www.alza.cz/aeg-7000-prosteam-lfr73964cc-d7635493.htm",
        "fields": {
            "meta": ["keywords", "twitter:image"]
         }   
    }
    Response:
    {
        "meta": {
            "keywords": "Parní pračka AEG 7000 ProSteam® LFR73964CC na www.alza.cz. ✅
            Bezpečný nákup. ✅ Veškeré informace o produktu. ✅ Vhodné příslušenství. ✅ Hodnocení
            a recenze AEG...",
            "twitter:image": "https"://image.alza.cz/products/AEGPR065/AEGPR065.jpg?
            width=360&height=360"
        }
    }

Can we check the response data for keywords?

```

* Ruby version
  Ruby version is 3.0.0

* System dependencies

* Configuration

* Database creation
  We don't need database configration

* Database initialization

* How to run the test suite
  run the script `rspec` to test it

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...
