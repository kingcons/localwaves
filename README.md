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
|  Username | String |
|  Email    | String |
|  Password | String |

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

**Route:** `DELETE /user/:username`

**Params:**

| Parameter | Type   |
| --------- | ------ |
| Username  | String |
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

**Route:** `DELETE /user/:username/token`

**Params:**

| Parameter | Type   |
| --------- | ------ |
| Username  | String |
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
    with the Rails API user. Additionally, calls to this route require a
    valid Access-Token to be supplied in the request headers.

**Route:** `POST /user/:username/oauth`

**Params:**

| Parameter | Type   |
| --------- | ------ |
| Code      | String |

The *code* param should be an authorization code received from Soundclound.

Example Success (Code 201 - Created)

Example Failure (Code 422 - Unprocessable Entity)
