FROM ruby:2.6.3
ENV app /app
    
RUN mkdir $app
RUN apt-get update \
    && apt-get install -y nginx nano \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* \
    && echo "daemon off;" >> /etc/nginx/nginx.conf \
    && gem install bundler
WORKDIR $app

ADD . $app
RUN bundle install && bundle exec jekyll build \
    && ls -alR _site/blog \
    && cp -R _site/* /var/www/html/ \
    && cp -R public/ /var/www/html/ \
    && cp -R _site/blog.html /var/www/html/blog/index.html \
    && mv nginx.conf /etc/nginx/sites-available/default
    

EXPOSE 80
CMD ["nginx"]
