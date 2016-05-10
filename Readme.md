readme.md

intro
crise du logiciel
speak about paas
automatisation

1. install rancher
2. setup auth on github

speak about nosql
https://www.google.fr/search?sourceid=chrome-psyapi2&ion=1&espv=2&ie=UTF-8&q=never%20use%20mongodb&oq=never%20use%20mongo&aqs=chrome.1.69i57j0l5.5991j0j7
3. spawn postgres

speak about auth, problem openidconnet (descente de police, etc.)
4. spawn keycloak ha






https://github.com/gambol99/keycloak-proxy
bin/keycloak-proxy \
    --discovery-url=https://auth.rvion.fr/auth/realms/master \
    --client-id=jenkins \
    --secret=MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEArdGClJvxJp00Osfv31gMudEvEQlXQVZ6l9vFvziyCqjWvEzTmZxTsr/vZn/xpoce3TGAW3mHHQXKaHfOLfM7PjCJQeAsawM526HRZI8PQRyQA+5ccEttpiINn/aGi79XhG82mHAEqYYszr1gvza4xaLMoT8wdbYmZIqJRrIvNsg3mLBaLSImEFND/TNFwyuVl0PdRvLWy5EnE1+HLZVRXBOipEx+4icyNRoYaltNHr5z8KZwo8CozJrkALqVtSFoeyVua3FXoFelHgW6+kGBjyM2mlYN9GuRrc0bvJ5h1/RH2qPZVIAjSqZyQjQJ/vMGU2lJeJn+TueKDkMjm7qccwIDAQAB \
    --listen=:80 \
    --redirection-url=jenkins:8080 \
    --refresh-sessions=true \
    --encryption-key=AgXa7xRcoClDEU0ZDSH4X0XhL5Qy2Z2j \
    --resource="uri=/" \

    --upstream=http://127.0.0.1:80 \


### jenkins options

docker run \
  --restart always \
  --name keycloak \
  --link postgres:postgres  \
  -e POSTGRES_DATABASE=keycloak  \
  -e POSTGRES_USER=keycloak \
  -e POSTGRES_PASSWORD=password \
  -p "80:8080" \
  -d rvion/auth:0.19.1


```
build-pipeline-plugin
copyartifact
parameterized-trigger
git-parameter
mask-passwords
```

http://nathanleclaire.com/blog/2014/07/12/10-docker-tips-and-tricks-that-will-make-you-sing-a-whale-song-of-joy/
https://hub.docker.com/r/evarga/jenkins-slave/~/dockerfile/
evarga/jenkins-slave

https://docs.docker.com/engine/examples/running_ssh_service/

apt-get update && apt-get install -y openssh-server
mkdir /var/run/sshd
echo 'root:pass' | chpasswd
sed -i 's/PermitRootLogin without-password/PermitRootLogin yes/' /etc/ssh/sshd_config
sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd
/usr/sbin/sshd -D
### build command:

https://wiki.jenkins-ci.org/display/JENKINS/GitHub+Plugin#GitHubPlugin-GithubPlugin
