package listner;

import jakarta.servlet.ServletContext;
import jakarta.servlet.ServletContextEvent;
import jakarta.servlet.ServletContextListener;
import jakarta.servlet.annotation.WebListener;
import jakarta.servlet.annotation.WebServlet;
import org.apache.commons.dbcp2.BasicDataSource;

import java.sql.SQLException;

/**
 * @author manuthlakdiv
 * @email manuthlakdiv2006.com
 * @project CMS
 * @github https://github.com/ManuthLakdiw
 */
@WebListener
public class ContextListener implements ServletContextListener {

    @Override
    public void contextInitialized(ServletContextEvent sce) {
        BasicDataSource dataSource = new BasicDataSource();
        dataSource.setDriverClassName("com.mysql.cj.jdbc.Driver");
        dataSource.setUrl("jdbc:mysql://localhost:3306/CMS");
        dataSource.setUsername("root");
        dataSource.setPassword("Manu2006");
        dataSource.setInitialSize(5);
        dataSource.setMaxTotal(50);

        ServletContext servletContext = sce.getServletContext();
        servletContext.setAttribute("dataSource", dataSource);

    }

    @Override
    public void contextDestroyed(ServletContextEvent sce) {
        ServletContext servletContext = sce.getServletContext();
        BasicDataSource dataSource = (BasicDataSource) servletContext.getAttribute("dataSource");
        try {
            dataSource.close();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }
}
