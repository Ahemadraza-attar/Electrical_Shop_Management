<html>
<body>
<form>
	No<input type="text" name="no" ><br>
	

<%@ page import="java.sql.*"%>
<%@ page import="java.util.*" %>
<%@ page import="java.lang.*" %>
<%
try
{
Class.forName("org.postgresql.Driver");
Connection con=DriverManager.getConnection("jdbc:postgresql://192.168.100.253/tydb9","ty9"," " );

Statement st=con.createStatement();
String no=request.getParameter("no");
int s1=Integer.parseInt(no);

ResultSet rs=st.execute("select * from movie where movie_no = "+s1+");
rs.next();
String name=rs.getString("movie_name");
int year=rs.getInt("release_year");

}
catch(Exception e)
{
	out.print(e);
}
%>
 name:<input type="text" name="name" value=""><br>
        Release Year<input type="text" name="year" value=""><br>
        <input type="submit" name="submit">
</form>

</body>
</html>
