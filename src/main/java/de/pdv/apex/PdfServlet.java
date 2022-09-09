package de.pdv.apex;

import org.apache.fop.apps.FOUserAgent;
import org.apache.fop.apps.Fop;
import org.apache.fop.apps.FopFactory;
import static org.apache.xmlgraphics.util.MimeConstants.MIME_PDF;

import javax.servlet.ServletContext;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
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

    private static final TransformerFactory tFactory = TransformerFactory.newInstance();

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
            FopFactory fopFactory = FopFactory.newInstance(new File(".").toURI());
            Fop fop = fopFactory.newFop(MIME_PDF, response.getOutputStream());
            Transformer transformer = tFactory.newTransformer();
            InputStream inputStream = this.getClass().getClassLoader().getResourceAsStream("samples/helloWorld.fo");
            Source src = new StreamSource(inputStream);
            Result res = new SAXResult(fop.getDefaultHandler());
            transformer.transform(src, res);
            logger.log(Level.INFO,"Process complete");
        } catch (Exception ex) {
            logger.log(Level.SEVERE,String.format("Error while processing fop transformation %s", ex.getMessage()));
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

            FopFactory fopFactory = FopFactory.newInstance(new File(".").toURI());

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
            context.log(ex.getMessage(), ex);
            logger.log(Level.SEVERE,String.format("Error while processing fop transformation %s", ex.getMessage()));
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