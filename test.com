upstream unicornnginx {
  server unix:/home/paniotov/ruby/UnicornNginx/tmp/sockets/unicorn.sock fail_timeout=0;
}

server {
   listen 80;# default deferred;
   server_name loc;
   root /home/paniotov/ruby/UnicornNginx/public;
   try_files $uri/index.html $uri @unicornnginx;

location @unicornnginx {
   proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
   proxy_set_header Host $http_host;
   proxy_redirect off;
   proxy_pass http://unicornnginx;
}

error_page 500 502 503 504 /500.html;
  client_max_body_size 4G;
   keepalive_timeout 10;
}

