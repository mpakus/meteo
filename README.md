# README

![example workflow](https://github.com/mpakus/meteo/actions/workflows/ci.yml/badge.svg)

## Rails app deployed via Coolify from GitHub, with tests running on GitHub Actions CI.

Live Demo: https://meteo.aomega.co

## Requirements:

    - Must be done in Ruby on Rails
    - Accept an address as input
    - Retrieve forecast data for the given address. This should include, at minimum, the current temperature 
      (Bonus points - Retrieve high/low and/or extended forecast)
    - Display the requested forecast details to the user 
    - Cache the forecast details for 30 minutes for all subsequent requests by zip codes. 
      Display indicator if result is pulled from cache.

## Setup

### Prerequisites

- Ruby `3.4.4`
- Rails `8.1.3`
- PostgreSQL
- Bundler

### Environment variables

Create a local `.env` file using `.env.sample` and provide your information.

### Local setup

```bash
bin/setup --skip-server
```

This installs gems, prepares the database, and clears old logs/temp files.

### Run the application

```bash
bin/dev
```

## Testing

The repository includes an RSpec-based test suite with coverage for:

- model validations and behavior
- service objects
- external weather client behavior via WebMock/RSpec

### Run the test suite

```bash
RAILS_ENV=test bundle exec rspec
```

## Data Model

**Address**

- `full`
- `lat`
- `lng`
- `weather_id`

**Weather**

- `zip`
- `forecast` - [jsonb]
- `updated_at` used for cache freshness

### Current cache design

- ZIP code is the cache key in practice.
- Multiple addresses can point to the same `Weather` record.
- Freshness is currently determined by `updated_at < 30.minutes.ago` or blank forecast data.

## Design Patterns Used

### Service Object Pattern

The application uses service objects to isolate business processes:

- `Address::Create`
- `Address::UpdateWeather`
- `Weather::OpenMeteoClient`

This keeps controllers smaller and improves testability.

### Decorator Pattern

`WeatherDecorator` wraps the model to keep formatting and translation logic out.

### Thin Controller Pattern

The controller coordinates request-response behavior 
and delegates business logic to domain services 
instead of embedding workflow logic directly in controller actions.
