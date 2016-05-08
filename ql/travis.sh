set -eux
docker run -i --rm \
  -v /cache/stack:/root/.stack \
  -v /cache/bin:/root/.local/bin \
  --volumes-from r-ci_ci-worker_data_1 \
  -w $(pwd)/ql \
  fpco/stack-build \
  stack install

# stack path
#
#   global-stack-root: /root/.stack
#   project-root: /foo
#   config-location: /foo/stack.yaml
#   ok        bin-path: /root/.stack/snapshots/x86_64-linux/lts-5.15/7.10.3/bin:/opt/host/bin:/opt/stackage/lts-5/extra/bin:/opt/stackage/lts-5/ghc/bin:/opt/stackage/lts-5/tools/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
#   ok        ghc-paths: /root/.stack/programs/x86_64-linux
#   local-bin-path: /root/.local/bin
#   extra-include-dirs:
#   extra-library-dirs:
#   ok        snapshot-pkg-db: /root/.stack/snapshots/x86_64-linux/lts-5.15/7.10.3/pkgdb
#   local-pkg-db: /foo/.stack-work/install/x86_64-linux/lts-5.15/7.10.3/pkgdb
#   global-pkg-db: /opt/stackage/lts-5/ghc/lib/ghc-7.10.3/package.conf.d
#   ok        ghc-package-path: /foo/.stack-work/install/x86_64-linux/lts-5.15/7.10.3/pkgdb:/root/.stack/snapshots/x86_64-linux/lts-5.15/7.10.3/pkgdb:/opt/stackage/lts-5/ghc/lib/ghc-7.10.3/package.conf.d
#   ok        snapshot-install-root: /root/.stack/snapshots/x86_64-linux/lts-5.15/7.10.3
#   local-install-root: /foo/.stack-work/install/x86_64-linux/lts-5.15/7.10.3
#   ok        snapshot-doc-root: /root/.stack/snapshots/x86_64-linux/lts-5.15/7.10.3/doc
#   local-doc-root: /foo/.stack-work/install/x86_64-linux/lts-5.15/7.10.3/doc
#   dist-dir: .stack-work/dist/x86_64-linux/Cabal-1.22.5.0
#   local-hpc-root: /foo/.stack-work/install/x86_64-linux/lts-5.15/7.10.3/hpc
