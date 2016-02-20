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