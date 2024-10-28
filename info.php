<?php
include_once 'lib/session.php';
include_once 'classes/product.php';
include_once 'classes/cart.php';
include 'classes/user.php';

$user = new user();
$userInfo = $user->get();

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
    <title>Trang chủ</title>
    <style>
        table,
        tr,
        td {
            border: none;
            /* background-color: #fff; */
            margin: 0;
            padding: 0;
            text-align: left;
            font-size: 18px;
        }

        td {
            margin: 10px;
            padding: 10px;
        }

        .container-info {
            width: 60%;
            display: flex;
            justify-content: center;
            flex: 1;
        }
    </style>
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
                <li class="li-index"><a href="info.php" id="signin" class="active" >Thông tin cá nhân</a></li>
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
    <div class="inforFeature">
        <h1>Thông tin cá nhân</h1>
    </div>
    <hr style="margin: 0px 177px 0 177px;color: black;border: 1px solid;">
    <div class="container-single-infor">
        <div class="container-info">
            <div class="image-info">
                <img src="./images/avt.png" alt="">
            </div>
            <div class="info">
                <table>
                    <tr>
                        <td>Họ và tên: </td>
                        <td><?= $userInfo['fullname'] ?></td>
                    </tr>
                    <tr>
                        <td>Email: </td>
                        <td><?= $userInfo['email'] ?></td>
                    </tr>
                    <tr>
                        <td>Ngày sinh: </td>
                        <td><?= $userInfo['dob'] ?></td>
                    </tr>
                    <tr>
                        <td>Địa chỉ: </td>
                        <td><?= $userInfo['address'] ?></td>
                    </tr>
                    <tr>
                        <td>Chức vụ: </td>
                        <td><?php if ($userInfo['role_id'] == 1) {
                                echo "Admin";
                            } 
                            elseif ($userInfo['role_id'] == 3){
                                echo "Nhân viên";
                            }
                            else {
                                echo "Khách hàng";
                            } ?>
                        </td>
                    </tr>
                </table>
                <?php if ($userInfo['role_id'] == 1) {
                    echo '<div><a class="infor_chuyen" href="./admin/index.php">Chuyển sang trang Admin</a></div>';
                }elseif ($userInfo['role_id'] == 3){
                    echo '<div><a class="infor_chuyen" href="./staff/index.php">Chuyển sang trang Staff</a></div>';
                }
                 else{
                    echo '<div><a class="infor_chuyen" href="edit_info.php">Chỉnh sửa thông tin cá nhân</a></div>';
                } ?>
            </div>
        </div>
    </div>
    <footer>
        <div class="social">
            <a href="https://www.facebook.com/dung.donald.10"><i class="fa fa-facebook" aria-hidden="true"></i></a>
            <a href="#"><i class="fa fa-twitter" aria-hidden="true"></i></a>
            <a href="https://www.instagram.com/hoangdung0.8.0.7/"><i class="fa fa-instagram" aria-hidden="true"></i></a>
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