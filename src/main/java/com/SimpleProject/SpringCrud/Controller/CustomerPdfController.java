package com.SimpleProject.SpringCrud.Controller;

import com.SimpleProject.SpringCrud.Model.CustomerModel;
import com.SimpleProject.SpringCrud.Service.CustomerService;
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
public class CustomerPdfController {

    @Autowired
    private final CustomerService customerService;

    public CustomerPdfController(CustomerService customerService) {
        this.customerService = customerService;
    }

    @GetMapping("/customers/pdf")
    public void exportToPdf(HttpServletResponse response) throws IOException, DocumentException {
        response.setContentType("application/pdf");
        response.setHeader("Content-Disposition", "attachment; filename=customers.pdf");

        List<CustomerModel> customers = customerService.getAllCustomers();

        Document document = new Document(PageSize.A4);
        PdfWriter.getInstance(document, response.getOutputStream());
        document.open();

        // Title
        Font titleFont = FontFactory.getFont(FontFactory.HELVETICA_BOLD, 18, BaseColor.DARK_GRAY);
        Paragraph title = new Paragraph("Customer List", titleFont);
        title.setAlignment(Element.ALIGN_CENTER);
        document.add(title);
        document.add(new Paragraph(" "));

        // Table
        PdfPTable table = new PdfPTable(5);
        table.setWidthPercentage(100);
        table.setWidths(new int[]{1, 3, 4, 3, 4});

        Font headFont = FontFactory.getFont(FontFactory.HELVETICA_BOLD, 12, BaseColor.WHITE);
        Stream.of("ID", "Name", "Email", "Phone", "Address").forEach(columnTitle -> {
            PdfPCell header = new PdfPCell();
            header.setBackgroundColor(new BaseColor(168, 187, 163));
            header.setPhrase(new Phrase(columnTitle, headFont));
            header.setHorizontalAlignment(Element.ALIGN_CENTER);
            header.setPadding(8);
            table.addCell(header);
        });

        for (CustomerModel c : customers) {
            table.addCell(String.valueOf(c.getCustomerId()));
            table.addCell(c.getName());
            table.addCell(c.getEmail());
            table.addCell(c.getPhone());
            table.addCell(c.getAddress());
        }

        document.add(table);
        document.close();
    }
}

