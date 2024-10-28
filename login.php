<?php
include 'classes/user.php';
$user = new user();
if ($_SERVER['REQUEST_METHOD'] == 'POST') {
    $email = $_POST['email'];
    $password = md5($_POST['password']);
    $login_check = $user->login($email, $password);
}
?>

<?php
include_once 'lib/session.php';
include_once 'classes/product.php';
include_once 'classes/cart.php';

$cart = new cart();
$totalQty = $cart->getTotalQtyByUserId();
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
    <title>Đăng nhập</title>
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
                <li class="li-index"><a href="info.php" id="signin"  >Thông tin cá nhân</a></li>
                <li class="li-index"><a href="logout.php" id="signin">Đăng xuất</a></li>
            <?php } else { ?>
                <li class="li-index"><a href="register.php" id="signup">Đăng ký</a></li>
                <li class="li-index"><a href="login.php" id="signin" class="active"> Đăng nhập</a></li>
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

    <div class="dangNhapContainer">
        <div class="dangNhap">
            <h1>Đăng nhập</h1>
        </div>
        <div class="container-single">
            <div class="login">
             <form action="login.php" method="post" class="form-login">
                <label for="email">Email</label>
                <input type="email" id="email" name="email" placeholder="Email..." required>

                <label for="password">Mật khẩu</label>
                <input type="password" id="password" name="password" placeholder="Mật khẩu..." required>
                <p style="color: red;"><?= !empty($login_check) ? $login_check : '' ?></p>

                <a href="forgot_password.php">Quên mật khẩu?</a>   
                <input type="submit" value="Đăng nhập" class="dangNhapbtn">
             </form>
            </div>
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

</html>