package lk.ijse.model.bean;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import java.io.Serializable;
import java.time.LocalDate;
import java.time.LocalTime;

/**
 * @author manuthlakdiv
 * @email manuthlakdiv2006.com
 * @project CMS
 * @github https://github.com/ManuthLakdiw
 */

@Setter
@Getter
@AllArgsConstructor
@NoArgsConstructor
public class ComplaintBean implements Serializable {
    private String id;
    private String employeeId;
    private String title;
    private String description;
    private LocalDate date;
    private LocalTime time;
    private String status;
}
