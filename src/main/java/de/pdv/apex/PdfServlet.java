package de.pdv.apex;

import jakarta.servlet.ServletException;
import org.apache.fop.apps.FOUserAgent;
import org.apache.fop.apps.Fop;
import org.apache.fop.apps.FopFactory;
import static org.apache.xmlgraphics.util.MimeConstants.MIME_PDF;

import jakarta.servlet.ServletContext;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import javax.xml.XMLConstants;
import javax.xml.transform.*;
import javax.xml.transform.sax.SAXResult;
import javax.xml.transform.stream.StreamSource;
import java.io.File;
import java.io.InputStream;
import java.io.StringReader;
import java.util.logging.Level;
import java.util.logging.Logger;


/**
 * @author oliver1
 */
@WebServlet(name = "pdf", urlPatterns = {"/pdf"})
public class PdfServlet extends HttpServlet {
    private static final Logger logger = Logger.getLogger(PdfServlet.class.getName());
    private static FopFactory fopFactory;
    private static final TransformerFactory tFactory = TransformerFactory.newInstance();

    /**
     * Init the servlet and setup TransformerFactory
     */
    @Override
    public void init() throws ServletException {
        // Java 25 may need old parser
        System.setProperty("javax.xml.parsers.SAXParserFactory",
                "com.sun.org.apache.xerces.internal.jaxp.SAXParserFactoryImpl");
        System.setProperty("org.xml.sax.driver",
                "com.sun.org.apache.xerces.internal.parsers.SAXParser");
        try {
            tFactory.setFeature(XMLConstants.FEATURE_SECURE_PROCESSING, true);
            tFactory.setAttribute(XMLConstants.ACCESS_EXTERNAL_DTD, "");
            tFactory.setAttribute(XMLConstants.ACCESS_EXTERNAL_STYLESHEET, "");
            //tFactory.setFeature(XMLConstants.ACCESS_EXTERNAL_SCHEMA, false);
            logger.info("TransformerFactory configured with FEATURE_SECURE_PROCESSING and without ACCESS_EXTERNAL_DTD/ACCESS_EXTERNAL_STYLESHEET");
        } catch (TransformerConfigurationException e) {
            logger.warning(String.format("TransformerConfigurationException while setup TransformerFactory - possible security issue: %s", e.getMessage()));
        }
        try {
            synchronized (PdfServlet.class) {
                if (fopFactory == null) {
                    fopFactory = FopFactory.newInstance(new File(".").toURI());

                    // 🔑 Preload event-model.xml: Dummy Fop anlegen
                    FOUserAgent foUserAgent = fopFactory.newFOUserAgent();
                    try (java.io.ByteArrayOutputStream dummyOut = new java.io.ByteArrayOutputStream()) {
                        fopFactory.newFop(MIME_PDF, foUserAgent, dummyOut);
                    } catch (Exception e) {
                        logger.warning("FOP preload failed (can be ignored if once-only): " + e.getMessage());
                    }
                }
            }
        } catch (Exception e) {
            throw new ServletException("FOP init failed", e);
        }


    }

    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request  servlet request
     * @param response servlet response
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) {
        logger.log(Level.FINEST,"Finest output");
        logger.log(Level.FINER,"Finer output");
        logger.log(Level.FINE,"Fine output");
        logger.log(Level.INFO,"Info output");
        logger.log(Level.INFO,"doGet");
        try {
            response.setContentType("application/pdf");
            Fop fop = fopFactory.newFop(MIME_PDF, response.getOutputStream());
            Transformer transformer = tFactory.newTransformer();
            InputStream inputStream = this.getClass().getClassLoader().getResourceAsStream("samples/helloWorld.fo");
            Source src = new StreamSource(inputStream);
            Result res = new SAXResult(fop.getDefaultHandler());
            transformer.transform(src, res);
            logger.log(Level.INFO,"Process complete");
        } catch (Exception ex) {
            logger.log(Level.SEVERE,String.format("Error while processing fop transformation %s", ex));
        }
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request  servlet request
     * @param response servlet response
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) {
        ServletContext context = getServletContext();
        logger.log(Level.FINEST,"Finest output");
        logger.log(Level.FINER,"Finer output");
        logger.log(Level.FINE,"Fine output");
        logger.log(Level.INFO,"Info output");
        logger.log(Level.INFO,"doPost");
        try {
            String contentType = request.getContentType();
            String templateFile = "template.fo";
            String templateData = "xml data";

            if (request.getParameter("template") != null)
                templateFile = request.getParameter("template");
            if (request.getParameter("xml") != null)
                templateData = request.getParameter("xml");

            if (logger.isLoggable(Level.FINEST)) {
                logger.log(Level.FINEST, String.format("Working directory: %s", new File("dummy1.txt").getAbsolutePath()));
                logger.log(Level.FINEST, String.format("Template file length: %s", templateFile.length()));
                logger.log(Level.FINEST, String.format("Template data length: %s", templateData.length()));
                logger.log(Level.FINEST, String.format("Content type:  %s", contentType));
            }

            String pdfFileName = "Kostenblatt.pdf";
            response.setContentType("application/pdf");
            response.setHeader("Content-disposition", "attachment; filename=" + pdfFileName);

            FOUserAgent foUserAgent = fopFactory.newFOUserAgent();
            // Construct fop with desired output format
            Fop fop = fopFactory.newFop(MIME_PDF, foUserAgent, response.getOutputStream());
            Transformer transformer = tFactory.newTransformer( new StreamSource(new StringReader(templateFile)));
            // Set the value of a <param> in the stylesheet
            transformer.setParameter("versionParam", "2.0");

            // Setup input for XSLT transformation
            Source src = new StreamSource(new StringReader(templateData));

            // Resulting SAX events (the generated FO) must be piped through to FOP
            Result res = new SAXResult(fop.getDefaultHandler());

            // Start XSLT transformation and FOP processing
            transformer.transform(src, res);
            logger.log(Level.INFO,"Process complete");

        } catch (Exception ex) {
            if (context != null) {
                context.log(ex.getMessage(), ex);
            }
            logger.log(Level.SEVERE,String.format("Error while processing fop transformation %s", ex));
        }
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "APEX FOP Server";
    }// </editor-fold>

}