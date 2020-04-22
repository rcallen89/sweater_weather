## Sweater Weather
---

### Weather Forecasting API

This is a RESTful API that manages endpoints that provide detailed weather forecasts based on location as well as predictive information based on travel plans based around trip time.

### Production

All endpoints are available via the live app at

`https://aqueous-cliffs-02019.herokuapp.com/api/v1/`

### Setup

To explore the API and what it can offer locally:

1. Clone down the repo
2. In the directory run `bundle install`, `rake db:{create,migrate}`, `figaro install`
3. Aquire the required API keys and apply them to the `application.yml` in the config directory:
  * Open Weather One
  * Geocoding and Directions from Google Maps
  * Unsplash
4. Run `rails s`

### Endpoints
---

#### User Creation

`POST /api/v1/users` with the following fields sent through in the body of the request
* email
* password
* password_confirmation

This will return a JSON formatted response with the new User's email and assigned API Key.

```
"data": {
   "id": "1",
   "type": "user",
   "attributes": {
         "email": "test@example.com",
         "api_key": "iGJ7gAVXYToAJ6GBseTyzHRk"
         }
     }
```

400 level errors are returned if not sent properly.

#### Session Retrieval

`POST /api/v1/session` with the user's email and password sent through in the body of the request.

This will return the same response of User Creation if the user is authenticated properly.

#### Forecast

`GET /api/v1/forecast` with parameters of `location=CITY_NAME`.

The detailed response will include JSON API standard formatted information regarding the current weather for the location, as well as 8 hours of hourly information, and 7 days worth of forecasted weather.  All timecodes are in UNIX.

##### Current Response
---
```
"id": null,
        "type": "forecast",
        "attributes": {
            "current_weather": {
                "dt": 1587566460,
                "sunrise": 1587556535,
                "sunset": 1587603764,
                "temp": 71.62,
                "feels_like": 74.3,
                "humidity": 88,
                "uvi": 7.98,
                "visibility": 2816,
                "weather": [
                    {
                        "id": 500,
                        "main": "Rain",
                        "description": "light rain",
                        "icon": "10d"
                    },
                    {
                        "id": 701,
                        "main": "Mist",
                        "description": "mist",
                        "icon": "50d"
                    }
                ],
                "min": 71.33,
                "max": 85.12
            }
```

##### Hourly Response
---
```
"1587571200": {
                    "temp": 75.24,
                    "weather": [
                        {
                            "id": 500,
                            "main": "Rain",
                            "description": "light rain",
                            "icon": "10d"
                        }
                    ]
                }
```

##### Daily Response
---
```
                "1587751200": {
                    "high_temp": 93.87,
                    "low_temp": 66.11,
                    "weather": [
                        {
                            "id": 800,
                            "main": "Clear",
                            "description": "clear sky",
                            "icon": "01d"
                        }
                    ],
                    "rain": null
                },
```

#### Destination Based Forecasting

The API also has an endpoint available to return trip information from an origin city to a destination city with travel time and forecasted weather upon arrival.

`POST /api/v1/road_trip` In the body of this request send the following:
* `trip_data[origin]
* `trip_data[destination]`
* `trip_data[api_key]`

A successful response will return

```
        "data": {
            "id": null,
            "type": "road_trip",
            "attributes": {
                "origin": "Denver, CO",
                "destination": "Pueblo, CO",
                "travel_time": "1 hour 48 mins",
                "arrival_forcast": [
                    66.29,
                    "Clouds"
                ]
            }
        }
```

Any invalid request will return 400 level status codes.
