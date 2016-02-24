# Sinatra Java Healtcheck

This tool is ideal for DevOps teams.
It's a small sinatra app which can be bundled into a war and then deployed on most JavaEE servers. 

Modify the sinatra-health.rb 

Requirements:
```
sudo gem install sinatra warbler haml
```

##Run as Sinatra app

To run locally using ruby:
```
ruby sinatra-health.rb 
```
Navigate to:
```
http://localhost:4567/health
```

##Deploy as War

To build a war:
```
warble war
```

Deploy this war file to Tomcat (/webapps) and check:
```
http://localhost:8080/sinatra-health/health
```

_Tested on Apache Tomcat 7.0.47 running on Java version 1.8.0_73_

##REST API

Get urls as JSON array
```
GET /health/urls
```

Add a new URL to list
```
POST /health/urls
{"url":"http://www.google.com"}
```

DELETE URL from the list
```
DELETE /health/urls
{"url":"http://www.google.com"}
```

##TODO
* Templates
* Persist list of URLs
* Secure Rest API
* Test War on other JavaEE servers & Java versions


