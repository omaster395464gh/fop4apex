package de.pdv.apex;

import jakarta.servlet.ServletException;
import org.apache.commons.io.IOUtils;
import static org.junit.jupiter.api.Assertions.*;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.mockito.Mock;
import org.mockito.Mockito;
import org.mockito.MockitoAnnotations;
import org.mockito.Spy;

import jakarta.servlet.ServletConfig;
import jakarta.servlet.ServletOutputStream;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.InputStream;
import java.io.PrintWriter;
import java.io.StringWriter;
import java.nio.charset.StandardCharsets;

class PdfServletTest extends Mockito {
    @Spy  private PdfServlet servlet;
    @Mock private ServletConfig servletConfig;
    @Mock private HttpServletRequest request;
    @Mock private HttpServletResponse response;
    @Mock private ServletOutputStream outputStream;

    @BeforeEach
    public void setUp() {
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
        servlet.init();
        servlet.doGet(request, response);
        System.out.println("Check for header %PDF-1.4%...");
        byte[] b = {0x25,0x50,0x44,0x46,0x2D,0x31,0x2E,0x34,0x0A}; //
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
        servlet.init();
        servlet.doPost(request, response);
        System.out.println("Check for header %PDF-1.4%...");
        byte[] b = {0x25,0x50,0x44,0x46,0x2D,0x31,0x2E,0x34,0x0A}; //
        verify(outputStream, atLeastOnce()).write(b);
        System.out.println("Success!");
    }

    @Test
    void init() throws ServletException {
        when(servlet.getServletConfig()).thenReturn(servletConfig);
        assertNotNull(servlet);
        servlet.init();
        assertDoesNotThrow( () -> servlet.init());
    }

    @Test
    void getServletInfo() {
        when(servlet.getServletConfig()).thenReturn(servletConfig);
        String s = servlet.getServletInfo();
        assertEquals("APEX FOP Server",s);
    }
}
