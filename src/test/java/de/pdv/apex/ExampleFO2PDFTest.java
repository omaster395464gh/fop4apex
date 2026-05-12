package de.pdv.apex;

import org.apache.fop.apps.*;
import org.apache.pdfbox.io.RandomAccessReadBufferedFile;
import org.apache.pdfbox.pdmodel.PDDocument;
import org.apache.pdfbox.text.PDFTextStripper;
import org.apache.pdfbox.text.PDFTextStripperByArea;
import org.junit.jupiter.api.Assertions;
import org.junit.jupiter.api.Test;

import javax.xml.XMLConstants;
import javax.xml.transform.Result;
import javax.xml.transform.Source;
import javax.xml.transform.Transformer;
import javax.xml.transform.TransformerFactory;
import javax.xml.transform.sax.SAXResult;
import javax.xml.transform.stream.StreamSource;
import java.io.*;
import java.nio.file.Files;
import java.util.List;
import org.apache.pdfbox.Loader;

class ExampleFO2PDFTest {

    // configure fopFactory as desired
    private final FopFactory fopFactory = FopFactory.newInstance(new File(".").toURI());

    /**
     * Converts an FO file to a PDF file using FOP
     *
     * @param fo  the FO file
     * @param pdf the target PDF file
     * @throws IOException In case of an I/O problem
     */
    public void convertFO2PDFHelper(InputStream fo, File pdf) throws IOException {

        FOUserAgent foUserAgent = fopFactory.newFOUserAgent();

        try (OutputStream out = new BufferedOutputStream(new FileOutputStream(pdf))) {
            Fop fop = fopFactory.newFop(MimeConstants.MIME_PDF, foUserAgent, out);

            // Setup JAXP using identity transformer
            TransformerFactory factory = TransformerFactory.newInstance();
            factory.setFeature(XMLConstants.FEATURE_SECURE_PROCESSING, true);
            factory.setAttribute(XMLConstants.ACCESS_EXTERNAL_DTD, "");
            factory.setAttribute(XMLConstants.ACCESS_EXTERNAL_STYLESHEET, "");
            Transformer transformer = factory.newTransformer(); // identity transformer

            // Setup input stream
            Source src = new StreamSource(fo);

            // Resulting SAX events (the generated FO) must be piped through to FOP
            Result res = new SAXResult(fop.getDefaultHandler());

            // Start XSLT transformation and FOP processing
            transformer.transform(src, res);

            // Result processing
            FormattingResults foResults = fop.getResults();
            @SuppressWarnings("rawtypes") List pageSequences = foResults.getPageSequences();
            for (Object pageSequence : pageSequences) {
                PageSequenceResults pageSequenceResults = (PageSequenceResults) pageSequence;
                System.out.println("PageSequence "
                        + (!String.valueOf(pageSequenceResults.getID()).isEmpty()
                        ? pageSequenceResults.getID() : "<no id>")
                        + " generated " + pageSequenceResults.getPageCount() + " pages.");
            }
            System.out.println("Generated " + foResults.getPageCount() + " pages in total.");

        } catch (Exception e) {
            throw new IOException("Error transforming FO to PDF", e);
        }

    }

    @Test
    void convertFO2PDF() throws Exception {
        System.out.println("FOP ExampleFO2PDF\n");
        System.out.println("Preparing...");

        //Setup directories
        File baseDir = new File(".");
        File outDir = new File(baseDir, "target");
        boolean bSuccess = outDir.mkdirs();
        if (!bSuccess)
            System.out.println("mkdirs result: false");

        ExampleFO2PDFTest app = new ExampleFO2PDFTest();
        //Setup input and output files
        InputStream inputStream = app.getClass().getClassLoader().getResourceAsStream("samples/helloWorld.fo");
        File pdfFile = new File(outDir, "ResultFO2PDF.pdf");

        System.out.println("Input: XSL-FO (" + inputStream + ")");
        System.out.println("Output: PDF (" + pdfFile + ")");
        System.out.println();
        System.out.println("Transforming...");

        app.convertFO2PDFHelper(inputStream, pdfFile);

        Assertions.assertTrue(pdfFile.exists(), "Error: result file missing");

        try (PDDocument document = Loader.loadPDF(new RandomAccessReadBufferedFile(pdfFile)))
        {
            if (!document.isEncrypted()) {
                PDFTextStripperByArea stripper = new PDFTextStripperByArea();
                stripper.setSortByPosition(true);
                PDFTextStripper tStripper = new PDFTextStripper();
                String pdfFileInText = tStripper.getText(document);
                String[] lines = pdfFileInText.split("\\r?\\n");
                for (String line : lines) {
                    System.out.println(line);
                }
                System.out.println("Pages: " + document.getNumberOfPages());
                Assertions.assertEquals(1, document.getNumberOfPages());
            }
        }
        System.out.println("Filesize (Bytes): " + Files.size(pdfFile.toPath()));
        System.out.println("Success!");
    }

}