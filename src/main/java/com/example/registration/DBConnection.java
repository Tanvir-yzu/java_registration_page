package com.example.registration;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

public class DBConnection {
    private static final String URL = "jdbc:mysql://localhost:3306/registration_db";
    private static final String USER = "root";
    private static final String PASSWORD = "admin";

    static {
        try {
            // Explicitly load the MySQL driver
            Class.forName("com.mysql.cj.jdbc.Driver");
            System.out.println("MySQL driver loaded successfully");
        } catch (ClassNotFoundException e) {
            System.out.println("Error loading MySQL driver: " + e.getMessage());
            e.printStackTrace();
        }
    }

    public static Connection getConnection() throws SQLException {
        System.out.println("Attempting to connect to database: " + URL);
        Connection connection = DriverManager.getConnection(URL, USER, PASSWORD);
        System.out.println("Database connection established successfully");
        return connection;
    }

    public static void createUsersTable() throws SQLException {
        String createTableSQL = "CREATE TABLE IF NOT EXISTS users (" +
                "id INT AUTO_INCREMENT PRIMARY KEY, " +
                "name VARCHAR(100) NOT NULL, " +
                "email VARCHAR(100) NOT NULL UNIQUE, " +
                "password VARCHAR(100) NOT NULL, " +
                "phone VARCHAR(20) NOT NULL)";

        try (Connection connection = getConnection();
             Statement statement = connection.createStatement()) {
            statement.execute(createTableSQL);
            System.out.println("Users table created successfully");
        }
    }

    public static void saveUser(User user) throws SQLException {
        String insertSQL = "INSERT INTO users (name, email, password, phone) VALUES (?, ?, ?, ?)";

        try (Connection connection = getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(insertSQL)) {
            preparedStatement.setString(1, user.getName());
            preparedStatement.setString(2, user.getEmail());
            preparedStatement.setString(3, user.getPassword());
            preparedStatement.setString(4, user.getPhone());
            preparedStatement.executeUpdate();
            System.out.println("User saved successfully");
        }
    }

    public static User getUserByEmail(String email) throws SQLException {
        String selectSQL = "SELECT * FROM users WHERE email = ?";
        User user = null;

        System.out.println("Attempting to get user by email: " + email);

        try (Connection connection = getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(selectSQL)) {
            System.out.println("Database connection established");
            preparedStatement.setString(1, email);
            ResultSet resultSet = preparedStatement.executeQuery();

            if (resultSet.next()) {
                user = new User(
                        resultSet.getInt("id"),
                        resultSet.getString("name"),
                        resultSet.getString("email"),
                        resultSet.getString("password"),
                        resultSet.getString("phone")
                );
                System.out.println("User found: " + user.getName());
            } else {
                System.out.println("User not found for email: " + email);
            }
        }

        return user;
    }
}