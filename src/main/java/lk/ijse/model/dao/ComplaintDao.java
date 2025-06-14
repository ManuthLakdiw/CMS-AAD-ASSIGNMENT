package lk.ijse.model.dao;

import lk.ijse.model.bean.ComplaintBean;
import util.CrudUtil;

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

    public boolean saveComplaint(ComplaintBean complaintBean) throws SQLException {
        return CrudUtil.execute("INSERT INTO complaint (id, title, description, date, time, status, employee_id) VALUES (?, ?, ?, ?, ?, ?, ?)",
                complaintBean.getId(),
                complaintBean.getTitle(),
                complaintBean.getDescription(),
                complaintBean.getDate(),
                complaintBean.getTime(),
                complaintBean.getStatus(),
                complaintBean.getEmployeeId()
        );
    }
    
    public Optional<ComplaintBean> getComplaint(String id) throws SQLException {
        ResultSet resultSet = CrudUtil.execute("SELECT * FROM complaint WHERE id = ?", id);
        if (resultSet.next()) {
            ComplaintBean complaintBean = new ComplaintBean();
            
            complaintBean.setId(resultSet.getString(1));
            complaintBean.setTitle(resultSet.getString(2));
            complaintBean.setDescription(resultSet.getString(3));
            complaintBean.setDate(resultSet.getDate(4).toLocalDate());
            complaintBean.setTime(resultSet.getTime(5).toLocalTime());
            complaintBean.setStatus(resultSet.getString(6));
            complaintBean.setEmployeeId(resultSet.getString(7));
            return Optional.of(complaintBean);
        }
        return Optional.empty();
    }

    public Optional<List<ComplaintBean>> getComplaintByEmployeeId(String employeeId) throws SQLException {
        List<ComplaintBean> complaintBeans = new ArrayList<>();
        ResultSet resultSet = CrudUtil.execute("SELECT * FROM complaint WHERE employee_id = ?", employeeId);
        while (resultSet.next()) {
            ComplaintBean complaintBean = new ComplaintBean();

            complaintBean.setId(resultSet.getString(1));
            complaintBean.setTitle(resultSet.getString(2));
            complaintBean.setDescription(resultSet.getString(3));
            complaintBean.setDate(resultSet.getDate(4).toLocalDate());
            complaintBean.setTime(resultSet.getTime(5).toLocalTime());
            complaintBean.setStatus(resultSet.getString(6));
            complaintBean.setEmployeeId(resultSet.getString(7));
            complaintBeans.add(complaintBean);
            return Optional.of(complaintBeans);
        }
        return Optional.empty();
    }

    public Optional<List<ComplaintBean>> getAllComplaints() throws SQLException {
        List<ComplaintBean> complaintBeans = new ArrayList<>();
        ResultSet resultSet = CrudUtil.execute("SELECT * FROM complaint");
        while (resultSet.next()) {
            ComplaintBean complaintBean = new ComplaintBean();
            complaintBean.setId(resultSet.getString(1));
            complaintBean.setTitle(resultSet.getString(2));
            complaintBean.setDescription(resultSet.getString(3));
            complaintBean.setDate(resultSet.getDate(4).toLocalDate());
            complaintBean.setTime(resultSet.getTime(5).toLocalTime());
            complaintBean.setStatus(resultSet.getString(6));
            complaintBean.setEmployeeId(resultSet.getString(7));
            complaintBeans.add(complaintBean);
            return Optional.of(complaintBeans);
        }
        return Optional.empty();
    }

    
    public boolean isComplaintExist(String id) throws SQLException {
        ResultSet resultSet = CrudUtil.execute("SELECT * FROM complaint WHERE id = ?", id);
        return resultSet.next();
    }
    
    public boolean updateComplaint(ComplaintBean complaintBean) throws SQLException {
        return CrudUtil.execute("UPDATE complaint SET title = ?, description = ?, date = ?, time = ?, status = ?, employee_id = ? WHERE id = ?",
                complaintBean.getTitle(),
                complaintBean.getDescription(),
                complaintBean.getDate(),
                complaintBean.getTime(),
                complaintBean.getStatus(),
                complaintBean.getEmployeeId(),
                complaintBean.getId()
        );
    }

    public boolean deleteComplaint(String id) throws SQLException {
        return CrudUtil.execute("DELETE FROM complaint WHERE id = ?", id);
    }


    public String generateNewComplaintId() throws SQLException {
        ResultSet resultSet = CrudUtil.execute("SELECT id FROM complaint ORDER BY id DESC LIMIT 1");

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
