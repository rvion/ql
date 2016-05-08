readme.md

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


okok

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
