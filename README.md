# monoraildocker

[![License](https://img.shields.io/github/license/craftslab/monoraildocker.svg?color=brightgreen)](https://github.com/craftslab/monoraildocker/blob/main/LICENSE)
[![Tag](https://img.shields.io/github/tag/craftslab/monoraildocker.svg?color=brightgreen)](https://github.com/craftslab/monoraildocker/tags)



## Introduction

*monoraildocker* is the Monorail Docker for issue tracking.



## Build

### MySQL

```bash
cd mysql
./build.sh
```



### Monorail

```bash
cd monorail
./build.sh
```



## Deploy

```bash
./deploy.sh
```



## Access

```bash
./access.sh
```



## Reference

- [monorail](https://chromium.googlesource.com/infra/infra/+/refs/heads/main/appengine/monorail/)
- [mysql](https://hub.docker.com/_/mysql)
