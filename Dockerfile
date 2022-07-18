FROM debian:buster

# RUN php --version

RUN apt-get update && apt-get install --assume-yes wget

# Pre Build Commands
RUN wget https://codejudge-starter-repo-artifacts.s3.ap-south-1.amazonaws.com/backend-project/php/pre-build.sh
RUN chmod 775 ./pre-build.sh
RUN sh pre-build.sh

RUN wget https://codejudge-starter-repo-artifacts.s3.ap-south-1.amazonaws.com/backend-project/php/php-setup.sh
RUN chmod 775 ./php-setup.sh
RUN sh php-setup.sh

RUN wget https://codejudge-starter-repo-artifacts.s3.ap-south-1.amazonaws.com/backend-project/database/db-setup.sh
RUN chmod 775 ./db-setup.sh
RUN sh db-setup.sh

RUN wget https://codejudge-starter-repo-artifacts.s3.ap-south-1.amazonaws.com/backend-project/php/php-mongodb-driver.sh
RUN chmod 775 ./php-mongodb-driver.sh
RUN sh php-mongodb-driver.sh

COPY --from=composer:1.9 /usr/bin/composer /usr/local/bin/composer

COPY . /tmp/

WORKDIR /tmp/

EXPOSE 8080

RUN composer config "platform.ext-mongo" "1.6.16"

# Build the app
RUN wget https://codejudge-starter-repo-artifacts.s3.ap-south-1.amazonaws.com/backend-project/php/build.sh
RUN chmod 775 ./build.sh
RUN sh build.sh

# Add extra docker commands here (if any)...

# Run the app
RUN wget https://codejudge-starter-repo-artifacts.s3.ap-south-1.amazonaws.com/backend-project/symfony/run-2.sh
RUN chmod 775 ./run-2.sh
CMD sh run-2.sh