<?php
include_once '../lib/session.php';
Session::checkSession('admin');
$role_id = Session::get('role_id');
if ($role_id == 1) {
    # code...
} else {
    header("Location:../index.php");
}
include '../classes/orderDetails.php';
include '../classes/order.php';

$orderDetails = new orderDetails();
$result = $orderDetails->getOrderDetails($_GET['orderId']);
$order = new order();
$order_result = $order->getById($result[0]['orderId']);

include_once '../classes/user.php';
$totalPrice = $orderDetails->getTotalPriceByUserId($_GET['orderId']);
$totalQty = $orderDetails->getTotalQtyByUserId($_GET['orderId']);
$user = new user();
$userInfo = $user->getUserByOrder($_GET['orderId']);

?>

<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="./css/style.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
    <script src="https://use.fontawesome.com/2145adbb48.js"></script>
    <script src="https://kit.fontawesome.com/a42aeb5b72.js" crossorigin="anonymous"></script>
    <title>Chi tiết đơn đặt hàng</title>
</head>

<body>
    <nav>
        <input type="checkbox" id="check">
        <label for="check" class="checkbtn">
            <i class="fas fa-bars"></i>
        </label>
        <label class="logo"><a href="index.php">ADMIN</a></label>
        <ul>
            <li><a href="productlist.php">Quản lý Sản phẩm</a></li>
            <li><a href="categoriesList.php">Quản lý Danh mục</a></li>
            <li><a href="orderlist.php" class="active">Quản lý Đơn hàng</a></li>
            <li><a href="userlist.php">Quản lý Người dùng</a></li>
            <li><a href="chartms.php">Thống kê</a></li>
            <li><a href="transfer.php">Chuyển về trang chủ</a></li>
        </ul>
    </nav>
    <div class="title">
        <h1>Chi tiết đơn đặt hàng <?= $order_result['id'] ?></h1>
    </div>

    <div class="infor_order">
        <h3>Thông tin đơn đặt hàng</h3>
        <div>
            Người đặt hàng: <b><?= $userInfo['fullname'] ?></b>
        </div>
        <div>
            Người nhận hàng: <b><?= $order_result['fullname'] ?></b>
        </div>
        <div>
            Số điện thoại nhận hàng: <b><?= $order_result['phoneNumber'] ?></b>
        </div>
        <div>
            Số lượng: <b id="qtycart"><?= $totalQty['total'] ?></b>
        </div>
        <div>
            Tổng tiền: <b id="totalcart"><?= number_format($totalPrice['total'], 0, '', ',') ?>VND</b>
        </div>
        <div>
            Địa chỉ nhận hàng: <b><?= $order_result['address'] ?></b>
        </div>    
    </div>

    <div class="container">
        <?php
        if ($result) { ?>
            <table class="list">
                <tr>
                    <th>STT</th>
                    <th>Tên sản phẩm</th>
                    <th>Hình ảnh</th>
                    <th>Đơn giá</th>
                    <th>Số lượng</th>
                </tr>
                <?php $count = 1;
                foreach ($result as $key => $value) { ?>
                    <tr>
                        <td><?= $count++ ?></td>
                        <td><?= $value['productName'] ?></td>
                        <td><img class="image-cart" src="uploads/<?= $value['productImage'] ?>" alt=""></td>
                        <td><?= $value['productPrice'] ?></td>
                        <td><?= $value['qty'] ?></td>

                    </tr>
                <?php }
                ?>
            </table>

            

            <?php
            if ($order_result['status'] == 'Processing' || $order_result['status'] == 'Delivering') { ?>
                <div class="box_submit">
                    <a href="spam_order.php?orderId=<?= $_GET['orderId'] ?>">Đơn hàng spam</a>
                    <div class="submit">
                        <button><a href="cancel_order.php?orderId=<?= $_GET['orderId'] ?>">Hủy</a></button>
                        <?php
                        if ($order_result['status'] == 'Processing') { ?>
                            <button><a href="processed_order.php?orderId=<?= $_GET['orderId'] ?>">Xác nhận</a></button>
                        <?php }
                        ?>
                    </div>
                    
                </div>
            <?php }
            ?>
        <?php } else { ?>
            <h3>Chưa có đơn hàng nào đang xử lý</h3>
        <?php }
        ?>
    </div>
    </div>
    
    <footer>
        <p class="copyright">copy by IVYmoda.com 2024</p>
    </footer>
</body>

</html>