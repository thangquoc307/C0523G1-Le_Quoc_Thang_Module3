<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>ProductDiscountCalculator</title>
</head>
<body>
<form action="/discount-calculator" method="post">
    <table>
        <tr>
            <td>Mô tả sản phẩm</td>
            <td><input type="text" name="description" id="description" value="${description}"></td>
        </tr>
        <tr>
            <td>Giá niêm yết</td>
            <td><input type="number" name="price" id="price" value="${price}"></td>
        </tr>
        <tr>
            <td>Chiết khấu</td>
            <td><input type="number" name="percentage" id="percentage" value="${percentage}"></td>
        </tr>
        <tr>
            <td>Số tiền chiết khấu</td>
            <td><input type="number" disabled id="discountAmount" value="${discountAmount}"></td>
        </tr>
        <tr>
            <td>Số tiền còn lại</td>
            <td><input type="number" disabled id="discountPrice" value="${discountPrice}"></td>
        </tr>
    </table>
    <button type="submit">Submit</button>
</form>

</body>
</html>