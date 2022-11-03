<html>
<head>
<center> <font size=10><b><font color="orange">--:Customer Details:--</b></font> </center>
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
		return false;

	}
	

        var pat=/^[a-zA-Z \ ]+$/;
	var n=document.myform.cname.value;
	if((!pat.test(n)) || (n.length>20) )
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
alert("ok");
}

</script>
</head>
<body background="home3.jpg">

<form method="post" name="myform" >
<center>
	<table>
		<tr><td><font color="orange"><font size=4>Customer Id</td>	<td><input type="text" name="customer Id" autofocus="true" placeholder="Enter Id"></td>		<td><input type="submit" name="Show Details" value="Show Details"></td></tr>
		<tr><td><font color="orange"><font size=4>Customer Name</td>	<td><input type="text" name="customer Name" autofocus="true" id="cname" placeholder="Enter Your customer name"></td></tr>
		<tr><td><font color="orange"><font size=4>Phone Number</td>	<td><input type="text" name="Phone Number" id="phone" value=" "></td></tr>
		<tr><td><font color="orange"><font size=4>Address</td>		<td><input type="text" name="Address" autofocus="true" placeholder="Enter Address"></td></tr>
		<tr><td><font color="orange"><font size=4>Email Id</td>		<td><input type="email" name="email" id="email" autofocus="true" value="@gmail.com" placeholder="Enter email"></td><tr>
		<tr><td><br></td></tr>
		<tr><th><input type="radio" name="r" value="new"><font color="blue">NEW
			</th><th><input type="radio" name="r" value="Update"><font color="blue">UPDATE</th></tr>
	</table>
</center>
</font>
<br><br>
<center>
	<input type="submit" name="submit" value="submit" onclick="return validate();" >&nbsp;&nbsp;
	
 	<input type="submit" name="cancel" value="cancel">&nbsp;&nbsp;
</font>
</center>
</form>






<%@ page import="java.sql.*"%>
<%@ page import="java.util.*" %>
<%@ page import="java.lang.*" %>
<%
try{
Class.forName("org.postgresql.Driver");
Connection con=DriverManager.getConnection("jdbc:postgresql://192.168.100.253/tydb9","ty9"," " );

String s1=request.getParameter("customer Id");
String s2=request.getParameter("customer Name");
String s3=request.getParameter("Address");
String s4=request.getParameter("Phone Number");
String s5=request.getParameter("email");
String s8=request.getParameter("Show Details");
if(s8!=null)
{
  Statement st=con.createStatement();
  
  ResultSet rs1= st.executeQuery("select * from customer where cust_id="+s1+"");
  if(rs1.next())
  {
 	 out.println("<center> <font color=\"green\" > Customer Details Of Given Customer Id: </font></center> ");
  %><center><table border="1"><tr><td>Id</td><td>Name</td><td>Phone No</td><td>Address</td><td>Email</td></tr>
	    <tr><td><% out.println(rs1.getInt(1));%></td>
		<td><% out.println(rs1.getString(2));%></td>
		<td><% out.println(rs1.getString(4));%></td>
		<td><% out.println(rs1.getString(3));%></td>
		<td><% out.println(rs1.getString(5));%></td>
	    </tr>
     </table></center>
   <%
  }
 else
 {
	out.println("<center><font color=\"red\">Customer Not Available</font></center>");
 }
}
else 
{

String choice=request.getParameter("r");


if(request.getMethod().equalsIgnoreCase("POST"))
{
if(choice.equals("new"))
{
	
	if(s1.isEmpty() || s2.isEmpty() || s3.isEmpty() || s4.isEmpty() || s5.isEmpty())
	{
	       out.print("<center> <font color=\"red\" > Incorrect Details </font></center> ");
	}
	else if((s2.charAt(0)==' ') || (s1.charAt(0)==' ') || (s3.charAt(0)==' ') || (s4.charAt(0)==' ') || (s5.charAt(0)==' '))
	{	
		out.print("<center> <font color=\"red\" > Space must not be first character </font></center> ");
	}
	//else if
	//{
		
	//}
	else
	{
	//out.print("else");
	//String sql = "insert into employee values ("+s1+","+s6+",'"+s7+"','"+s2+"',"+s4+",'"+s3+"','"+s5+"');";
	//out.print(sql);
	Statement st=con.createStatement();
	st.execute("insert into customer values ("+s1+",'"+s2+"','"+s3+"',"+s4+",'"+s5+"');");

        
                                                //response.sendRedirect("customer.jsp");
	out.print("<center> <font color=\"green\" > Customer Details Added </font></center> ");

	}
	//out.print("iiii");	5
}
else if(choice.equals("Update"))
{	
	//out.print("Update ");
	if(s1.isEmpty() || s2.isEmpty() || s3.isEmpty() || s4.isEmpty() || s5.isEmpty() )
        {
	
         out.print("<center> <font color=\"red\" > Incorrect Details </font></center> ");

	}
	else if((s2.charAt(0)==' ') || (s1.charAt(0)==' ') || (s3.charAt(0)==' ') || (s4.charAt(0)==' ') || (s5.charAt(0)==' '))
	{	
		out.print("<center> <font color=\"red\" > Space must not be first character </font></center> ");
	}
	//else if
	else
	{
       	Statement st1=con.createStatement();
	st1.execute("update customer set cust_name='"+s2+"',address='"+s3+"',phone_no="+s4+",e_mail='"+s5+"' where cust_id="+s1+" ;");  
	                                        //response.sendRedirect("customer.jsp");
        
        out.print("<center> <font color=\"green\" > Customer Details Updated </font></center> ");

        }
        
}

}}
con.close();
}
catch(Exception e)
{
		out.print("Please Provide Proper Details");
}	



%>



<br><br><A HREF="employee_menu.jsp">Back</A>

</body>
</html>
