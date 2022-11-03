<%@ page import="java.sql.*"%>

<html>
	<head>Item Details</head>
<body>
	<%
		Class.forName("org.postgresql.Driver");
		Connection con=DriverManager.getConnection("jdbc:postgresql://192.168.100.253/tydb9","ty9"," " );
		Statement st=con.createStatement();
		ResultSet rs=st.executeQuery("select * from item_master");
	%>
	
	<table border="1">
	<tr>
		<th>Item Id</th>
		<th>Item Name</th>
		<th>Rate</th>
		<th>Quantity</th>
	</tr>
	
	<% while(rs.next()){%>
	<tr>
		<td> <%= rs.getString(1)%></td>
		<td> <%= rs.getString(2)%></td>
		<td> <%= rs.getString(3)%></td>
		<td> <%= rs.getString(4)%></td>
	</tr>
	<%}%>
	</table>
</body>
</html>


