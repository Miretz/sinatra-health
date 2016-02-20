# Sinatra Java Healtcheck script

This tool is ideal for DevOps teams.
It's a small sinatra script which can be bundled into a war and then deployed on most JavaEE servers. 

Modify the sinatra-health.rb 

Requirements:
```
sudo gem install sinatra warbler haml
```

To run locally using ruby:
```
ruby sinatra-health.rb 
```

To build a war:
```
warble war
```

Deploy this war file to Tomcat (/webapps) and check:
```
http://localhost:8080/sinatra-health/health
```