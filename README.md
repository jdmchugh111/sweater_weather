# README

This repo is a REST API built with rails. It consumes json from the [MapQuest API]([https://developer.mapquest.com/]) and [Weather API]([https://www.weatherapi.com/]) to give weather data for a given city, give roadtrip info for an origin and destination (with weather at your eta), and also allows for user sign up/log in and api key authentication.

## Learning Goals of This Project

- Expose an API that aggregates data from multiple external APIs
- Expose an API that requires an authentication token
- Expose an API for CRUD functionality
- Determine completion criteria based on the needs of other developers
- Test both API consumption and exposure, making use of at least one mocking tool (VCR, Webmock, etc)

## Setup Instructions

- (Fork) and Clone this repo
- run `bundle install`
- run `rails db:{drop,create,migrate}`
- to use routes in development enivornment (through Postman or some other tool), run `rails s` and use `http://localhost:3000` as your base url

## API Endpoints

### GET /api/v1/forecast?location={location}

Returns current weather, hourly weather, and next 5 days forecast.
<br><br>
**Example Request**
```
http://localhost:3000/api/v1/forecast?location=boston,ma
```
**Example Response**
```
{
    "data": {
        "id": null,
        "type": "forecast",
        "attributes": {
            "current_weather": {
                "last_updated": "2024-08-06 15:00",
                "temperature": 65.8,
                "feels_like": 65.8,
                "humidity": 91,
                "uvi": 4.0,
                "visibility": 6.0,
                "condition": "Patchy rain nearby",
                "icon": "//cdn.weatherapi.com/weather/64x64/day/176.png"
            },
            "daily_weather": [
                {
                    "date": "2024-08-07",
                    "sunrise": "05:44 AM",
                    "sunset": "07:56 PM",
                    "max_temp": 66.2,
                    "min_temp": 59.8,
                    "condition": "Heavy rain",
                    "icon": "//cdn.weatherapi.com/weather/64x64/day/308.png"
                },
                {
                    "date": "2024-08-08",
                    "sunrise": "05:45 AM",
                    "sunset": "07:54 PM",
                    "max_temp": 72.8,
                    "min_temp": 57.6,
                    "condition": "Sunny",
                    "icon": "//cdn.weatherapi.com/weather/64x64/day/113.png"
                }, ...
            ],
            "hourly_weather": [
                {
                    "time": "2024-08-06 00:00",
                    "temperature": 73.1,
                    "condition": "Partly Cloudy ",
                    "icon": "//cdn.weatherapi.com/weather/64x64/night/116.png"
                },
                {
                    "time": "2024-08-06 01:00",
                    "temperature": 72.2,
                    "condition": "Patchy rain nearby",
                    "icon": "//cdn.weatherapi.com/weather/64x64/night/176.png"
                }, ...
            ]
        }
    }
}
```
### POST /api/v1/users

Create a new user by entering email, password, and password_confirmation in the request body - returns new api key
<br><br>
**Example Request**
```
http://localhost:3000/api/v1/users
{
  "email": "jd123@example.com",
  "password": "password",
  "password_confirmation": "password"
}
```
**Example Response**
```
{
    "data": {
        "id": "4",
        "type": "user",
        "attributes": {
            "email": "jd1234@example.com",
            "api_key": "bd60846e7bacfd8ce895b1935288a70d"
        }
    }
}
```
### POST /api/v1/sessions
Log in user and get api key that was created during user creation
<br><br>
**Example Request**
```
http://localhost:3000/api/v1/sessions
{
  "email": "jd123@example.com",
  "password": "password"
}
```
**Example Response**
```
{
    "data": {
        "id": "3",
        "type": "user",
        "attributes": {
            "email": "jd123@example.com",
            "api_key": "1e2fb4aa624334cb04ce0a2e1987fd41"
        }
    }
}
```
### POST /api/v1/road_trip
Returns road trip data and weather at time of arrival
<br><br>
**Example Request**
```
http://localhost:3000/api/v1/road_trip
{
  "origin": "New York, NY",
  "destination": "Buffalo, NY",
  "api_key": "9a76adf994b04e20cab4b6ccf76440c6"
}
```
**Example Response**
```
{
    "data": {
        "id": null,
        "type": "road_trip",
        "attributes": {
            "start_city": "New York, NY",
            "end_city": "Buffalo, NY",
            "travel_time": "05:54:35",
            "weather_at_eta": {
                "datetime": "2024-08-06 21:00",
                "temperature": 59.5,
                "condition": "Partly Cloudy "
            }
        }
    }
}
```
