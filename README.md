# unsplashr

Ruby script to fetch images from unsplash and display in chrome tab - one page, ten images at a time

## Setup
- Go sign up for an unsplash API client id
- Add client id to .env file (see .env.example)

## Usage

```bash
rvm use 2.7.2@mygemset
gem install dotenv
gem install launchy
gem install httparty
```

## Run it
Provide arguments - query string and page number.

```bash
mkdir data
ruby main.rb "half dome" 1
```