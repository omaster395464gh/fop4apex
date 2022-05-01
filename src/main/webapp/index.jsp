<!doctype html>
<html lang="en" data-theme="dark">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="Apache Formatting Objects Processor integration for Oracle Application Express, converts xml and fop to pdf">
    <link rel="stylesheet" href="webjars/pico/css/pico.min.css">
    <title>Apache FOP for Oracle APEX</title>
</head>
<body>
<main class="container">
    <hgroup>
        <h1>Apache FOP integration for Oracle APEX</h1>
        <h2>FOP = Formatting Objects Processor</h2>
    </hgroup>
    <ul>
        <li>Demo: <a href="pdf" data-tooltip="Run pdf servlet with demo data">pdf servlet / fo2pdf</a></li>
        <li>Monitoring: <a href="monitoring" data-tooltip="Go to JavaMelody Monitoring page">JavaMelody</a></li>
    </ul>

    <!-- <a href="pdf">pdf Servlet / Hello World / fo2pdf</a><br/> -->
    <%--suppress HtmlUnknownTarget --%>
    <!-- <a href="monitoring">JavaMelody Monitoring</a> -->
    <hgroup>
        <h2>Sample APEX Settings</h2>
        <h3>Internal Workspace / Instance Settings / Report Printing</h3>
    </hgroup>
    <table role="grid">
        <thead>
        <tr>
            <th scope="col">Parameter</th>
            <th scope="col">Value</th>
        </tr>
        </thead>
        <tr>
            <th scope="row">PrintServer</th>
            <td>External (Apache FOP)</td>
        </tr>
        <tr>
            <th scope="row">Protocol</th>
            <td>HTTP / HTTPS</td>
        </tr>
        <tr>
            <th scope="row">Host</th>
            <td>127.0.0.1</td>
        </tr>
        <tr>
            <th scope="row">Port</th>
            <td>8080</td>
        </tr>
        <tr>
            <th scope="row">Script</th>
            <td>${pageContext.request.contextPath}/pdf</td>
        </tr>
        <tr>
            <td>Timeout</td>
            <td>300</td>
        </tr>
    </table>

    <hgroup>
        <h2>Debugging</h2>
        <h3>Add to tomcat conf/logging.properties</h3>
    </hgroup>
    <pre>org.apache.tomcat.util.http.Parameters.level = ALL
de.pdv.apex.level = ALL</pre>

    <h2>Server Info / Environment</h2>
<%--@elvariable id="System" type=""--%>
    <pre>
Server Version:   <%= application.getServerInfo() %>
Servlet Version:  <%= application.getMajorVersion() %>.<%= application.getMinorVersion() %>
JSP Version:      <%= JspFactory.getDefaultFactory().getEngineInfo().getSpecificationVersion() %>
Context Path:     ${pageContext.request.contextPath}

java.version:     ${System.getProperty("java.version")}
java.vm.vendor:   ${System.getProperty("java.vm.vendor")}
user.country:     ${System.getProperty("user.country")}
user.language:    ${System.getProperty("user.language")}
user.name:        ${System.getProperty("user.name")}
user.timezone:    ${System.getProperty("user.timezone")}
os.name:          ${System.getProperty("os.name")}
os.version:       ${System.getProperty("os.version")}
file.encoding:    ${System.getProperty("file.encoding")}
sun.jnu.encoding: ${System.getProperty("sun.jnu.encoding")}</pre>
    <p>page build with <a href="https://picocss.com/">Pico.css</a>, fop conversion with <a href="https://xmlgraphics.apache.org/fop/">Apache FOP</a> </p>
</main>
</body>
</html>