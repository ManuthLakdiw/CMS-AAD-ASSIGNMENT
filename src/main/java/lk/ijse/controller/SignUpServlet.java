package lk.ijse.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import lk.ijse.model.bean.UserBean;
import lk.ijse.model.dao.UserDao;
import org.mindrot.jbcrypt.BCrypt;

import java.io.IOException;
import java.sql.SQLException;

/**
 * @author manuthlakdiv
 * @email manuthlakdiv2006.com
 * @project CMS
 * @github https://github.com/ManuthLakdiw
 */
@WebServlet("/signup")
public class SignUpServlet extends HttpServlet {

    UserDao userDao = new UserDao();

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        System.out.println("Method Called : SignUpServlet");

        String fullName = req.getParameter("fullName");
        String email = req.getParameter("email");
        String password = BCrypt.hashpw(req.getParameter("password"), BCrypt.gensalt());
        String userName = req.getParameter("username");
        String role = "employee";



        try {
            String id = userDao.getNewUserId();
            System.out.println("New ID from servlet: " + id);

            UserBean userBean = new UserBean();
            userBean.setId(id);
            userBean.setName(fullName);
            userBean.setEmail(email);
            userBean.setUserName(userName);
            userBean.setPassword(password);
            userBean.setRole(role);
            boolean isSaved = userDao.saveUser(userBean);
            if(isSaved){
                req.setAttribute("message", "Registered successfully! Please login");
                req.getRequestDispatcher("/view/signup.jsp").forward(req, resp);

            }else {
                resp.sendRedirect(req.getContextPath() + "/view/signup.jsp");
            }

        } catch (SQLException e) {
            throw new RuntimeException(e);
        }








    }
}
