<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>Apache FOP for Oracle APEX</title>
    <style>
        body {background-color: powderblue;}
        h1   {color: blue;}
        p    {color: red;}
    </style>
</head>
<body>
<h1>JSP - Apache FOP  (Formatting Objects Processor) integration for Oracle APEX</h1>
<br/>
<%--suppress HtmlUnknownTarget --%>
<a href="pdf">pdf Servlet / Hello World / fo2pdf</a><br/>
<%--suppress HtmlUnknownTarget --%>
<a href="monitoring">JavaMelody Monitoring</a>
<h2>Sample APEX Settings</h2>
    <table>
        <thead>
        <tr>
        <td><b>Parameter</b></td>
        <td><b>Value</b></td>
        </tr>
        </thead>
        <tr>
            <td>PrintServer</td>
            <td>External (Apache FOP)</td>
        </tr>
        <tr>
            <td>Protocol</td>
            <td>HTTP / HTTPS</td>
        </tr>
        <tr>
            <td>Host</td>
            <td>127.0.0.1</td>
        </tr>
        <tr>
            <td>Port</td>
            <td>8080</td>
        </tr>
        <tr>
            <td>Script</td>
            <td>${pageContext.request.contextPath}/pdf</td>
        </tr>
        <tr>
            <td>Timeout</td>
            <td>300</td>
        </tr>
    </table>

<h2>Debugging</h2>
<span>
# Add to logging.properties<br/>
org.apache.tomcat.util.http.Parameters.level = ALL<br/>
de.pdv.apex.level = ALL
</span>

<span>
<h2>Server Info</h2>
Server Version: <%= application.getServerInfo() %><br/>
Servlet Version: <%= application.getMajorVersion() %>.<%= application.getMinorVersion() %><br/>
JSP Version: <%= JspFactory.getDefaultFactory().getEngineInfo().getSpecificationVersion() %><br/>
Web Application Context Path = ${pageContext.request.contextPath}<br/>
</span>
</body>
</html>