package servlets;

import beans.Person;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.ArgumentCaptor;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;

import javax.servlet.RequestDispatcher;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.sql.DataSource;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertNotNull;
import static org.mockito.ArgumentMatchers.anyString;
import static org.mockito.ArgumentMatchers.eq;
import static org.mockito.Mockito.atLeastOnce;
import static org.mockito.Mockito.verify;
import static org.mockito.Mockito.when;

@ExtendWith(MockitoExtension.class)
class QueryServletTest {
    @Mock
    DataSource dataSource;

    @Mock
    Connection connection;

    @Mock
    PreparedStatement preparedStatement;

    @Mock
    ResultSet resultSet;

    @Mock
    HttpServletRequest request;

    @Mock
    HttpServletResponse response;

    @Mock
    RequestDispatcher showDispatcher;

    @Mock
    RequestDispatcher indexDispatcher;

    QueryServlet servlet;

    @BeforeEach
    void setUp() throws Exception {
        servlet = new QueryServlet();
        servlet.setDataSource(dataSource);
        servlet.init();
    }

    @Test
    void successRowFound_forwardsToShowAndSetsPerson() throws Exception {
        when(request.getParameter("personId")).thenReturn("1");
        when(dataSource.getConnection()).thenReturn(connection);
        when(connection.prepareStatement(anyString())).thenReturn(preparedStatement);
        when(preparedStatement.executeQuery()).thenReturn(resultSet);
        when(resultSet.next()).thenReturn(true);
        when(resultSet.getInt("id")).thenReturn(1);
        when(resultSet.getString("name")).thenReturn("Alice");
        when(resultSet.getString("pwd")).thenReturn("alice123");
        when(resultSet.getString("gender")).thenReturn("Female");
        when(request.getRequestDispatcher("/person-show.jsp")).thenReturn(showDispatcher);

        servlet.doPost(request, response);

        verify(request, atLeastOnce()).setCharacterEncoding("UTF-8");

        ArgumentCaptor<Person> captor = ArgumentCaptor.forClass(Person.class);
        verify(request).setAttribute(eq("person"), captor.capture());
        Person person = captor.getValue();
        assertNotNull(person);
        assertEquals(1, person.getId());
        assertEquals("Alice", person.getName());
        assertEquals("alice123", person.getPwd());
        assertEquals("Female", person.getGender());

        verify(showDispatcher).forward(request, response);
    }

    @Test
    void noRowFound_forwardsToIndexAndSetsError() throws Exception {
        when(request.getParameter("personId")).thenReturn("99");
        when(dataSource.getConnection()).thenReturn(connection);
        when(connection.prepareStatement(anyString())).thenReturn(preparedStatement);
        when(preparedStatement.executeQuery()).thenReturn(resultSet);
        when(resultSet.next()).thenReturn(false);
        when(request.getRequestDispatcher("/index.jsp")).thenReturn(indexDispatcher);

        servlet.doPost(request, response);

        verify(request).setAttribute("error", "No person found for ID 99");
        verify(indexDispatcher).forward(request, response);
    }

    @Test
    void invalidId_forwardsToIndexAndSetsError() throws Exception {
        when(request.getParameter("personId")).thenReturn("abc");
        when(request.getRequestDispatcher("/index.jsp")).thenReturn(indexDispatcher);

        servlet.doPost(request, response);

        verify(request).setAttribute("error", "Invalid person ID");
        verify(indexDispatcher).forward(request, response);
    }

    @Test
    void sqlException_forwardsToIndexAndSetsGenericError() throws Exception {
        when(request.getParameter("personId")).thenReturn("1");
        when(dataSource.getConnection()).thenThrow(new SQLException("boom"));
        when(request.getRequestDispatcher("/index.jsp")).thenReturn(indexDispatcher);

        servlet.doPost(request, response);

        verify(request).setAttribute("error", "Database error, contact administrator");
        verify(indexDispatcher).forward(request, response);
    }
}
