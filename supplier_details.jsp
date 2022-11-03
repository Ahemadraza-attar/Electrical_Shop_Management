<%@ page import="java.sql.*"%>

<html>
	<head>Supplier Details</head>
<body bgcolor="lightgrey">
	<%
		Class.forName("org.postgresql.Driver");
		Connection con=DriverManager.getConnection("jdbc:postgresql://192.168.100.253/tydb9","ty9"," " );
		Statement st=con.createStatement();
		ResultSet rs=st.executeQuery("select * from supplier_master");
	%>
	
	<br><br><br>
        <table align="center" border="1">
	<tr>
		<th>Supplier Id</th>
		<th>Supplier Name</th>
		<th>Address</th>
		<th>Phone No.</th>
		<th>E-mail</th>
	</tr>
	
	<% while(rs.next()){%>
	<tr>
		<td> <%= rs.getString(1)%></td>
		<td> <%= rs.getString(2)%></td>
		<td> <%= rs.getString(5)%></td>
		<td> <%= rs.getString(3)%></td>
		<td> <%= rs.getString(4)%></td>
	</tr>
	<%}%>
	</table>
</body>
</html>


