
<%@ page import="java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
Connection con = null;

try {
    Class.forName("com.mysql.cj.jdbc.Driver");

    con = DriverManager.getConnection(
        "jdbc:mysql://localhost:3306/repairdb",
        "root",
        "root123"
    );

    // Insert new job
    if ("POST".equalsIgnoreCase(request.getMethod())) {

        String customer = request.getParameter("customer");
        String model = request.getParameter("model");
        String problem = request.getParameter("problem");

        if (customer != null && model != null && problem != null
            && !customer.trim().isEmpty()
            && !model.trim().isEmpty()
            && !problem.trim().isEmpty()) {

            PreparedStatement ps = con.prepareStatement(
                "INSERT INTO repair_job(customer, model, problem) VALUES (?, ?, ?)"
            );

            ps.setString(1, customer.trim());
            ps.setString(2, model.trim());
            ps.setString(3, problem.trim());

            ps.executeUpdate();
            ps.close();
        }

        con.close();
        response.sendRedirect("result.jsp");
        return;
    }

    // Mark job as Repaired
    if ("repair".equals(request.getParameter("action"))) {

        int id = Integer.parseInt(request.getParameter("id"));

        PreparedStatement ps = con.prepareStatement(
            "UPDATE repair_job SET status='Repaired' WHERE id=?"
        );

        ps.setInt(1, id);
        ps.executeUpdate();
        ps.close();

        con.close();
        response.sendRedirect("result.jsp");
        return;
    }
%>

<!DOCTYPE html>
<html>
<head>
    <title>Repair Job Records</title>

    <style>
        body {
            font-family: Arial;
            background: #f2f2f2;
            padding: 20px;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            background: white;
        }

        th, td {
            border: 1px solid black;
            padding: 10px;
            text-align: center;
        }

        th {
            background: navy;
            color: white;
        }

        a {
            color: blue;
        }
    </style>
</head>

<body>
    <h2>Mobile Repair Job Records</h2>

    <a href="index.jsp">Add New Entry</a>
    <br><br>

    <table>
        <tr>
            <th>ID</th>
            <th>Customer</th>
            <th>Model</th>
            <th>Problem</th>
            <th>Status</th>
            <th>Action</th>
        </tr>

        <%
        Statement st = con.createStatement();

        ResultSet rs = st.executeQuery(
            "SELECT * FROM repair_job ORDER BY id"
        );

        int total = 0;

        while (rs.next()) {
            total++;
            String status = rs.getString("status");
        %>

        <tr>
            <td><%= rs.getInt("id") %></td>
            <td><%= rs.getString("customer") %></td>
            <td><%= rs.getString("model") %></td>
            <td><%= rs.getString("problem") %></td>
            <td><%= status %></td>

            <td>
                <% if ("Received".equals(status)) { %>
                    <a href="result.jsp?action=repair&id=<%= rs.getInt("id") %>">
                        Mark Repaired
                    </a>
                <% } else { %>
                    Completed
                <% } %>
            </td>
        </tr>

        <%
        }

        rs.close();
        st.close();
        con.close();
        %>
    </table>

    <h3>Total Records: <%= total %></h3>

</body>
</html>

<%
} catch (Exception e) {
    out.println("Error: " + e.getMessage());
    if (con != null) {
        try {
            con.close();
        } catch (Exception ex) {
        }
    }
}
%>
