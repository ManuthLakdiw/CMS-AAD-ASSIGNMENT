package lk.ijse.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import lk.ijse.model.bean.UserBean;
import lk.ijse.model.dao.UserDao;
import org.apache.commons.dbcp2.BasicDataSource;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

/**
 * @author manuthlakdiv
 * @email manuthlakdiv2006.com
 * @project CMS
 * @github https://github.com/ManuthLakdiw
 */

@WebServlet(urlPatterns = "/allEmployees")
public class EmployeeViewServlet extends HttpServlet {

    private UserDao userDao;

    @Override
    public void init() throws ServletException {
        BasicDataSource dataSource = (BasicDataSource) getServletContext().getAttribute("dataSource");
        userDao = new UserDao(dataSource);
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession(false);
        UserBean user = (UserBean) session.getAttribute("user");

        if (user == null || user.getRole().equalsIgnoreCase("EMPLOYEE")) {
            resp.sendRedirect(req.getContextPath() + "/view/signin.jsp");
            return;
        }

        try {
            List<UserBean> allUsers = userDao.getAllUsers();
            req.setAttribute("employees", allUsers);
            req.getRequestDispatcher("/view/viewAllEmployee.jsp").forward(req, resp);

        } catch (SQLException e) {
            throw new RuntimeException(e);
        }


    }
}
