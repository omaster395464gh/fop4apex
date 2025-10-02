package de.pdv.apex;

import org.apache.fop.apps.FOUserAgent;
import org.apache.fop.apps.Fop;
import org.apache.fop.apps.FopFactory;
import org.apache.fop.apps.MimeConstants;
import org.apache.pdfbox.Loader;
import org.apache.pdfbox.io.RandomAccessReadBufferedFile;
import org.apache.pdfbox.pdmodel.PDDocument;
import org.junit.jupiter.api.Assertions;
import org.junit.jupiter.api.Test;

import javax.xml.XMLConstants;
import javax.xml.transform.Result;
import javax.xml.transform.Source;
import javax.xml.transform.Transformer;
import javax.xml.transform.TransformerFactory;
import javax.xml.transform.sax.SAXResult;
import javax.xml.transform.stream.StreamSource;
import java.io.File;
import java.io.InputStream;
import java.io.OutputStream;
import java.nio.file.Files;
import java.nio.file.Paths;

class ExampleXML2PDFTest {

    @Test
    void convertXML2PDF() throws Exception {
        System.out.println("FOP ExampleXML2PDF\n");
        System.out.println("Preparing...");

        // Setup directories
        File baseDir = new File(".");
        File outDir = new File(baseDir, "target");
        boolean bSuccess = outDir.mkdirs();
        if (!bSuccess)
            System.out.println("mkdirs result: false");

        ExampleXML2PDFTest app = new ExampleXML2PDFTest();
        // Setup input and output files
        InputStream xsltFile = app.getClass().getClassLoader().getResourceAsStream("samples/kostenblatt_2023_e.xsl");
        InputStream xmlFile = app.getClass().getClassLoader().getResourceAsStream("samples/kostenblatt_2023_e.xml");
        File pdfFile = new File(outDir, "ResultXML2PDF.pdf");

        System.out.println("Input: XML (" + xmlFile + ")");
        System.out.println("Stylesheet: " + xsltFile);
        System.out.println("Output: PDF (" + pdfFile + ")");
        System.out.println();
        System.out.println("Transforming...");

        // configure fopFactory as desired
        final FopFactory fopFactory = FopFactory.newInstance(new File(".").toURI());

        FOUserAgent foUserAgent = fopFactory.newFOUserAgent();
        // configure foUserAgent as desired

        // Setup output
        OutputStream out = Files.newOutputStream(Paths.get(pdfFile.toURI()));

        // Construct fop with desired output format
        Fop fop = fopFactory.newFop(MimeConstants.MIME_PDF, foUserAgent, out);

        // Setup XSLT
        TransformerFactory factory = TransformerFactory.newInstance();
        factory.setFeature(XMLConstants.FEATURE_SECURE_PROCESSING, true);
        factory.setAttribute(XMLConstants.ACCESS_EXTERNAL_DTD, "");
        factory.setAttribute(XMLConstants.ACCESS_EXTERNAL_STYLESHEET, "");

        Transformer transformer = factory.newTransformer(new StreamSource(xsltFile));

        // Set the value of a <param> in the stylesheet
        transformer.setParameter("versionParam", "2.0");

        // Setup input for XSLT transformation
        Source src = new StreamSource(xmlFile);

        // Resulting SAX events (the generated FO) must be piped through to FOP
        Result res = new SAXResult(fop.getDefaultHandler());

        // Start XSLT transformation and FOP processing
        transformer.transform(src, res);

        //close
        out.close();

        Assertions.assertTrue(pdfFile.exists(), "Error: result file missing");
        try (PDDocument document = Loader.loadPDF(new RandomAccessReadBufferedFile(pdfFile))) {
            System.out.println("Pages: " + document.getNumberOfPages());
            System.out.println("Filesize (Bytes): " + Files.size(pdfFile.toPath()));
            Assertions.assertEquals((int)1, document.getNumberOfPages());
            System.out.println("Success!");
        }
    }
}