
# Docker Build
docker build --file Dockerfile  --tag "****/terraform-flask-postgres-docker:test" .

# Docker Tag
docker tag "****/terraform-flask-postgres-docker:test:test" "****/terraform-flask-postgres-docker:latest"

# Docker run locally
# docker run --name my-container --hostname=0.0.0.0 --publish-all=true --privileged=true -t -i -d -e "APP_PORT=5000" -e "APP_HOME=/usr/src/app/" -e "APP_SECRET_KEY=nC5CfQ@d2jNvqrba" -e "FLASK_APP=app" -e "FLASK_ENV=dev" -e "POSTGRES_DATABASE=postgresdb" -e "POSTGRES_ENDPOINT=xxxx:5432" -e "POSTGRES_PASSWORD=xxx" -e "POSTGRES_USER=postgres" "****/terraform-flask-postgres-docker:test:latest"

# Docker push
docker push "****/terraform-flask-postgres-docker:latest"
