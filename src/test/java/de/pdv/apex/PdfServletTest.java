package de.pdv.apex;

import jakarta.servlet.ServletConfig;
import jakarta.servlet.ServletContext;
import jakarta.servlet.ServletOutputStream;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.apache.commons.io.IOUtils;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.mockito.Mock;
import org.mockito.Mockito;
import org.mockito.MockitoAnnotations;
import org.mockito.Spy;

import javax.xml.XMLConstants;
import javax.xml.transform.TransformerConfigurationException;
import javax.xml.transform.TransformerFactory;
import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import java.io.StringWriter;
import java.nio.charset.StandardCharsets;
import java.util.logging.Level;
import java.util.logging.Logger;

import static org.junit.jupiter.api.Assertions.*;

class PdfServletTest extends Mockito {
    @Spy
    private PdfServlet servlet;
    @Mock
    private ServletConfig servletConfig;
    @Mock
    private ServletContext servletContext;
    @Mock
    private HttpServletRequest request;
    @Mock
    private HttpServletResponse response;
    @Mock
    private ServletOutputStream outputStream;

    @BeforeEach
    void setUp() {
        MockitoAnnotations.openMocks(this);
    }

    @Test
    void assertThatNoMethodHasBeenCalled() {
        when(servlet.getServletConfig()).thenReturn(servletConfig);
        Mockito.verifyNoInteractions(servlet);
    }

    @Test
    void doGet() throws Exception {
        when(servlet.getServletConfig()).thenReturn(servletConfig);
        when(response.getOutputStream()).thenReturn(outputStream);
        when(response.getWriter()).thenReturn(new PrintWriter(new StringWriter()));
        servlet.doGet(request, response);
        System.out.println("Check for header %PDF-1.4%...");
        byte[] b = {0x25, 0x50, 0x44, 0x46, 0x2D, 0x31, 0x2E, 0x34, 0x0A}; //
        verify(outputStream, atLeastOnce()).write(b);
        System.out.println("Success!");
    }

    @Test
    void doPost() throws Exception {
        PdfServletTest app = new PdfServletTest();
        InputStream xsltFile = app.getClass().getClassLoader().getResourceAsStream("samples/kostenblatt_2014.xsl");
        assert xsltFile != null;
        String xsltFileContent = IOUtils.toString(xsltFile, StandardCharsets.UTF_8);
        InputStream xmlFile = app.getClass().getClassLoader().getResourceAsStream("samples/kostenblatt_2014.xml");
        assert xmlFile != null;
        String xmlFileContent = IOUtils.toString(xmlFile, StandardCharsets.UTF_8);
        when(servlet.getServletConfig()).thenReturn(servletConfig);
        when(response.getOutputStream()).thenReturn(outputStream);
        when(request.getParameter("template")).thenReturn(xsltFileContent);
        when(request.getParameter("xml")).thenReturn(xmlFileContent);
        when(response.getWriter()).thenReturn(new PrintWriter(new StringWriter()));
        servlet.doPost(request, response);
        System.out.println("Check for header %PDF-1.4%...");
        byte[] b = {0x25, 0x50, 0x44, 0x46, 0x2D, 0x31, 0x2E, 0x34, 0x0A}; //
        verify(outputStream, atLeastOnce()).write(b);
        System.out.println("Success!");
    }

    @Test
    void doPostLogsTransformationErrorWhenParametersAreMissing() throws Exception {
        Logger logger = Logger.getLogger(PdfServlet.class.getName());
        Level previousLevel = logger.getLevel();
        logger.setLevel(Level.FINEST);
        try {
            when(servlet.getServletConfig()).thenReturn(servletConfig);
            when(servlet.getServletContext()).thenReturn(servletContext);
            when(response.getOutputStream()).thenReturn(outputStream);
            when(request.getContentType()).thenReturn("text/xml");

            servlet.doPost(request, response);

            verify(request).getParameter("template");
            verify(request).getParameter("xml");
            verify(response).setContentType("application/pdf");
            verify(response).setHeader("Content-disposition", "attachment; filename=Kostenblatt.pdf");
            verify(servletContext).log(any(), any(Exception.class));
        } finally {
            logger.setLevel(previousLevel);
        }
    }

    @Test
    void doGetLogsTransformationErrorWhenOutputStreamFails() throws Exception {
        when(servlet.getServletConfig()).thenReturn(servletConfig);
        when(response.getOutputStream()).thenThrow(new IOException("stream unavailable"));

        servlet.doGet(request, response);

        verify(response).setContentType("application/pdf");
    }

    @Test
    void createSecureTransformerFactoryWrapsUnsupportedSecureProcessing() throws Exception {
        TransformerFactory factory = mock(TransformerFactory.class);
        TransformerConfigurationException cause =
                new TransformerConfigurationException("secure processing unsupported");
        doThrow(cause).when(factory).setFeature(XMLConstants.FEATURE_SECURE_PROCESSING, true);

        IllegalStateException exception = assertThrows(IllegalStateException.class,
                () -> PdfServlet.createSecureTransformerFactory(factory));

        assertEquals("Secure XML processing is not supported by TransformerFactory", exception.getMessage());
        assertSame(cause, exception.getCause());
    }

    @Test
    void createSecureTransformerFactoryWrapsUnsupportedExternalAccessRestrictions() {
        TransformerFactory factory = mock(TransformerFactory.class);
        IllegalArgumentException cause = new IllegalArgumentException("attribute unsupported");
        doThrow(cause).when(factory).setAttribute(XMLConstants.ACCESS_EXTERNAL_DTD, "");

        IllegalStateException exception = assertThrows(IllegalStateException.class,
                () -> PdfServlet.createSecureTransformerFactory(factory));

        assertEquals("External XML access restrictions are not supported by TransformerFactory", exception.getMessage());
        assertSame(cause, exception.getCause());
    }

    @Test
    void init() {
        when(servlet.getServletConfig()).thenReturn(servletConfig);
        assertNotNull(servlet);
        assertDoesNotThrow(() -> servlet.init());
    }

    @Test
    void getServletInfo() {
        when(servlet.getServletConfig()).thenReturn(servletConfig);
        String s = servlet.getServletInfo();
        assertEquals("APEX FOP Server", s);
    }
}
