jenkins:
  log_driver: ''
  labels:
    io.rancher.sidekicks: data
    io.rancher.container.pull_image: always
  tty: true
  log_opt: {}
  image: rvion/ci-slave
  volumes:
  - /var/jenkins_home/:/var/jenkins_home/
  - /var/run/docker.sock:/var/run/docker.sock
  - /usr/bin/docker:/usr/bin/docker
  ports:
  - 8080:8080/tcp
  - 50000:50000/tcp
