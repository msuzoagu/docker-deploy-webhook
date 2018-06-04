FROM node:8-alpine

## To specify passwords/paths/etc
##  -Set ENV values in this dockerfile, OR
##  -Set the _FILE vars to read the values from Docker Secrets, etc
##  -You can set the vars here, with the Docker run command, or in a Docker compose/stack file

# Port to run on
ENV PORT=3000

#  Which configuration in the config.json file to load
ENV CONFIG="production"

# Location of config.json
ENV CONFIG_DIR=/usr/src/app/config/
ENV CONFIG_FILE=config.json

# Github Settings - optionally used to pull the config file
# ENV GITHUB_TOKEN

# Don't add https:// here
# ENV GITHUB_URL=github.com/org/repo.git

# A token used to restrict access to the webhook
# ENV TOKEN="123-456-ABC-DEF"

# Docker Hub account username
# ENV USERNAME="docker-hub-username"

# Docker Hub account password
# ENV PASSWORD="docker-hub-password"

## OR specify files containing the values

# ENV TOKEN_FILE=/run/secrets/token
# ENV USERNAME_FILE=/run/secrets/username
# ENV PASSWORD_FILE=/run/secrets/password

# SSL Settings - optional
# ENV SSL_CERT_FILE=/path/to/ssl_cert_file
# ENV SSL_KEY_FILE=/path/to/ssl_key_file

# Enable Frontend (experimental - not recommended for production)
ENV ENABLE_FRONTEND=false

EXPOSE ${PORT}

RUN apk update && apk add docker && apk add git

WORKDIR /usr/src/app/

# If GITHUB_TOKEN & GITHUB_URL are set, entrypoint script will pull config file
COPY scripts/fetchConfigFromGithub.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/fetchConfigFromGithub.sh

# install packages before copying code to take advantage of image layer caching
COPY package.json .
COPY npm-shrinkwrap.json .
RUN npm install --unsafe-perm

# copy everything else
COPY . .


ENTRYPOINT ["/usr/local/bin/fetchConfigFromGithub.sh"]
CMD [ "npm", "start" ]