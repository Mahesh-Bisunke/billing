package com.SimpleProject.SpringCrud.Controller;

import com.SimpleProject.SpringCrud.Model.ProductModel;
import com.SimpleProject.SpringCrud.Service.ProductService;
import com.itextpdf.text.*;
import com.itextpdf.text.pdf.*;
import jakarta.servlet.http.HttpServletResponse;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

import java.io.IOException;
import java.util.List;
import java.util.stream.Stream;

@Controller
public class ProductPdfController {

    @Autowired
    private final ProductService productService;

    public ProductPdfController(ProductService productService) {
        this.productService = productService;
    }

    @GetMapping("/products/pdf")
    public void exportToPdf(HttpServletResponse response) throws IOException, DocumentException {
        response.setContentType("application/pdf");
        response.setHeader("Content-Disposition", "attachment; filename=products.pdf");

        List<ProductModel> products = productService.getAllProducts();

        Document document = new Document(PageSize.A4);
        PdfWriter.getInstance(document, response.getOutputStream());
        document.open();

        // Title
        Font titleFont = FontFactory.getFont(FontFactory.HELVETICA_BOLD, 18, BaseColor.DARK_GRAY);
        Paragraph title = new Paragraph("Products List", titleFont);
        title.setAlignment(Element.ALIGN_CENTER);
        document.add(title);
        document.add(new Paragraph(" "));

        // Table
        PdfPTable table = new PdfPTable(5);
        table.setWidthPercentage(100);
        table.setWidths(new int[]{1, 3, 5, 2, 2});

        Font headFont = FontFactory.getFont(FontFactory.HELVETICA_BOLD, 12, BaseColor.WHITE);
        Stream.of("ID", "Name", "Description", "Price", "Stock Qty").forEach(columnTitle -> {
            PdfPCell header = new PdfPCell();
            header.setBackgroundColor(new BaseColor(168, 187, 163)); // #A8BBA3
            header.setPhrase(new Phrase(columnTitle, headFont));
            header.setHorizontalAlignment(Element.ALIGN_CENTER);
            header.setPadding(8);
            table.addCell(header);
        });

        for (ProductModel p : products) {
            table.addCell(String.valueOf(p.getProductId()));
            table.addCell(p.getName());
            table.addCell(p.getDescription());
            table.addCell(String.valueOf(p.getPrice()));
            table.addCell(String.valueOf(p.getStockQuantity()));
        }

        document.add(table);
        document.close();
    }
}

