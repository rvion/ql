ci-worker:
  ports:
  - 2222:22/tcp
  log_driver: ''
  labels:
    io.rancher.sidekicks: data
    io.rancher.container.pull_image: always
  tty: true
  log_opt: {}
  image: rvion/ci-slave
  volumes:
  - /var/run/docker.sock:/var/run/docker.sock
  - /usr/bin/docker:/usr/bin/docker
  volumes_from:
  - data
  stdin_open: true
