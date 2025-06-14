package lk.ijse.model.dao;

import jakarta.annotation.Resource;
import jakarta.servlet.http.HttpServlet;
import lk.ijse.model.bean.UserBean;
import util.CrudUtil;

import javax.sql.DataSource;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

/**
 * @author manuthlakdiv
 * @email manuthlakdiv2006.com
 * @project CMS
 * @github https://github.com/ManuthLakdiw
 */
public class UserDao extends HttpServlet {

    public boolean saveUser(UserBean userBean) throws SQLException {
        return CrudUtil.execute("INSERT INTO user (id, name, email, user_name, password, role) VALUES (?,?,?,?,?,?)",
                userBean.getId(),
                userBean.getName(),
                userBean.getEmail(),
                userBean.getUserName(),
                userBean.getPassword(),
                userBean.getRole()
        );
    }

    public UserBean getUser(String id) throws SQLException {
        ResultSet resultSet =  CrudUtil.execute("SELECT * FROM user WHERE id = ?",id);
        if(resultSet.next()){
            return new UserBean(resultSet.getString(1),resultSet.getString(2),resultSet.getString(3),resultSet.getString(4),resultSet.getString(5),resultSet.getString(6));
        }
        return null;
    }

    public boolean updateUser(UserBean userBean) throws SQLException {
        return CrudUtil.execute("UPDATE user SET name = ?, email = ?, user_name = ?, password = ?, role = ? WHERE id = ?",
                userBean.getName(),
                userBean.getEmail(),
                userBean.getUserName(),
                userBean.getPassword(),
                userBean.getRole(),
                userBean.getId());
    }

    public List<UserBean> getAllUsers() throws SQLException {
        List<UserBean> userBeans = new ArrayList<>();
        ResultSet resultSet =  CrudUtil.execute("SELECT * FROM user");
        while (resultSet.next()){
            UserBean userBean = new UserBean();
            userBean.setId(resultSet.getString(1));
            userBean.setName(resultSet.getString(2));
            userBean.setEmail(resultSet.getString(3));
            userBean.setUserName(resultSet.getString(4));
            userBean.setPassword(resultSet.getString(5));
            userBean.setRole(resultSet.getString(6));
            userBeans.add(userBean);
        }
        return userBeans;

    }
    public boolean deleteUser(String id) throws SQLException {
        return CrudUtil.execute("DELETE FROM user WHERE id = ?",id);
    }

    public boolean isUserExist(String id) throws SQLException {
        ResultSet resultSet = CrudUtil.execute("SELECT * FROM user WHERE id = ?",id);
        return resultSet.next();
    }

    public Optional<UserBean> getUserByUserName(String userName) throws SQLException {
        ResultSet resultSet = CrudUtil.execute("SELECT * FROM user WHERE user_name = ?", userName);

        if (resultSet.next()) {
            UserBean userBean = new UserBean();
            userBean.setId(resultSet.getString(1));
            userBean.setName(resultSet.getString(2));
            userBean.setEmail(resultSet.getString(3));
            userBean.setUserName(resultSet.getString(4));
            userBean.setPassword(resultSet.getString(5));
            userBean.setRole(resultSet.getString(6));
            return Optional.of(userBean);
        }

        return Optional.empty();
    }




    public String getNewUserId() throws SQLException {

        ResultSet resultSet = CrudUtil.execute("SELECT id FROM user ORDER BY id DESC LIMIT 1");
        if(resultSet.next()){
            String id = resultSet.getString(1); //US00-001
            System.out.println(id);
            String [] split = id.split("-");
            String prefixText = split[0]; // e.g., "US29"
            String prefixLetters = prefixText.replaceAll("[0-9]", ""); // "US"
            String prefixNumberStr = prefixText.replaceAll("[^0-9]", ""); // "29"
            int prefixNumber = Integer.parseInt(prefixNumberStr);


            int number = Integer.parseInt(split[1]);

            if (number == 999) {
                prefixNumber++;
                number = 0;
            }else{
                number++;
            }

            String newPrefix = prefixLetters + String.format("%02d", prefixNumber);
            String newId = String.format("%s-%03d", newPrefix, number);
            System.out.println("New generated ID: " + newId);
            return newId;

        }else {
            return "US00-001";

        }
    }



}
