package de.pdv.apex;

import org.apache.fop.apps.FOUserAgent;
import org.apache.fop.apps.Fop;
import org.apache.fop.apps.FopFactory;
import org.apache.fop.apps.MimeConstants;
import org.apache.pdfbox.pdmodel.PDDocument;
import org.junit.jupiter.api.Test;

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
        InputStream xsltFile = app.getClass().getClassLoader().getResourceAsStream("samples/kostenblatt_2014.xsl");
        InputStream xmlFile = app.getClass().getClassLoader().getResourceAsStream("samples/kostenblatt_2014.xml");
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
        OutputStream out = new java.io.FileOutputStream(pdfFile);
        out = new java.io.BufferedOutputStream(out);

        // Construct fop with desired output format
        Fop fop = fopFactory.newFop(MimeConstants.MIME_PDF, foUserAgent, out);

        // Setup XSLT
        TransformerFactory factory = TransformerFactory.newInstance();
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

        if (!pdfFile.exists())
            throw new Exception("result file missing");

        PDDocument document = PDDocument.load(pdfFile);
        System.out.println("Pages: " + document.getNumberOfPages());
        System.out.println("Filesize (Bytes): " + Files.size(pdfFile.toPath()));
        System.out.println("Success!");
    }
}