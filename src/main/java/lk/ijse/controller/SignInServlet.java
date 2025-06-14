package lk.ijse.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import lk.ijse.model.bean.UserBean;
import lk.ijse.model.dao.UserDao;
import org.mindrot.jbcrypt.BCrypt;

import java.io.DataOutput;
import java.io.IOException;
import java.sql.SQLException;
import java.util.Optional;

/**
 * @author manuthlakdiv
 * @email manuthlakdiv2006.com
 * @project CMS
 * @github https://github.com/ManuthLakdiw
 */
@WebServlet("/signin")
public class SignInServlet extends HttpServlet {

    UserDao userDao = new UserDao();

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        String userName = req.getParameter("username");
        String password = req.getParameter("password");

        try {
            Optional<UserBean> user = userDao.getUserByUserName(userName);
            if(user.isPresent()){
                UserBean userBean = user.get();
                boolean isPasswordCorrect = BCrypt.checkpw(password, userBean.getPassword());
                boolean isUserNameCorrect = userName.equals(userBean.getUserName());

                if(isPasswordCorrect && isUserNameCorrect){
                    HttpSession session = req.getSession();
                    session.setAttribute("user", userBean);
                    if ("employee".equalsIgnoreCase(userBean.getRole())) {
                        resp.sendRedirect(req.getContextPath() + "/view/employeeDashBoard.jsp");
                    } else {
                        resp.sendRedirect(req.getContextPath() + "/view/adminDashboard.jsp");
                    }
                } else {
                    req.setAttribute("message", "Invalid Credentials");
                    req.getRequestDispatcher("/view/signin.jsp").forward(req, resp);
                }
            } else {
                req.setAttribute("message", "Invalid Credentials");
                req.getRequestDispatcher("/view/signin.jsp").forward(req, resp);
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }
}

