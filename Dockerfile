FROM ruby:3.3.0-slim-bookworm

WORKDIR /maino-blog

COPY . .

RUN apt-get update && apt-get install -y --no-install-recommends build-essential curl git libpq-dev npm
RUN npm install n -g 
RUN n 20.11.0 
RUN gem install rails -v 7.1.3 
RUN rm -rf /var/lib/apt/lists/* /usr/share/doc /usr/share/man
RUN apt-get clean

CMD ["/bin/bash -l -c \"chmod +x start.sh && ./start.sh\""]
