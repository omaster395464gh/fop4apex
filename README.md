# fop4apex
Servlet for Oracle APEX to run PDF Reports based on Apache FOP

Fahrdienst-Anwendung / Kostenblatt 

* Uses Apache FOP for rendering
https://xmlgraphics.apache.org/fop/
* Uses JavaMelody for monitoring
https://github.com/javamelody/javamelody/wiki
* Use Java 8 LTS (also tested with Java 17)
 
## Run tests
`mvn test`

## Build
`mvn package verify`

## Upgrade
* set new version in pom.xml
* check dependent libraries for updates
* run tests and build

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

### Deploy to tomcat 9.x (IntelliJ / Netbeans)
Run http://localhost:port/

Example:
* http://localhost:8080/fop4apex_war_exploded/
* http://localhost:8080/fop4apex_war_exploded/monitoring

