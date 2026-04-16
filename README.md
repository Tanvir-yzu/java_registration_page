# Registration System

A modern, full-featured user registration and authentication web application built with Java Servlet, JSP, JDBC, and MySQL.

![Registration System](https://img.shields.io/badge/Java-8+-blue.svg)
![MySQL](https://img.shields.io/badge/MySQL-8.0+-orange.svg)
![Tomcat](https://img.shields.io/badge/Apache%20Tomcat-9.0-green.svg)
![Maven](https://img.shields.io/badge/Maven-3.8+-red.svg)

## 🚀 Features

- **User Registration** - Create new user accounts with name, email, password, and phone
- **User Login** - Secure authentication with session management
- **User Dashboard** - Personalized home page with user profile
- **Session Management** - Secure logout functionality
- **Responsive Design** - Modern, mobile-friendly UI
- **Error Handling** - Comprehensive error messages and validation
- **Database Integration** - MySQL database with JDBC

## 📋 Prerequisites

Before you begin, ensure you have the following installed:

| Software | Version | Description |
|----------|---------|-------------|
| JDK | 8 or higher | Java Development Kit |
| Maven | 3.8+ | Dependency management and build tool |
| MySQL | 8.0+ | Relational database |
| Apache Tomcat | 9.0 | Servlet container (or any Servlet 4.0 compatible container) |

### Verify Installations

```bash
java -version
mvn -version
mysql --version
```

## 🛠️ Installation & Setup

### Step 1: Clone the Project

```bash
git clone <repository-url>
cd Registration
```

### Step 2: Database Setup

#### Option A: Using MySQL Command Line

```bash
mysql -u root -p
```

Then execute the following SQL commands:

```sql
CREATE DATABASE IF NOT EXISTS registration_db;
USE registration_db;

CREATE TABLE IF NOT EXISTS users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    password VARCHAR(100) NOT NULL,
    phone VARCHAR(20) NOT NULL
);
```

#### Option B: Using the SQL File

```bash
mysql -u root -p < registration_db.sql
```

### Step 3: Configure Database Credentials

Open `src/main/java/com/example/registration/DBConnection.java` and update the database credentials if needed:

```java
private static final String URL = "jdbc:mysql://localhost:3306/registration_db";
private static final String USER = "root";
private static final String PASSWORD = "admin";
```

**Default credentials:**
- Username: `root`
- Password: `admin`

### Step 4: Build the Project

#### Windows

```bash
mvnw.cmd clean package
```

#### Linux / macOS / Git Bash

```bash
./mvnw clean package
```

### Step 5: Deploy to Tomcat

1. Copy the WAR file from `target/Registration-1.0-SNAPSHOT.war` to your Tomcat `webapps/` directory.

2. Rename to `registration.war` for a cleaner URL (optional):
   ```bash
   cp target/Registration-1.0-SNAPSHOT.war $CATALINA_HOME/webapps/registration.war
   ```

3. Start Tomcat:
   ```bash
   $CATALINA_HOME/bin/startup.sh   # Linux/macOS
   $CATALINA_HOME\bin\startup.bat  # Windows
   ```

4. Access the application:
   ```
   http://localhost:8080/registration/
   ```

## 📁 Project Structure

```
Registration/
├── pom.xml                                    # Maven configuration
├── README.md                                  # This file
├── registration_db.sql                        # Database setup SQL
├── src/
│   └── main/
│       ├── java/
│       │   └── com/
│       │       └── example/
│       │           └── registration/
│       │               ├── DBConnection.java  # Database connection utility
│       │               ├── User.java          # User model class
│       │               ├── RegisterServlet.java    # Handles user registration
│       │               ├── LoginServlet.java        # Handles user login
│       │               ├── LogoutServlet.java       # Handles user logout
│       │               └── HelloServlet.java        # Test servlet
│       └── webapp/
│           ├── index.jsp         # Registration page
│           ├── login.jsp         # Login page
│           ├── home.jsp          # Home/Dashboard page
│           ├── success.jsp       # Registration success page
│           └── WEB-INF/
│               └── web.xml       # Web application configuration
└── target/                      # Build output (generated)
    └── Registration-1.0-SNAPSHOT.war
```

## 🔧 Application Routes

| Route | Method | Description |
|-------|--------|-------------|
| `/register` | POST | Register a new user |
| `/login` | POST | Authenticate user |
| `/logout` | POST | End user session |
| `index.jsp` | GET | Registration page |
| `login.jsp` | GET | Login page |
| `home.jsp` | GET | Home/Dashboard page |
| `success.jsp` | GET | Registration success page |

## 🎯 Usage Flow

```
1. Visit http://localhost:8080/registration/
   ↓
2. Click "Register here" to create an account
   ↓
3. Fill in the registration form (name, email, password, phone)
   ↓
4. Submit the form - you'll be redirected to success page
   ↓
5. Click "Login to Your Account"
   ↓
6. Enter your email and password
   ↓
7. Access your profile on the home page
   ↓
8. Click "Logout" when done
```

## ⚙️ Configuration Details

### Database Configuration

The database connection is configured in `DBConnection.java`:

```java
private static final String URL = "jdbc:mysql://localhost:3306/registration_db";
private static final String USER = "root";
private static final String PASSWORD = "admin";
```

### Tomcat Configuration

If port 8080 is already in use, modify `conf/server.xml` in your Tomcat installation:

```xml
<Connector port="8081" protocol="HTTP/1.1"
           connectionTimeout="20000"
           redirectPort="8443" />
```

Then access the app at `http://localhost:8081/registration/`.

## 🔍 Troubleshooting

### Database Connection Failed

1. **Check if MySQL is running:**
   ```bash
   # Windows
   net start mysql

   # Linux
   sudo systemctl status mysql
   ```

2. **Verify database exists:**
   ```sql
   SHOW DATABASES;
   ```

3. **Test credentials:**
   ```bash
   mysql -u root -p
   ```

4. **Check MySQL is listening on port 3306:**
   ```bash
   mysql -h localhost -P 3306 -u root -p
   ```

### Port 8080 Already in Use

1. Find the process using port 8080:
   ```bash
   # Windows
   netstat -ano | findstr :8080

   # Linux
   sudo lsof -i :8080
   ```

2. Stop the process or change Tomcat's port.

### MySQL Driver Not Found

Ensure the MySQL Connector JAR is in your classpath. The Maven dependency should handle this automatically:

```xml
<dependency>
    <groupId>com.mysql</groupId>
    <artifactId>mysql-connector-j</artifactId>
    <version>8.0.33</version>
</dependency>
```

### Login Fails for Valid User

1. Verify the user exists in the database:
   ```sql
   USE registration_db;
   SELECT * FROM users WHERE email = 'your-email@example.com';
   ```

2. Check for password encoding issues (current implementation uses plain text).

## ⚠️ Current Limitations

- **Security**: Passwords are stored in plain text (not production-ready)
- **Validation**: Limited server-side input validation
- **Configuration**: Database credentials are hardcoded
- **Sessions**: No remember-me functionality
- **Roles**: No role-based access control

## 🚀 Recommended Improvements

For a production-ready application, consider implementing:

- [ ] Password hashing with BCrypt
- [ ] Move DB config to environment variables or properties file
- [ ] Server-side input validation and sanitization
- [ ] Integration tests with JUnit and Mockito
- [ ] Logging framework (SLF4J + Logback)
- [ ] Remember-me functionality with persistent cookies
- [ ] Role-based access control (RBAC)
- [ ] CSRF protection
- [ ] HTTPS enforcement

## 📝 License

This project is open source and available for educational and development purposes.

## 🤝 Contributing

Contributions, issues, and feature requests are welcome!

---

**Built with ❤️ using Java Servlet, JSP, JDBC, and MySQL**
