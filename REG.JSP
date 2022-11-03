
<html>

	<center><font size=6><b>--:New Registration:--</b></font></center>
<body>
<br><br>
<script type="text/javascript">
function validate()
{
	if(document.myform.phone.value == "" ||
	   isNaN(document.myform.phone.value) ||
	   document.myform.phone.value.length != 10)
	{
		alert("Please Provide numeric values of length '10'");
		document.myform.phone.focus();
		return false
	}


        var pat=/^[a-zA-Z \ ]+$/;
	var n=document.myform.cname.value;
	if((!pat.test(n)) || (n.length>20))
	{
		alert("Invalid Name");
		return false;
	}

	var patt=/^([A-Za-z0-9](\.)?(\-)?)+([A-Za-z0-9])*\@([A-Za-z0-9](\-)?)+([A-Za-z0-9])+\.([A-Za-z0-9]{2,4})$/;
	var e=document.myform.email.value;
	if(!patt.test(e))
	{
		alert("Invalid Email");
		return false;
	}
	
	var pa=document.myform.pass.value;
	if((pa.length<=5) || (pa.length>=15))
	{
		alert("password must be between 5-15 characters!");
		return false;
	}
	
	var ca=document.myform.con.value;
	if(!(pa == ca))
	{
		alert("Password not match !");
		return false;
	}
alert("ok");	
}

//var x=document.myform.email.value;
//var atposition=x.indexOf("@");
//var dotposition=x.lastIndexOf(".");
//if (atposition<1 || dotposition<atposition+2||dotposition+2>=x.length)
//{
//alert("Please enter a valid email address"):
//return false;}}
</script>
<form method="post" name="myform" >
<center><table>
<font size = 5>
	<tr>	<td>Admin Name</td>		<th><input type="text" name="aname" id="cname" ></th></tr>
	<tr>	<td>Address</td>		<th><input type="text" name="address"></th></tr>
	<tr>	<td>Phone No.</td>		<th><input type="text" name="phone" id="phone" ></th></tr>
	<tr>	<td>Email</td>			<th><input type="text" name="email" id="email" value="@gmail.com" ></th></tr>
	<tr>	<td>User Id</td>		<th><input type="text" name="Userid"  autofocus="true" placeholder="Enter Your userid"></th></tr>
	<tr>	<td>Password</td>		<th><input type="password" name="PW" id="pass" autofocus="true" placeholder="8-10 characters"></th></tr>
	<tr>	<td>Confirm Password</td>	<th><input type="password" name="CPW" id="con" autofocus="true" placeholder="8-10 characters"></th></tr>
</table></center>
</font>
<br><br>
<center>
	<input type="submit" name="submit" value="submit" onclick="return validate();">
 	<input type="submit" name="cancel" value="cancel">
</center>
<br>
</form>

<%@ page language="java"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>
<%@ page import="java.lang.*" %>
<%

try
{

Class.forName("org.postgresql.Driver");
Connection con=DriverManager.getConnection("jdbc:postgresql://192.168.100.253/tydb9","ty9","");

String s1=request.getParameter("Userid");
String s2=request.getParameter("PW");
String s3=request.getParameter("CPW");
String s4=request.getParameter("aname");
String s5=request.getParameter("address");
String s6=request.getParameter("phone");
String s7=request.getParameter("email");

if((request.getMethod().equalsIgnoreCase("POST")))
{
	if(s1.isEmpty() || s2.isEmpty() || s3.isEmpty() || s4.isEmpty() || s5.isEmpty() || s6.isEmpty() || s7.isEmpty()  )
	{
	out.print("InComplte Data");
	}
	else if(!s2.equals(s3))
	{
	out.print("Password Incorrect");
	}
	else if((s2.charAt(0)==' ') || (s1.charAt(0)==' ') || (s3.charAt(0)==' ') || (s4.charAt(0)==' ') || (s5.charAt(0)==' ') || (s6.charAt(0)==' ')|| (s7.charAt(0)==' '))
	{	
		out.print("<center> <font color=\"red\" > Space must not be first character </font></center> ");
	}
	else
	{
	
		Statement st=con.createStatement();
		st.execute("insert into admin values ('"+s1+"','"+s2+"','"+s4+"','"+s5+"',"+s6+",'"+s7+"');");
	
 	 response.sendRedirect("login.jsp");
	}
}

}

catch(Exception e)
{
		out.print("Please Provide Proper Details");
}

%>
</body>
</html>
