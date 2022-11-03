<html>
<head>

<center> <font size=6><b>--:Employee Details:--</b></font> </center>
<script type="text/javascript">

function validate()
{
	if(document.myform.phone.value == "" ||
	   isNaN(document.myform.phone.value) ||
	   document.myform.phone.value.length != 10)
	{
		alert("Please Provide numeric values of length '10'");
		document.myform.phone.focus();
		return false;
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
alert("ok");
}
</script>
</head>

<body bgcolor="lightgrey">
<br><br>
<form method="post" name="myform" >
<font size=5>
<center>
	<table>
		<tr><td>Employee Id </td>			<th><input type="text" name="Employee Id"  autofocus="true" placeholder="Enter Id"></th><td>
		<input type="submit" name="Show Details" value="Show Details"></td></tr>
		<tr><td>Employee Name</td>			<th><input type="text" name="Employee Name" id="cname" autofocus="true" placeholder="Enter Name"></th></tr>
		<tr><td>Employee Address</td>			<th><input type="text" name="Employee Address"  autofocus="true" placeholder="Enter Address"></th></tr>
		<tr><td>Phone Number</td>			<th><input type="text" name="Phone Number" id="phone" value=" "></th></tr>
		<tr><td>Email Id </td>				<th><input type="text" name="Email-Id" id="email" value=" @gmail.com"></th></tr>
		<tr><td>User Id</td>				<th><input type="text" name="user-id" value=""></th></tr>
		<tr><td>Password</td>				<th><input type="text" name="password" id="pass" value=""></th></tr>
		<tr><th>  <br></th><th>  </th></tr>		
		<tr><th><input type="radio" name="r" value="new">NEW</th>
		    <th><input type="radio" name="r" value="update">UPDATE</th>
		</tr>
	</table>
</center>
</font>
<center><br><br><input type="submit" name="submit" value="submit" onclick="return validate();" >&nbsp;&nbsp;&nbsp;
<input type="reset" name="cancel" value="cancel">
</center>

</form>

<%@ page import="java.sql.*"%>
<%@ page import="java.util.*" %>
<%@ page import="java.lang.*" %>
<%
try{
Class.forName("org.postgresql.Driver");
Connection con=DriverManager.getConnection("jdbc:postgresql://192.168.100.253/tydb9","ty9"," " );

String s1=request.getParameter("Employee Id");
String s2=request.getParameter("Employee Name");
String s3=request.getParameter("Employee Address");
String s4=request.getParameter("Phone Number");
String s5=request.getParameter("Email-Id");
String s6=request.getParameter("user-id");
String s7=request.getParameter("password");
String s8=request.getParameter("Show Details");

if(s8!=null)
{
  Statement st=con.createStatement();
  
  ResultSet rs1= st.executeQuery("select * from employee where e_id="+s1+"");
  if(rs1.next())
  {
  out.println("<center> <font color=\"green\" > Employee Details Of Given Employee Id: </font></center> ");
  %><center><table border="1"><tr><td>Id</td><td>Name</td><td>Phone No</td><td>Address</td><td>Email</td></tr>
	    <tr><td><% out.println(rs1.getInt(1));%></td>
		<td><% out.println(rs1.getString(4));%></td>
		<td><% out.println(rs1.getString(5));%></td>
		<td><% out.println(rs1.getString(6));%></td>
		<td><% out.println(rs1.getString(7));%></td>
	    </tr>
     </table></center>
   <%
  }
 else
 {
	out.println("<center><font color=\"red\">Employee Not Available</font></center>");
 }
}




else 
{




String choice=request.getParameter("r");


if(request.getMethod().equalsIgnoreCase("POST"))
{
if(choice.equals("new"))
{
	//out.print("New");
	if(s1.isEmpty() || s2.isEmpty() || s3.isEmpty() || s4.isEmpty() || s5.isEmpty() || s6.isEmpty()|| s7.isEmpty())
	{
	 
         out.print("<center> <font color=\"red\" > Incorrect Details </font></center> ");
	}
	else if((s2.charAt(0)==' ') || (s1.charAt(0)==' ') || (s3.charAt(0)==' ') || (s4.charAt(0)==' ') || (s5.charAt(0)==' ') || (s6.charAt(0)==' ')|| (s7.charAt(0)==' '))
	{	
		out.print("<center> <font color=\"red\" > Space must not be first character </font></center> ");
	}
	else
	{
	//out.print("else");
	//String sql = "insert into employee values ("+s1+","+s6+",'"+s7+"','"+s2+"',"+s4+",'"+s3+"','"+s5+"');";
	//out.print(sql);
	Statement st=con.createStatement();
	st.execute("insert into employee values ("+s1+","+s6+",'"+s7+"','"+s2+"',"+s4+",'"+s3+"','"+s5+"');");

        
                                        //response.sendRedirect("employee.jsp");
	out.print("<center> <font color=\"green\" > Employee Details Added </font></center> ");

	}
	//out.print("iiii");	
}
else if(choice.equals("update"))
{	
	out.print("Update ");
	if(s1.isEmpty() || s2.isEmpty() || s3.isEmpty() || s4.isEmpty() || s5.isEmpty() || s6.isEmpty()|| s7.isEmpty())
        {
	
         out.print("<center> <font color=\"red\" > Incorrect Details </font></center> ");

	}
	else if((s2.charAt(0)==' ') || (s1.charAt(0)==' ') || (s3.charAt(0)==' ') || (s4.charAt(0)==' ') || (s5.charAt(0)==' ') || (s6.charAt(0)==' ')|| (s7.charAt(0)==' '))
	{	
		out.print("<center> <font color=\"red\" > Space must not be first character </font></center> ");
	}
	else
	{
	Statement st1=con.createStatement();
	st1.execute("update employee set login_id="+s6+",password='"+s7+"',e_name='"+s2+"',phone_no="+s4+",address='"+s3+"',e_mail='"+s5+"' where e_id="+s1+" ;");        
    
        
                                        //response.sendRedirect("employee.jsp");
        out.print("<center> <font color=\"green\" > Employee Details Updated </font></center> ");
	                                //response.sendRedirect("admin_menu.jsp");
        }
        
}

}
}
con.close();
}
catch(Exception e)
{
	out.print("Please Provide Proper Details");
}	



%>
<br><br><A HREF="admin_menu.jsp">Back</A>
</body>
</html>



