# fop4apex [![Quality Gate Status](https://sonarcloud.io/api/project_badges/measure?project=omaster395464gh_fop4apex&metric=alert_status)](https://sonarcloud.io/summary/new_code?id=omaster395464gh_fop4apex)[![Technical Debt](https://sonarcloud.io/api/project_badges/measure?project=omaster395464gh_fop4apex&metric=sqale_index)](https://sonarcloud.io/summary/new_code?id=omaster395464gh_fop4apex)  

Servlet for Oracle APEX to run PDF Reports based on Apache FOP

Fahrdienst-Anwendung / Kostenblatt 

* Uses Apache FOP for rendering
https://xmlgraphics.apache.org/fop/
* Uses JavaMelody for monitoring
https://github.com/javamelody/javamelody/wiki
* Use Java 17 LTS (also tested with Java 21 LTS)
* Use Tomcat 10.1.x+ (Jakarta EE / Servlet 6.0)  or Jetty 12
## Run tests
`mvn test`

## Build
`mvn package verify`

## Upgrade
* set new version in pom.xml
* check dependent libraries for updates
* run tests and build

## Release
* create a tag with version number
* create a github release

## Installation
* rename target/fop4apex*.war to fop4apex.war
* copy fop4apex.war to tomcat webapps folder
* Oracle APEX - Sample Settings
  * PrintServer	External (Apache FOP)
  * Protocol	HTTP / HTTPS
  * Host	127.0.0.1
  * Port	8080
  * Script: /fop4apex/pdf
  * Timeout 300
### Debugging
Add to Tomcat logging.properties:
```
org.apache.tomcat.util.http.Parameters.level = ALL
de.pdv.apex.level = ALL
```

### Deploy to tomcat 10.1.x+ or Jetty 12 (IntelliJ / Netbeans)
Run http://localhost:port/

Example:
* http://localhost:8080/fop4apex_war_exploded/
* http://localhost:8080/fop4apex_war_exploded/monitoring

