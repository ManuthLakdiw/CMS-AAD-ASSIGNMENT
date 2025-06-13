create database CMS;

use CMS;

CREATE TABLE user (
            id varchar(10) PRIMARY KEY,
            name VARCHAR(100),
            email VARCHAR(100),
            user_name VARCHAR(50),
            password VARCHAR(100),
            role VARCHAR(20)
);


CREATE TABLE employee(
    id varchar(10) PRIMARY KEY,
    user_id     varchar(10),
    title       VARCHAR(200),
    description text,
    date        DATE,
    time        TIME,
    status      VARCHAR(50),
    FOREIGN KEY (user_id) REFERENCES user (id)
);



INSERT INTO user (id, name, email, user_name, password, role)
VALUES ('US00-001', 'John Doe', 'john.doe@company.com', 'johndoe', 'password123', 'admin'),
       ('US00-002', 'Jane Smith', 'jane.smith@company.com', 'janesmith', 'password456', 'employee'),
       ('US00-003', 'Mike Johnson', 'mike.johnson@company.com', 'mikejohn', 'password789', 'employee'),
       ('US00-004', 'Sarah Wilson', 'sarah.wilson@company.com', 'sarahw', 'password321', 'admin'),
       ('US00-005', 'Tom Brown', 'tom.brown@company.com', 'tombrown', 'password654', 'employee');





