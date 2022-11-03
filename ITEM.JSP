<html>
<head>
<b><center><font size=6>--:Item Master:--</font></center></b></head>
<body bgcolor="lightgrey">
<script type="text/javascript">

function validate()
{

	   var pat=/^[a-zA-Z \ ]+$/;
	var n=document.myform.cname.value;
	if(!pat.test(n))
	{
		alert("Invalid Name");
		return false;
	}

	
alert("ok");
}

</script>
<form method="post">
<br><br>

<font size=5>
<center>
	<table>
		<tr><td>Item Id</td>	<td><input type="text" name="id" value=""></td><td><input type="submit" name="Show Details" value="Show Details"></td></tr>
		<tr><td>Name</td>	<td><input type="text" name="name" id="cname" value=""></td></tr>
		<tr><td>Rate</td>	<td><input type="text" name="rate" value=""></td></tr>
		<tr><th><br></th></tr>	
		<tr><th><input type="radio" name="r" value="new">NEW</th>
			<th><input type="radio" name="r" value="update">UPDATE</th></tr>
	</table>
</center>
</font>
<br><br>
<center>
	<input type="submit" name = "submit" value="submit" onclick="return validate();">
	&nbsp;&nbsp;&nbsp;
	<input type="reset" name="reset" value="reset">

</center>
</form>


<%@ page import="java.sql.*"%>
<%@ page import="java.util.*" %>
<%@ page import="java.lang.*" %>
<%
try{
Class.forName("org.postgresql.Driver");
Connection con=DriverManager.getConnection("jdbc:postgresql://192.168.100.253/tydb9","ty9"," " );

String s1=request.getParameter("id");
String s2=request.getParameter("name");
String s3=request.getParameter("rate");
String choice=request.getParameter("r");
String s8=request.getParameter("Show Details");

if(s8!=null)
{
  Statement st=con.createStatement();
  
  ResultSet rs1= st.executeQuery("select * from item_master where item_id="+s1+"");
  if(rs1.next())
  {
  	
 	 out.println("<center> <font color=\"green\" > Item Details Of Given item Id: </font></center> ");
  %><center><table border="1"><tr><td>Id</td><td>Name</td><td>Rate</td><td>Quantity</td></tr>
	    <tr><td><% out.println(rs1.getInt(1));%></td>
		<td><% out.println(rs1.getString(2));%></td>
		<td><% out.println(rs1.getInt(3));%></td>
		<td><% out.println(rs1.getInt(4));%></td>
		
	    </tr>
     </table></center>
   <%
  }
 else
 {
	out.println("<center><font color=\"red\">Item Not Available</font></center>");
 }
}
else 
{

if(request.getMethod().equalsIgnoreCase("POST"))
{
if(choice.equals("new"))
{
	//out.print("New");
	if(s1.isEmpty() || s2.isEmpty() || s3.isEmpty() )
	{
	 
         out.print("<center> <font color=\"red\" > Incorrect Details </font></center> ");
	}
	else if((s2.charAt(0)==' ') || (s1.charAt(0)==' ') || (s3.charAt(0)==' ') )
	{	
		out.print("<center> <font color=\"red\" > Space must not be first character </font></center> ");
	}
	else
	{
	//out.print("else");
	//String sql = "insert into employee values ("+s1+","+s6+",'"+s7+"','"+s2+"',"+s4+",'"+s3+"','"+s5+"');";
	//out.print(sql);
	Statement st=con.createStatement();
	st.execute("insert into item_master values ("+s1+",'"+s2+"',"+s3+","+0+");");

        
	out.print("<center> <font color=\"red\" > Item Details Added </font></center> ");

	}
	//out.print("iiii");	
}
else if(choice.equals("update"))
{	
	out.print("Update ");
	if(s1.isEmpty() || s2.isEmpty() || s3.isEmpty() )
        {
	
         out.print("<center> <font color=\"red\" > Incorrect Details </font></center> ");

	}
	else if((s2.charAt(0)==' ') || (s1.charAt(0)==' ') || (s3.charAt(0)==' ') )
	{	
		out.print("<center> <font color=\"red\" > Space must not be first character </font></center> ");
	}
	else
	{
        Statement st1=con.createStatement();
	st1.execute("update item_master set item_name='"+s2+"',rate="+s3+" where item_id="+s1+" ;");  
        
        out.print("<center> <font color=\"green\" > Item Details Updated </font></center> ");

        }
        
}}

}
con.close();
}
catch(Exception e)
{
		out.print("Please Provide Proper Details");
}	



%>
<br><br>
<A HREF="admin_menu.jsp">Back</A>
</body>
</html>




