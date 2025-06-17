package lk.ijse.model.dao;

import jakarta.annotation.Resource;
import lk.ijse.model.bean.ComplaintBean;
import org.apache.commons.dbcp2.BasicDataSource;
import util.CrudUtil;

import javax.sql.DataSource;
import java.sql.Connection;
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
public class ComplaintDao {

    private BasicDataSource dataSource;

    public ComplaintDao(BasicDataSource dataSource) {
        this.dataSource = dataSource;
    }

//    @Resource(name = "jdbc/cms")
//    public void setDataSource(DataSource dataSource) {
//        this.dataSource = (BasicDataSource) dataSource;
//    }
    public boolean saveComplaint(ComplaintBean complaintBean) throws SQLException {
        
        try(Connection connection = dataSource.getConnection()) {
            return CrudUtil.execute(connection,"INSERT INTO complaint (id, title, description, date, time, status, employee_id) VALUES (?, ?, ?, ?, ?, ?, ?)",
                    complaintBean.getId(),
                    complaintBean.getTitle(),
                    complaintBean.getDescription(),
                    complaintBean.getDate(),
                    complaintBean.getTime(),
                    complaintBean.getStatus(),
                    complaintBean.getEmployeeId()
            );
        }
        
    }
    
    public Optional<ComplaintBean> getComplaint(String id) throws SQLException {
        
        try(Connection connection = dataSource.getConnection();
            ResultSet resultSet = CrudUtil.execute(connection,"SELECT * FROM complaint WHERE id = ?", id);
            ) {
            if (resultSet.next()) {
                ComplaintBean complaintBean = new ComplaintBean();

                complaintBean.setId(resultSet.getString(1));
                complaintBean.setTitle(resultSet.getString(3));
                complaintBean.setDescription(resultSet.getString(4));
                complaintBean.setDate(resultSet.getDate(5).toLocalDate());
                complaintBean.setTime(resultSet.getTime(6).toLocalTime());
                complaintBean.setStatus(resultSet.getString(7));
                complaintBean.setEmployeeId(resultSet.getString(2));
                return Optional.of(complaintBean);
            }
            return Optional.empty();
        }
    }

    public Optional<List<ComplaintBean>> getComplaintByEmployeeId(String employeeId) throws SQLException {
        List<ComplaintBean> complaintBeans = new ArrayList<>();
        
        try(Connection connection = dataSource.getConnection();
            ResultSet resultSet = CrudUtil.execute(connection,"SELECT * FROM complaint WHERE employee_id = ?", employeeId);
            ) {
            while (resultSet.next()) {
                ComplaintBean complaintBean = new ComplaintBean();

                complaintBean.setId(resultSet.getString(1));
                complaintBean.setTitle(resultSet.getString(3));
                complaintBean.setDescription(resultSet.getString(4));
                complaintBean.setDate(resultSet.getDate(5).toLocalDate());
                complaintBean.setTime(resultSet.getTime(6).toLocalTime());
                complaintBean.setStatus(resultSet.getString(7));
                complaintBean.setEmployeeId(resultSet.getString(2));
                complaintBeans.add(complaintBean);
            }
            return Optional.ofNullable(complaintBeans);
            
        }
    }

    public Optional<List<ComplaintBean>> getAllComplaints() throws SQLException {
        List<ComplaintBean> complaintBeans = new ArrayList<>();

        try (Connection connection = dataSource.getConnection();
             ResultSet resultSet = CrudUtil.execute(connection, "SELECT * FROM complaint")
        ) {
            while (resultSet.next()) {
                ComplaintBean complaintBean = new ComplaintBean();
                complaintBean.setId(resultSet.getString(1));
                complaintBean.setTitle(resultSet.getString(3));
                complaintBean.setDescription(resultSet.getString(4));
                complaintBean.setDate(resultSet.getDate(5).toLocalDate());
                complaintBean.setTime(resultSet.getTime(6).toLocalTime());
                complaintBean.setStatus(resultSet.getString(7));
                complaintBean.setEmployeeId(resultSet.getString(2));
                complaintBeans.add(complaintBean);
            }
            return Optional.ofNullable(complaintBeans);
        }
    }
    
    public boolean isComplaintExist(String id) throws SQLException {
        
        try (Connection connection = dataSource.getConnection();
             ResultSet resultSet = CrudUtil.execute(connection,"SELECT * FROM complaint WHERE id = ?", id);
        ) {
            return resultSet.next();
        }
    }

    public boolean updateComplaint(ComplaintBean complaintBean) throws SQLException {
        try (Connection connection = dataSource.getConnection()) {
            return CrudUtil.execute(connection, "UPDATE complaint SET title = ?, description = ?, date = ?, time = ?, status = ?, employee_id = ? WHERE id = ?",
                    complaintBean.getTitle(),
                    complaintBean.getDescription(),
                    complaintBean.getDate(),
                    complaintBean.getTime(),
                    complaintBean.getStatus(),
                    complaintBean.getEmployeeId(),
                    complaintBean.getId()
            );
        }
    }

    public boolean deleteComplaint(String id) throws SQLException {
        try (Connection connection = dataSource.getConnection()) {
            return CrudUtil.execute(connection, "DELETE FROM complaint WHERE id = ?", id);
        }
    }


    public String generateNewComplaintId() throws SQLException {
        try (Connection connection = dataSource.getConnection();
             ResultSet resultSet = CrudUtil.execute(connection, "SELECT id FROM complaint ORDER BY id DESC LIMIT 1")
        ) {
            if (resultSet.next()) {
                String lastID = resultSet.getString(1);
                String[] parts = lastID.split("-");

                String prefix = parts[0];      // CMP00
                int suffixNumber = Integer.parseInt(parts[1]);

                // Extract letters and number from prefix  
                String prefixLetters = prefix.replaceAll("[0-9]", "");
                String prefixNumberStr = prefix.replaceAll("[^0-9]", "");
                int prefixNumber = Integer.parseInt(prefixNumberStr);

                if (suffixNumber == 999) {
                    prefixNumber++;
                    suffixNumber = 1;
                } else {
                    suffixNumber++;
                }

                String newPrefix = prefixLetters + String.format("%02d", prefixNumber);
                String newId = String.format("%s-%03d", newPrefix, suffixNumber);

                return newId;
            }

            return "CMP00-001";
        }
    }


   public boolean updateComplaintStatus(String complaintId, String status) throws SQLException {
        try (Connection connection = dataSource.getConnection()) {
            return CrudUtil.execute(connection, "UPDATE complaint SET status = ? WHERE id = ?", status, complaintId);
        }

   }



}
