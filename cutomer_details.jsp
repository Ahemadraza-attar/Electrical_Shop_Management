 <%@ page import="java.sql.*"%>

<html>
	<head>Customer Details</head>
<body>
	<%
		Class.forName("org.postgresql.Driver");
		Connection con=DriverManager.getConnection("jdbc:postgresql://192.168.100.253/tydb9","ty9","shreyas@12345 " );
		Statement st=con.createStatement();
		ResultSet rs=st.executeQuery("select * from customer");
	%>
	
	<table border="1">
	<tr>
		<th>Customer Id</th>
		<th>Customer Name</th>
		<th>Address</th>
		<th>Phone No.</th>
		<th>E-mail</th>
	</tr>
	
	<% while(rs.next()){%>
	<tr>
		<td> <%= rs.getString(1)%></td>
		<td> <%= rs.getString(2)%></td>
		<td> <%= rs.getString(3)%></td>
		<td> <%= rs.getString(4)%></td>
		<td> <%= rs.getString(5)%></td>
	</tr>
	<%}%>
	</table>
</body>
</html>

