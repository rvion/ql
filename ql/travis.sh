set -eux
VERSION=0.1
ls ql

echo Building:
docker run -i --rm \
  -v /cache/stack:/root/.stack \
  --volumes-from r-ci_ci-worker_data_1 \
  -w $(pwd)/ql \
  fpco/stack-build \
  stack install --local-bin-path $(pwd)/ql-prod

echo Packaging
ls ql-prod
docker build -t rvion/ql:$VERSION $(pwd)/ql-prod

echo Pushing
docker push rvion/ql:$VERSION
