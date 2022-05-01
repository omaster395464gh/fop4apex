package de.pdv.apex;

import org.apache.fop.apps.FOUserAgent;
import org.apache.fop.apps.Fop;
import org.apache.fop.apps.FopFactory;
import org.apache.fop.apps.MimeConstants;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.xml.transform.Result;
import javax.xml.transform.Source;
import javax.xml.transform.Transformer;
import javax.xml.transform.TransformerFactory;
import javax.xml.transform.sax.SAXResult;
import javax.xml.transform.stream.StreamSource;
import java.io.*;
import java.util.logging.Level;
import java.util.logging.Logger;


/**
 * @author oliver1
 */
@WebServlet(name = "pdf", urlPatterns = {"/pdf"})
public class PdfServlet extends HttpServlet {
    private static final Logger logger = Logger.getLogger(PdfServlet.class.getName());

    private final TransformerFactory tFactory = TransformerFactory.newInstance();

    public void init() {
    }

    // <editor-fold default state="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">

    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request  servlet request
     * @param response servlet response
     */
        @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
                throws ServletException {
        logger.log(Level.FINEST,"Finest output");
        logger.log(Level.FINER,"Finer output");
        logger.log(Level.FINE,"Fine output");
        logger.log(Level.INFO,"Info output");
        logger.log(Level.INFO,"doGet");
        try {
            response.setContentType("application/pdf");
            // response.setDateHeader("Expires", System.currentTimeMillis() + cacheExpiringDuration * 1000);
            FopFactory fopFactory = FopFactory.newInstance(new File(".").toURI());
            Fop fop = fopFactory.newFop(MimeConstants.MIME_PDF, response.getOutputStream());
            Transformer transformer = tFactory.newTransformer();
            InputStream inputStream = this.getClass().getClassLoader().getResourceAsStream("samples/helloWorld.fo");
            Source src = new StreamSource(inputStream);
            Result res = new SAXResult(fop.getDefaultHandler());
            transformer.transform(src, res);
            logger.log(Level.INFO,"Process complete");
        } catch (Exception ex) {
            throw new ServletException(ex);
        }
    }


    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request  servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException {
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
            // String pdfFileName = "";

            if (request.getParameter("template") != null)
                templateFile = request.getParameter("template");
            if (request.getParameter("xml") != null)
                templateData = request.getParameter("xml");
            logger.log(Level.FINEST,"Working directory: " + (new File("dummy1.txt")).getAbsolutePath());
            logger.log(Level.FINEST,"Template file: " + templateFile);
            logger.log(Level.FINEST,"Template data: " + templateData);
            logger.log(Level.FINEST,"Content type: " + contentType);

            String pdfFileName = "Kostenblatt.pdf";
            response.setContentType("application/pdf");
            response.setHeader("Content-disposition", "attachment; filename=" + pdfFileName);
            // response.setDateHeader("Expires", System.currentTimeMillis() + cacheExpiringDuration * 1000);
            FopFactory fopFactory = FopFactory.newInstance(new File(".").toURI());
            FOUserAgent foUserAgent = fopFactory.newFOUserAgent();
            // Construct fop with desired output format
            Fop fop = fopFactory.newFop(MimeConstants.MIME_PDF, foUserAgent, response.getOutputStream());

            // Setup XSLT
            TransformerFactory factory = TransformerFactory.newInstance();
            Transformer transformer = factory.newTransformer( new StreamSource(new StringReader(templateFile)));
            // Set the value of a <param> in the stylesheet
            transformer.setParameter("versionParam", "2.0");

            // Setup input for XSLT transformation
            Source src = new StreamSource(new StringReader(templateData));

            // Resulting SAX events (the generated FO) must be piped through to FOP
            Result res = new SAXResult(fop.getDefaultHandler());

            // Start XSLT transformation and FOP processing
            transformer.transform(src, res);
            logger.log(Level.INFO,"Process complete");

        } catch (Exception e) {
            context.log(e.getMessage(), e);
            throw new ServletException(e.getMessage());
        }
        // processRequest(request, response);
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

    @Override
    public void destroy() {
    }

}