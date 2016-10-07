#!/bin/sh
# this is a very simple script that tests the docker configuration for cookiecutter-django
# it is meant to be run from the root directory of the repository, eg:
# sh tests/test_docker.sh

# install test requirements
pip install -r requirements.txt

# create a cache directory
mkdir -p .cache/docker
cd .cache/docker

# create the project using the default settings in cookiecutter.json
cookiecutter ../../ --no-input --overwrite-if-exists
cd project_name

# run the project's tests
#docker-compose -f dev.yml run django python manage.py test
#check_and_exit_if_error

# return non-zero status code if there are migrations that have not been created
docker-compose -f dev.yml run django python manage.py makemigrations --dry-run --check || { echo "there were changes, but the corresponding migration have not been created"; exit 1; }
