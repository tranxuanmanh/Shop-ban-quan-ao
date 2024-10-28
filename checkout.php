<?php
include_once 'lib/session.php';
Session::checkSession('client');
include_once 'classes/cart.php';
include_once 'classes/user.php';

$cart = new cart();
$list = $cart->get();
$totalPrice = $cart->getTotalPriceByUserId();
$totalQty = $cart->getTotalQtyByUserId();

$user = new user();
$userInfo = $user->get();
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
    <title>Checkout</title>
    <script src="http://ajax.googleapis.com/ajax/libs/jquery/1/jquery.min.js"></script>
    <script>
        $(function() {
            $('.fadein img:gt(0)').hide();
            setInterval(function() {
                $('.fadein :first-child').fadeOut().next('img').fadeIn().end().appendTo('.fadein');
            }, 5000);
        });
    </script>
</head>

<body>
<nav>
        <label class="logo"><a href="index.php">IVY Moda</a></label>
        <ul id="dc_mega-menu-orange">
            <li class="li-index"><a href="index.php" >Trang chủ</a></li>
            <li class="li-index"><a href="productList.php" >Sản phẩm</a></li>

            <li class="li-index"><a href="order.php" id="order">Đơn hàng</a></li>
                
            <?php
            if (isset($_SESSION['user']) && $_SESSION['user']) { ?>
                <li class="li-index"><a href="info.php" id="signin">Thông tin cá nhân</a></li>
                <li class="li-index"><a href="logout.php" id="signin">Đăng xuất</a></li>
            <?php } else { ?>
                <li class="li-index"><a href="register.php" id="signup">Đăng ký</a></li>
                <li class="li-index"><a href="login.php" id="signin">Đăng nhập</a></li>
            <?php } ?>
        </ul>
        <form class="c-search" action="" method="get">
            <div class="header_search">
                <input type="text" class="search_input" name="search" placeholder="Nhập tên sản phẩm">
                <button type="submit"><i class="fas fa-search"></i></button>
            </div>
        </form>
        <a class="cart" href="checkout.php">
                    <i class="fa fa-shopping-cart"></i>
                    <sup class="sumItem">
                        <?= ($totalQty['total']) ? $totalQty['total'] : "0" ?>
                    </sup>
        </a>
    </nav>
    <hr style="margin: 122px 177px -102px 177px;color: black;border: 1px solid;">
    <div class="featurecheckout">
        <h1>Giỏ hàng</h1>
    </div>
    <hr style="margin: 0px 177px 0 177px;color: black;border: 1px solid;">
    <div class="container-checkout">
        <?php
        if ($list) { ?>
            <div class="tableContainer">
            <table class="order">
                <tr>
                    <th>STT</th>
                    <th>Tên sản phẩm</th>
                    <th>Hình ảnh</th>
                    <th>Đơn giá</th>
                    <th>Số lượng</th>
                    <th>Thao tác</th>
                </tr>
                <?php
                $count = 1;
                foreach ($list as $key => $value) { ?>
                    <tr>
                        <td><?= $count++ ?></td>
                        <td><?= $value['productName'] ?></td>
                        <td><img class="image-cart" src="admin/uploads/<?= $value['productImage'] ?>"></td>
                        <td><?= number_format($value['productPrice'], 0, '', ',') ?>VND </td>
                        <td>
                            <input id="<?= $value['productId'] ?>" type="number" name="qty" class="qty" value="<?= $value['qty'] ?>" onchange="update(this)" min="1">
                        </td>
                        <td>
                            <a style="color: black;" href="delete_cart.php?id=<?= $value['id'] ?>"><i class="fa fa-trash" aria-hidden="true"></i></a>
                        </td>
                    </tr>
                <?php }
                ?>
            </table>
            </div>
            <div class="orderinfo">
                <div class="buy">
                    <h3>Thông tin đơn đặt hàng</h3>
                    <div>
                        Người đặt hàng: <b><?= $userInfo['fullname'] ?></b>
                    </div>
                    <div>
                        Số lượng: <b id="qtycart"><?= $totalQty['total'] ?></b>
                    </div>
                    <div>
                        Tổng tiền: <b id="totalcart"><?= number_format($totalPrice['total'], 0, '', ',') ?>VND</b>
                    </div>
                    <div>
                        Địa chỉ nhận hàng: <b><?= $userInfo['address'] ?></b>
                    </div>
                    <div class="buy-btn">
                        <a href="check_cart.php?status=<?= $userInfo['status'] ?> &userId=<?= $userInfo['id'] ?>">Tiến hành đặt hàng</a>
                    </div>
                </div>
            </div>
        <?php } else { ?>
            <h3>Giỏ hàng hiện đang rỗng</h3>
        <?php }
        ?>
    </div>
    </div>
    <footer>
        <div class="social">
            <a href="#"><i class="fa fa-facebook" aria-hidden="true"></i></a>
            <a href="#"><i class="fa fa-twitter" aria-hidden="true"></i></a>
            <a href="#"><i class="fa fa-instagram" aria-hidden="true"></i></a>
        </div>
        <ul class="list">
            <li>
                <a href="./">Trang Chủ</a>
            </li>
            <li>
                <a href="productList.php">Sản Phẩm</a>
            </li>
        </ul>
        <p class="copyright">copy by IVYmoda.com 2024</p>
    </footer>
</body>
<script type="text/javascript">
    function update(e) {
        var http = new XMLHttpRequest();
        var url = 'update_cart.php';
        var params = "productId=" + e.id + "&qty=" + e.value;
        http.open('POST', url, true);

        http.setRequestHeader('Content-type', 'application/x-www-form-urlencoded');

        http.onreadystatechange = function() {
            if (http.readyState === XMLHttpRequest.DONE) {
                var status = http.status;
                if (status === 200) {
                    var arr = http.responseText;
                    var b = false;
                    var result = "";
                    for (let index = 0; index < arr.length; index++) {
                        if (arr[index] == "[") {
                            b = true;
                        }
                        if (b) {
                            result += arr[index];
                        }
                    }
                    var arrResult = JSON.parse(result.replace("undefined", ""));
                    console.log(arrResult);
                    document.getElementById("totalQtyHeader").innerHTML = arrResult[1]['total'];
                    document.getElementById("qtycart").innerHTML = arrResult[1]['total'];
                    document.getElementById("totalcart").innerHTML = arrResult[0]['total'].replace(/(\d)(?=(\d{3})+(?!\d))/g, "$1,") + "VND";

                    //alert('Đã cập nhật giỏ hàng!');
                } else if (status === 501) {
                    alert('Số lượng sản phẩm không đủ để thêm vào giỏ hàng!');
                    e.value = parseInt(e.value) - 1;
                } else {
                    alert('Cập nhật giỏ hàng thất bại!');
                    window.location.reload();
                }
            }

        }
        http.send(params);
    }

    var list = document.getElementsByClassName("qty");
    for (let item of list) {
        item.addEventListener("keypress", function(evt) {
            evt.preventDefault();
        });
    }
</script>

</html>