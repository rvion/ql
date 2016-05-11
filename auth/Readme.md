- [] reproduire ça dans un nouveau stack nommé "auth" sur rancher via l'UI

```shell
docker run --name postgres \
  -e POSTGRES_DATABASE=keycloak \
  -e POSTGRES_USER=keycloak \
  -e POSTGRES_PASSWORD=password \
  -e POSTGRES_ROOT_PASSWORD=password \
  -d postgres
```

```shell
docker run \
  --restart always \
  --name keycloak \
  --link postgres:postgres  \
  -e POSTGRES_DATABASE=keycloak  \
  -e POSTGRES_USER=keycloak \
  -e POSTGRES_PASSWORD=password \
  -p "80:8080" \
  -d rvion/auth:1.9.3.Final
```

- [ ]
- [ ]
