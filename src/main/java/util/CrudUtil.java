package util;

import jakarta.annotation.Resource;

import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

/**
 * @author manuthlakdiv
 * @email manuthlakdiv2006.com
 * @project CMS
 * @github https://github.com/ManuthLakdiw
 */
public class CrudUtil {

//    @Resource(name = "java:comp/env/jdbc/pool")
    private static final DataSource dataSource;

    static {
        try {
            InitialContext context = new InitialContext();
            dataSource = (DataSource) context.lookup("java:comp/env/jdbc/pool");
        } catch (NamingException e) {
            throw new RuntimeException(e);
        }
    }

    
    public static <T>T execute(String sql, Object...obj) throws SQLException {
        Connection connection = dataSource.getConnection();

        PreparedStatement preparedStatement = connection.prepareStatement(sql);
        for (int i = 0; i < obj.length; i++) {
            preparedStatement.setObject(i+1,obj[i]);
        }

        if(sql.startsWith("SELECT") || sql.startsWith("select")){
            return (T) preparedStatement.executeQuery();
        }else {
            int i = preparedStatement.executeUpdate();
            boolean isSaved = i > 0;
            return (T) ((Boolean) isSaved);
        }


    }



}
