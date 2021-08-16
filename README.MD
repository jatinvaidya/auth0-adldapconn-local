# Local Environment for Working with Auth0 AD/LDAP Connector

Sometimes we need to quickly check some behaviour with the AD/LDAP Connector. However setting the environment up with an LDAP server, data & the connector itself can be cumbersome. This repository should offer a rapid setup of the entire environment to quickly setup the connector and the corresponding LDAP environment locally.

## Prerequisites

1. Auth0 developer tenant
  
2. On your `Auth0` developer tenant, create a new `Active Directory / LDAP Enterprise Connection` named say `ldap-connection`.

3. Copy the `Provisionint Ticket Url` from the `Setup` tab for this connector configuration. We will need it in a subsequent step.

   - The URL should look like this: `https://tenant.auth0.com/p/ad/dyTLgMxLMx7qLLa0wxhuDzVw4hLwQ7HD`

## Usage

1. Clone this repository

2. `cd auth0-ldap-local-env`

3. Edit: `ldap-connector.env` and paste the `Provisioning Ticket Url` against the `PROVISIONING_TICKET` property.

4. Optional: Edit properties in `.env` files (defaults already provided)
  
5. Optional: Edit `ldif/seed.ldif` with initial sample data to load to the LDAP Server.

6. Start the services:  `docker compose up`

7. To Stop the services: `docker compose down`.

## Containers

### LDAP Server

- Seeded with custom [sample data](ldif/init.ldif)
  
- LDAP Port: 389, LDAPS: not configured

### LDAP Admin Web Console (optional)

- http://localhost:8080 (admin console)
  
- HTTP Port: 8080, HTTPS: not configured

- Login DN: cn=admin,dc=example,dc=org
  
- Password: admin
  
### Auth0 AD/LDAP Connector

- Maintains an outbound connection with the Auth0 tenant.
  
- Maintains an outbound conenction with the `ldap-server` container.

- http://localhost:8357 (admin console)

## Testing

1. Login to the Auth0 Management Dashboard & Hit `Try` button on the `ldap-connection`.

2. On the login box, enter credentials as `jdoe` and `passw0rd` (if you haven't changed the defaults from `ldif/init.ldif`).

3. You should see a success page with the profile for user `jdoe` from the `ldap-server`.

4. Here is how the full profile (including group memberships and ldap attributes) for `jdoe` looks like on my tenant.

```json
{
    "created_at": "2021-08-16T01:21:33.291Z",
    "dn": "cn=jdoe,ou=users,dc=example,dc=org",
    "family_name": "Doe",
    "given_name": "John",
    "groups": [
        "gold_members"
    ],
    "identities": [
        {
            "connection": "ldap-connection",
            "provider": "ad",
            "user_id": "ldap-connection|jdoe",
            "isSocial": false
        }
    ],
    "name": "John Doe",
    "nickname": "jdoe",
    "organizationUnits": "cn=jdoe,ou=users,dc=example,dc=org",
    "picture": "https://s.gravatar.com/avatar/a31405d272b94e5d12e9a52a665d3bfe?s=480&r=pg&d=https%3A%2F%2Fcdn.auth0.com%2Favatars%2Fjd.png",
    "updated_at": "2021-08-16T01:21:33.291Z",
    "user_id": "ad|ldap-connection|jdoe",
    "last_ip": "165.225.114.141",
    "last_login": "2021-08-16T01:21:33.290Z",
    "logins_count": 1,
    "blocked_for": [],
    "guardian_authenticators": []
}
```

## References

- [Auth0 AD LDAP Connector](https://auth0.com/docs/extensions/ad-ldap-connector)
  
- [Osixia OpenLDAP](https://www.openldap.org/)
  
- [Osixia LDAP Admin](http://phpldapadmin.sourceforge.net/wiki/index.php/Main_Page)
