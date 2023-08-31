<%--
  Created by IntelliJ IDEA.
  User: quoct
  Date: 8/29/2023
  Time: 8:50 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>AllProduct</title>
    <style>
        table{
            border-collapse: collapse;
        }
        td, th{
            border: black 1px solid;
        }
    </style>
</head>
<body>
<a href="index.jsp">quay lại</a>
<input onchange="findProduct(this.value)" placeholder="Nhập tên sản phẩm cần kiếm">
<table id="data">
    <tr>
        <th>STT</th>
        <th>Tên</th>
        <th>Giá</th>
        <th>Sửa</th>
        <th>Xóa</th>
    </tr>
    ${data}
</table>
<script>
    function editProduct(id, name, price){
        window.location.href = "/product?action=edit&id=" + id + "&name=" + name + "&price=" + price;
    }
    function deleteProduct(id){
        window.location.href = "/product?action=delete&id=" + id;
    }
    function findProduct(name){
        window.location.href = "/product?action=find&name=" + name;
    }
</script>
</body>
</html>
