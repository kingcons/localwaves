## LocalWaves

* Currently running on: https://mighty-crag-3152.herokuapp.com/

## Authorization

Routes in the User Registration section are authenticated
by Username/Password unless otherwise mentioned.

Routes elsewhere in the app are authenticated by passing
an 'Access-Token' header along with the request.

### User Registration & Auth

#### Creating a User

**Route:** `POST /users`

**Params:**

| Parameter |  Type  |
| --------- |  ----  |
|  Email    | String |
|  Password | String |
|  City     | String |
|  State    | String |

Note that Usernames and Emails in LocalWaves must be unique.

Example success (Code 201 - Created):

```json
{
  "user": {
    "id": 7,
    "email": "foo6@bar.com",
    "username": "foo6",
    "access_token": "a1bf55c9f9a4e5002372be13fd2abb10"
  }
}
```

Example Failure (Code 422 - Unprocessable Entity):

```json
{
  "errors": [
    "Username has already been taken",
    "Email has already been taken"
  ]
}
```

#### Deleting a User

**Route:** `DELETE /user/:id`

**Params:**

| Parameter | Type   |
| --------- | ------ |
| Password  | String |

Example Success (Code 204 - No Content):

```json
```

Example Failure (Code 401 - Unauthorized):

```json
{
  "message": "Incorrect username or password."
}
```

#### Resetting a User's Access Token

**Route:** `DELETE /user/:id/token`

**Params:**

| Parameter | Type   |
| --------- | ------ |
| Password  | String |

Example Success (Code 202 - Accepted):

(Same JSON as User Creation)

Example Failure: (Code 401 - Unauthorized):

```json
{
  "message": "You don't have permission to reset token for: 'foo5'."
}
```

#### Adding OAuth Access to a User's Soundcloud Account

**NOTE:**

    This route requires coordination as to Client ID, Secret and Redirect URI
    with the Rails API user.

**Route:** `POST /users/oauth`

**Params:**

| Parameter | Type   |
| --------- | ------ |
| Code      | String |
| State     | String |

The *code* param should be an authorization code received from Soundclound.

The *state* param should be an email of a registered user.

> This endpoint is not intended to be used directly, but rather to be used as a
> redirect URI for Soundcloud API integration with a separate frontend.

Success will result in a redirect to the frontend home page.
