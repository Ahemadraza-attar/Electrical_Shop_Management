<%@ page import="java.sql.*"%>

<html>
&nbsp;&nbsp;	<head>Employee Details</head>
<body bgcolor="lightgrey">
	<%
		Class.forName("org.postgresql.Driver");
		Connection con=DriverManager.getConnection("jdbc:postgresql://192.168.100.253/tydb9","ty9"," " );
		Statement st=con.createStatement();
		ResultSet rs=st.executeQuery("select * from employee");
	%>
	
	<br><br>
        <table align="center" border="1">
<br>
<br>	<tr>
		<th>Employee Id</th>
		<th>Login Id </th>
		<th>Employee Name</th>
		<th>Phone No.</th>
		<th>Address</th>
		<th>E-mail</th>
	</tr>
	
	<% while(rs.next()){%>
	<tr>
		<td> <%= rs.getString(1)%></td>
		<td> <%= rs.getString(2)%></td>
		<td> <%= rs.getString(4)%></td>
		<td> <%= rs.getString(5)%></td>
		<td> <%= rs.getString(6)%></td>
		<td> <%= rs.getString(7)%></td>
	</tr>
	<%}%>
	</table>
</body>
</html>
