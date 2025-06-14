package lk.ijse.model.bean;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import java.io.Serializable;

/**
 * @author manuthlakdiv
 * @email manuthlakdiv2006.com
 * @project CMS
 * @github https://github.com/ManuthLakdiw
 */


@AllArgsConstructor
@NoArgsConstructor
@Getter
@Setter
public class UserBean implements Serializable {
    private String id;
    private String name;
    private String email;
    private String userName;
    private String password;
    private String role;

}
