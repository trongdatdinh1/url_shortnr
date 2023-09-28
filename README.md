# Prerequisite
- You have docker and docker-compose installed on your computer

# Setup
1. On project root directory, run: `cp .env.example .env`
1. Build project: `docker-compose build`
1. Run `docker-compose up -d` to start the project on background
1. Open url_shortnr-web-1 bash `docker exec -it url_shortnr-web-1 bash`
  - `rails db:create` create the database
  - `rails db:migrate` run db migrations

# APIs manual

## Signin User
POST /api/v1/users/sign_in

Body:
```
{
  "user": {
    "email": "user@example.com",
    "password": "password"
    }
}
```

Responses:
- Code 200:
```
Header
Authorization    "Bearer ABCDEFG12345678"


Body
{
  "user": {
    "id": [number],
    "email": "[string]",
    "name": "[string]",
    "username": "[string]",
    "first_name": "[string]",
    "last_name": "[string]",
    "uid": "[string]",
    "provider": "[string]",
    "created_at": "[date]",
    "updated_at": "[date]"
  }
}
```

- Code 4xx:
```
{
  "error": "Invalid login credentials. Please try again."
}
```


## Create URL
POST /api/v1/shorten.json

Header:
```
Authorization    "Bearer ABCDEFG12345678"
```

Body:
```
{
  "original": "[some site url]"
}
```


Responses:
- Code 200:
```
{
  "data": {
    "original": "[some site url]",
    "short": "[random string]"
  }
}
```

- Code 4xx:
```
{
  "errors": {
    "original": [
      "[error message]"
    ]
  }
}
```


# Flow
1. Signin user
2. As authenticated user, shorten the url
3. Go to http://<domain>/[short]
  - domain: your domain
  - short: value of `short` field that was generated in step 2
4.
  - If the value exists in db, redirect to the original site
  - Otherwise redirect to root page

# Example
You can test it out in: http://34.201.251.93/

# Some thought
- I decided to use [rails_api_base](https://github.com/rootstrap/rails_api_base) since this gem provides a boilerplate project for JSON RESTful APIs. It also provides authentication feature so that I only have to focus on writing CORE features of the system. It really makes my life easier. Thank you, rails_api_base team!
- The only concern that I'm having is: If the URL's `short` field is 5-character long, it means with the combination of 62 characters [A-Z, a-z, 0-9], we can serve 62^5 = 916132832 (~912 millions) urls. `Shortener.call` function which regenerates new string if the generated string already exists in database. Imagine, when there is only 1 string left, the function will execute database query again and again (to check the existance) until it could generate that last string.
-> The solution for this one is simple: extend the string `short` to 10-character long or more.
- In real life situation, we could write shorten url function in AWS Lambda for calculation (also reducing the maintainance cost) and use AWS DynamoDB to store the data for faster qerying (I only know AWS cloud provider).

# Thank you
