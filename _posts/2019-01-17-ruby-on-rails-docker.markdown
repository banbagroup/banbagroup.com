---
layout: post
title:  "Dockerizing a Ruby on Rails application"
date:   "2019-01-17 07:50:41.483814"
categories: blog
excerpt: "In this tutorial, you will learn how to set up docker on your machine and dockerize a Ruby on Rails application. The application we're going to build will make use of PostgreSQL database.  After reading this article, you will have a basic idea of what Docker is, how it can help you as a developer, and how to run ruby on rails application on docker."
---
<div>In this blog you will you will learn how to set up docker on your machine and dockerize a Ruby on Rails application. The application we're going to build will make use of PostgreSQL database. &nbsp;<br><br>After reading this article, you will have a basic idea of what Docker is, how it can help you as a developer, and how to run ruby on rails application on docker.<br><br></div><h1>What is Docker?</h1><div>Docker is an open platform for developing, shipping, and running applications. Docker enables you to separate your applications from your infrastructure so you can deliver software quickly.&nbsp; With Docker, you can manage your infrastructure in the same ways you manage your applications. By taking advantage of Docker’s methodologies for shipping, testing, and deploying code quickly, you can significantly reduce the delay between writing code and running it in production.<br><br></div><h1>How is Docker Different from a Virtual Machine?</h1><div>The basic architecture of Docker containers and Virtual machines differ in their OS support. Containers are hosted in a single physical server with a host OS, which is shared among them. Virtual machines, on the&nbsp; other hand, have a host OS and individual guest OS inside each VM. Irrespective of the host OS, the guest OS can be anything – either Linux or Windows.</div><div><br>&nbsp;In Docker, since the host kernel is shared among the containers, the container technology has access to the kernel subsystems. As a result, a single vulnerable application can hack the entire host server. On the other hand, VMs are unique instances with their own kernel and security features. They can, therefore, run applications that need more privilege and security.<br><br>Docker containers are self-contained packages that can run the required application. Since they do not have a separate guest OS, they can be easily ported across different platforms. Whereas, VMs are isolated server instances with their own OS. They cannot be ported across multiple platforms without incurring compatibility issues.<br><br>Docker and Virtual machines are intended for different purposes, so it’s not fair to measure their performance equally. But their light-weight architecture makes Docker containers less resource-intensive than the virtual machines.</div><div><br></div><h1>Other Terms</h1><ul><li>Images: The file system and configuration of our application which are used to create containers.</li><li>Docker daemon: The background service running on the host that manages building, running and distributing Docker containers.</li><li>Docker client: The command line tool that allows user to interact with docker daemon.</li><li>Docker hub: A registry of Docker images. You can think of a registry is a directory of all available Docker images.</li><li>Docker compose: Compose is a tool of defining and running multi-container docker applications. With compose you use a compose file to configure your application’s services. Then, using a single command, you create and start all the services from your configuration.</li></ul><div><br></div><h1>Install Docker on Ubuntu</h1><div>Following: <a href="https://docs.docker.com/install/linux/docker-ce/ubuntu/#install-using-the-repository">https://docs.docker.com/install/linux/docker-ce/ubuntu/#install-using-the-</a></div><div><a href="https://docs.docker.com/install/linux/docker-ce/ubuntu/#install-using-the-repository">repository</a></div><pre>$ sudo apt-get update
$ sudo apt-get install \linux-images-extra-$(uname -r) \linux-images-extra-virtual</pre><div><br></div><h1>Set up the repository – Docker CE</h1><pre>$ curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
$ sudo apt-key fingerprint 0EBFCD88
$ sudo add-apt-repository \"deb [arch=amd64] https://download.docker.com/linux/ubuntu \$(lsb_release -cs) \stable"
<br></pre><h1>Install Docker CE</h1><pre>$ sudo apt-get update
$ sudo apt-get install docker-ce
$ sudo docker run hello-world
<br></pre><div>Manage Docker as non root user</div><pre>$ sudo groupadd docker
$ sudo usermod -aG docker $USER</pre><div><br>Log out and log back in (I had to restart my computer)</div><div><br></div><pre>$ docker run hello-world</pre><div><br></div><h1>Install Docker compose</h1><div>Go to <a href="https://github.com/docker/compose/releases">https://github.com/docker/compose/releases</a> for latest release.</div><div>Example:&nbsp;</div><div><br></div><pre>$ sudo curl -L "https://github.com/docker/compose/releases/download/1.23.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
$ sudo chmod +x /usr/local/bin/docker-compose
<br></pre><h1>Docker Setup On rails project</h1><div>1. Create a Dockerfile</div><pre>From ruby:2.3.3
RUN apt-get update -qq &amp;&amp; apt-get install -y build-essential libpq-dev nodejs
RUN mkdir /myappWORKDIR /myapp
ADD Gemfile /myapp/Gemfile
ADD Gemfile.lock /myapp/Gemfile.lock
RUN bundle install
ADD . /myapp</pre><div><br>2. Create a Gemfile</div><pre>source 'https://rubygems.org'
gem 'rails', '5.0.0.1'</pre><div><br>3. Create a Gemfile.lock<br><br></div><pre>$ touch Gemfile.lock</pre><div><br>4. Create docker-compose.yml file<br><br></div><pre>version: '3'
services:
  db:
    image: postgres
  web:
    build: .
    command: bundle exec rails s -p 3000 -b '0.0.0.0'
    volumes: 
      - .:/myapp
    ports: 
      - "3000:3000"    
    depends_on:
      - db
<br></pre><div>5. Generate the project</div><pre>$ docker-compose run web rails new . --force –database=postgresql</pre><div><br>6. Build the containers</div><pre>$ docker-compose build</pre><div><br>7. Update the database config/database.yml</div><div><br></div><pre>default: &amp;default    
    adapter: postgresql
    encoding: unicode
    host: db
    username: postgres
    password:    
    pool: 5

development:    
    &lt;&lt;: *default
    database: myapp_development

test:     
    &lt;&lt;: *default    
    database: myapp_development</pre><div><br>8. Create the database</div><pre>$ docker-compose run web rake db:create</pre><div><br></div><div>View the rails welcome page</div><pre>$ docker-compose up</pre><div><br>Go the http://localhost:3000 on your browser to see the rails welcome page.<br><br></div><h1>Conclusion</h1><div>Docker is awesome. Now you can run your projects on other platforms without having to worry about dependencies and platform specific gotchas.&nbsp;</div><div><br>You get an environment that’s easy to share with fellow team members, you can model it to closely resemble your production environment, and extend it in a simple way.<br><br></div><div>The best part is that it’s easy to clean up once you’re done with aproject. You don’t pollute your computer with all those different libraries you only need for that single project!<br><br><br></div><h1>Reference</h1><ul><li><a href="https://docs.docker.com/compose/rails/#view-the-rails-welcome-page">https://docs.docker.com/compose/rails/#view-the-rails-welcome-page</a></li><li><a href="https://nickjanetakis.com/blog/dockerize-a-rails-5-postgres-redis-sidekiq-action-cable-app-with-docker-compose">https://nickjanetakis.com/blog/dockerize-a-rails-5-postgres-redis-sidekiq-action-cable-app-with-docker-compose</a></li><li><a href="https://semaphoreci.com/community/tutorials/dockerizing-a-ruby-on-rails-application">https://semaphoreci.com/community/tutorials/dockerizing-a-ruby-on-rails-application</a></li></ul>