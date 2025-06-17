<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="lk.ijse.model.bean.UserBean" %>
<%@ page import="java.util.List" %>

<%
    UserBean userBean = (UserBean) session.getAttribute("user");
    if (userBean == null || userBean.getRole().equalsIgnoreCase("EMPLOYEE")) {
        response.sendRedirect(request.getContextPath() + "/view/signin.jsp");
        return;
    }

    List<UserBean> employees = (List<UserBean>) request.getAttribute("employees");
%>

<html>
<head>
    <title>All Employees</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <style>
        /* Custom scrollable table body with fixed header */
        .table-container {
            max-height: 700px; /* Adjust height as needed */
            overflow-y: auto;
        }

        thead th {
            position: sticky;
            top: 0;
            background-color: #ebf8ff; /* Match with bg-blue-100 */
            z-index: 1;
        }
    </style>
</head>
<body class="bg-gray-50 p-6">
<h2 class="text-2xl font-bold mb-4 text-blue-800">All Employees</h2>

<div class="border rounded shadow-md overflow-hidden">
    <div class="table-container">
        <table class="min-w-full bg-white border-collapse">
            <thead class="bg-blue-100 text-blue-900 text-sm font-semibold">
            <tr>
                <th class="border px-4 py-2 text-left">ID</th>
                <th class="border px-4 py-2 text-left">Name</th>
                <th class="border px-4 py-2 text-left">Email</th>
            </tr>
            </thead>
            <tbody class="text-sm text-gray-800">
            <% if (employees != null && !employees.isEmpty()) {
                for (UserBean emp : employees) { %>
            <tr class="hover:bg-blue-50">
                <td class="border px-4 py-2"><%= emp.getId() %></td>
                <td class="border px-4 py-2"><%= emp.getUserName() %></td>
                <td class="border px-4 py-2"><%= emp.getEmail() %></td>
            </tr>
            <% }} else { %>
            <tr>
                <td colspan="3" class="text-center py-4 text-gray-500">No employees found.</td>
            </tr>
            <% } %>
            </tbody>
        </table>
    </div>
</div>
</body>
</html>
