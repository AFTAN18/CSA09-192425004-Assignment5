CREATE TABLE IF NOT EXISTS student (
    reg_no VARCHAR(20) PRIMARY KEY,
    name VARCHAR(100) NOT NULL
) ENGINE=InnoDB;
CREATE TABLE IF NOT EXISTS wallet (
    id INT PRIMARY KEY,
    balance BIGINT NOT NULL CHECK (balance >= 0)
) ENGINE=InnoDB;
CREATE TABLE IF NOT EXISTS users (
    id VARCHAR(40) PRIMARY KEY,
    pwd VARCHAR(80) NOT NULL
) ENGINE=InnoDB;
CREATE TABLE IF NOT EXISTS bus_pass (
    pass_id VARCHAR(24) PRIMARY KEY,
    reg_no VARCHAR(20) NOT NULL,
    name VARCHAR(100) NOT NULL,
    route INT NOT NULL CHECK (route > 0),
    amount DECIMAL(10,2) NOT NULL CHECK (amount >= 0),
    boarding_stop VARCHAR(100) NOT NULL DEFAULT 'Unspecified',
    valid_until DATE,
    INDEX ix_route (route, pass_id)
) ENGINE=InnoDB;
