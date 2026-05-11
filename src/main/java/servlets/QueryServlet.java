package servlets;

import beans.Person;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.sql.DataSource;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;

public class QueryServlet extends HttpServlet {
    private static final Logger logger = Logger.getLogger(QueryServlet.class.getName());
    private volatile DataSource dataSource;

    void setDataSource(DataSource dataSource) {
        this.dataSource = dataSource;
    }

    @Override
    public void init() throws ServletException {
        if (dataSource != null) {
            return;
        }
        try {
            Context context = new InitialContext();
            dataSource = (DataSource) context.lookup("java:comp/env/jdbc/PersonDB");
        } catch (NamingException e) {
            throw new ServletException("DataSource lookup failed for jdbc/PersonDB", e);
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPost(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");

        String personIdParam = request.getParameter("personId");
        int personId;
        try {
            personId = Integer.parseInt(personIdParam);
        } catch (Exception e) {
            forwardWithError(request, response, "Invalid person ID");
            return;
        }

        if (personId < 1) {
            forwardWithError(request, response, "Invalid person ID");
            return;
        }

        String sql = "SELECT id, name, pwd, gender FROM persons WHERE id = ?";

        try (Connection connection = dataSource.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(sql)) {
            preparedStatement.setInt(1, personId);
            try (ResultSet resultSet = preparedStatement.executeQuery()) {
                if (resultSet.next()) {
                    Person person = new Person(
                            resultSet.getInt("id"),
                            resultSet.getString("name"),
                            resultSet.getString("pwd"),
                            resultSet.getString("gender")
                    );
                    request.setAttribute("person", person);
                    forward(request, response, "/person-show.jsp");
                } else {
                    request.setAttribute("error", "No person found for ID " + personId);
                    forward(request, response, "/index.jsp");
                }
            }
        } catch (SQLException e) {
            logger.log(Level.SEVERE, "Database error while querying person by id " + personId, e);
            request.setAttribute("error", "Database error, contact administrator");
            forward(request, response, "/index.jsp");
        }
    }

    private static void forwardWithError(HttpServletRequest request, HttpServletResponse response, String error)
            throws ServletException, IOException {
        request.setAttribute("error", error);
        forward(request, response, "/index.jsp");
    }

    private static void forward(HttpServletRequest request, HttpServletResponse response, String path)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        RequestDispatcher dispatcher = request.getRequestDispatcher(path);
        dispatcher.forward(request, response);
    }
}
