<%--
  Created by IntelliJ IDEA.
  User: quoct
  Date: 8/30/2023
  Time: 10:17 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Edit Product</title>
</head>
<body>

<form action="/product?action=editProductAfterEnterValue" method="post">
  <a href="index.jsp">quay lại</a>
  <input type="hidden" name="id" value="${id}">
  <table>
    <tr>
      <td>Tên sản phẩm</td>
      <td><input type="text" name="name" value="${oldName}"></td>
    </tr>
    <tr>
      <td>Giá sản phẩm</td>
      <td><input type="number" name="price" value="${oldPrice}"></td>
    </tr>
  </table>
  <button type="submit">submit</button>
</form>

</body>
</html>
