package lk.ijse.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import lk.ijse.model.bean.ComplaintBean;
import lk.ijse.model.dao.ComplaintDao;

import java.io.IOException;
import java.sql.SQLException;
import java.time.LocalDate;
import java.time.LocalTime;
import java.time.format.DateTimeFormatter;

/**
 * @author manuthlakdiv
 * @email manuthlakdiv2006.com
 * @project CMS
 * @github https://github.com/ManuthLakdiw
 */

@WebServlet(urlPatterns = "/complaint")
public class ComplaintServlet extends HttpServlet {

    ComplaintDao complaintDao = new ComplaintDao();

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String title = req.getParameter("title");
        String description = req.getParameter("description");
        LocalDate date = LocalDate.now();
        LocalTime time = LocalTime.now();
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("HH:mm:ss");
        String formattedTime = time.format(formatter);
        String status = "Pending";
        String employeeId = req.getParameter("employeeId");


        try {
            String complaintID = complaintDao.generateNewComplaintId();
            ComplaintBean complaintBean = new ComplaintBean();
            complaintBean.setId(complaintID);
            complaintBean.setTitle(title);
            complaintBean.setDescription(description);
            complaintBean.setDate(date);
            complaintBean.setTime(LocalTime.parse(formattedTime));
            complaintBean.setStatus(status);
            complaintBean.setEmployeeId(employeeId);

            boolean isSaved = complaintDao.saveComplaint(complaintBean);
            if(isSaved){
                req.setAttribute("message", "Complaint has been Submitted Successfully!");
                req.getRequestDispatcher("/view/complaint.jsp").forward(req, resp);
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }


    }
}
