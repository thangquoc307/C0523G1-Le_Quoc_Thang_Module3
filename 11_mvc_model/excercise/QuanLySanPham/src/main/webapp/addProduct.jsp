<%--
  Created by IntelliJ IDEA.
  User: quoct
  Date: 8/30/2023
  Time: 6:46 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Thêm mới sản phẩm</title>
</head>
<body>
<form action="/Controller?action=addProduct" method="post">
  <a href="index.jsp">quay lại</a>
  <table>
    <tr>
      <td>Tên sản phẩm</td>
      <td><input type="text" name="name"></td>
    </tr>
    <tr>
      <td>Giá sản phẩm</td>
      <td><input type="number" name="price"></td>
    </tr>
  </table>
  <button type="submit">submit</button>
</form>

</body>
</html>
