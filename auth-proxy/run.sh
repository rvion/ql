
docker run -it --rm -p "8843:8843" rvion/keycloak-proxy:v1.0.6 \
    --discovery-url=https://auth.rvion.fr/auth/realms/master/.well-known/openid-configuration \
    --listen=:8843 \
    --client-id=jenkins \
    --skip-upstream-tls-verify=true \
    --upstream-url=http://upstream-nocf.rvion.fr/bin \
    --redirection-url=https://keycloakproxy-cf.rvion.fr:8843/ \
    --client-secret=MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEArdGClJvxJp00Osfv31gMudEvEQlXQVZ6l9vFvziyCqjWvEzTmZxTsr/vZn/xpoce3TGAW3mHHQXKaHfOLfM7PjCJQeAsawM526HRZI8PQRyQA+5ccEttpiINn/aGi79XhG82mHAEqYYszr1gvza4xaLMoT8wdbYmZIqJRrIvNsg3mLBaLSImEFND/TNFwyuVl0PdRvLWy5EnE1+HLZVRXBOipEx+4icyNRoYaltNHr5z8KZwo8CozJrkALqVtSFoeyVua3FXoFelHgW6+kGBjyM2mlYN9GuRrc0bvJ5h1/RH2qPZVIAjSqZyQjQJ/vMGU2lJeJn+TueKDkMjm7qccwIDAQAB \
    --resource="uri=/" \
    --secure-cookie=false \
    --encryption-key=AgXa7xRcoClDEU0ZDSH4X0XhL5Qy2Z2j \
    --enable-refresh-tokens=true \
    --verbose=true
