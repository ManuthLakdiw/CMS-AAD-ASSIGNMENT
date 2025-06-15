package lk.ijse.controller;

import jakarta.servlet.ServletContext;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import lk.ijse.model.bean.ComplaintBean;
import lk.ijse.model.bean.UserBean;
import lk.ijse.model.dao.ComplaintDao;
import org.apache.commons.dbcp2.BasicDataSource;

import java.io.IOException;
import java.sql.SQLException;
import java.time.LocalDate;
import java.time.LocalTime;
import java.time.format.DateTimeFormatter;
import java.util.List;
import java.util.Optional;

/**
 * @author manuthlakdiv
 * @email manuthlakdiv2006.com
 * @project CMS
 * @github https://github.com/ManuthLakdiw
 */

@WebServlet(urlPatterns = "/complaint")
public class ComplaintServlet extends HttpServlet {

    private ComplaintDao complaintDao;

    @Override
    public void init() throws ServletException {
        ServletContext servletContext = getServletContext();
        BasicDataSource dataSource = (BasicDataSource) servletContext.getAttribute("dataSource");

        if (dataSource == null) {
            throw new ServletException("DataSource is not initialized in context.");
        }

        complaintDao = new ComplaintDao(dataSource);
        System.out.println("ComplaintServlet initialized successfully.");
    }




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
                req.getSession().setAttribute("message", "Complaint has been Submitted Successfully!");
                resp.sendRedirect(req.getContextPath() + "/complaint");

            }else {
                req.getSession().setAttribute("message", "Complaint has been Submitted Successfully!");
                req.getRequestDispatcher("/view/employeeDashBoard.jsp").forward(req, resp);
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }

    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        System.out.println("Get Method Called : ComplaintServlet");
        UserBean userBean = (UserBean) req.getSession().getAttribute("user");

        if (userBean == null) {
            resp.sendRedirect(req.getContextPath() + "/view/signin.jsp");
            return;
        }

        try {
            Optional<List<ComplaintBean>> complaintBeanList = complaintDao.getComplaintByEmployeeId(userBean.getId());
            if (complaintBeanList.isPresent()) {
                System.out.println("Complaint list size: " + complaintBeanList.get().size());
                req.setAttribute("complaintBeanList", complaintBeanList.get());
            } else {
                req.setAttribute("complaintBeanList", null);
            }
            req.getRequestDispatcher("/view/employeeDashBoard.jsp").forward(req, resp);

        } catch (SQLException e) {
            throw new RuntimeException(e);
        }


    }
}
