build-dev:
  docker build -f dockerfile-dev -t ashimjk/angular-example:dev .

run-dev:
  docker run -v ${PWD}:/app -v /app/node_modules -p 4200:4200 --rm ashimjk/angular-example:dev

run-test:
  docker exec -it ashimjk/angular-example:dev ng test --watch=false

run-e2e:
  docker exec -it ashimjk/angular-example:dev ng e2e --port 4200

stop:
  docker stop ashimjk/angular-example:dev

compose-build:
  docker-compose up -d --build

compose-test:
  docker-compose exec ashimjk/angular-example ng test --watch=false

compose-e2e:
  docker-compose exec ashimjk/angular-example ng e2e --port 4202

compose-stop:
  docker-compose stop

build-prod:
  docker build -f dockerfile-prod -t ashimjk/angular-example:prod .

run-prod:
  docker run -it -p 9090:80 --rm ashimjk/angular-example:prod

compose-build-prod:
  docker-compose -f docker-compose-prod.yml up -d --build

push:
  docker push ashimjk/angular-example:prod

build-prod-clean:
  docker build -f dockerfile-prod-clean -t ashimjk/angular-example:prod .
