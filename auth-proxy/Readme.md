adapt this stuff

```shell
docker run -it --rm -p "8843:8843" rvion/keycloak-proxy:v1.0.6 \
    --discovery-url=https://auth.rvion.fr/auth/realms/master/.well-known/openid-configuration \
    --listen=:8843 \
    --client-id=jenkins \
    --skip-upstream-tls-verify=true \
    --upstream-url=http://upstream-nocf.rvion.fr/bin \
    --redirection-url=https://keycloakproxy-cf.rvion.fr:8843/ \
    --client-secret=youhouhou \
    --resource="uri=/" \
    --secure-cookie=false \
    --encryption-key=AgXa7xRcoClDEU0ZDSH4X0XhL5Qy2Z2j \
    --enable-refresh-tokens=true \
    --verbose=true
```
