<?php
include 'classes/product.php';
include_once 'classes/cart.php';
include_once 'classes/categories.php';
$cart = new cart();
$totalQty = $cart->getTotalQtyByUserId();

$product = new product();
$list = $product->getProductsByCateId((isset($_GET['page']) ? $_GET['page'] : 1), (isset($_GET['cateId']) ? $_GET['cateId'] : 6));
$result = $product->getProductbyId($_GET['id']);
    if (!$result) {
    echo 'Không tìm thấy sản phẩm!';
    die();
    }
    if (isset($_GET['search'])) {
    $search = addslashes($_GET['search']);
    if (empty($search)) {
        echo '<script type="text/javascript">alert("Yêu cầu dữ liệu không được để trống!");</script>';
    } else {
        $list = $product->getProductByName($search);
       
    }
} 
?>
<?php
    
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
    <title><?= $result['name'] ?></title>
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
            <li class="li-index"><a href="productList.php">Sản phẩm</a></li>

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
    <hr>
    <div class="featuredProductsDetail">
        <h1>Sản phẩm</h1>
    </div>
    <hr style="
    height: 0px;
    margin: 0 100px;
    border: 2px solid;
    color: black;">
    <div class="container-single">
        <div class="image-product">
            <img src="admin/uploads/<?= $result['image'] ?>" alt="">
        </div>
        <div class="info">
            <div class="name">
                <h2><?= $result['name'] ?></h2>
            </div>
            <div class="detailBothPrice">
            <div class="price-single">
             <b><?= number_format($result['promotionPrice'], 0, '', ',') ?>VND</b>
            </div>
            <?php
            if ($result['promotionPrice'] < $result['originalPrice']) { ?>
                <div class="price-del">
              <del><?= number_format($result['originalPrice'], 0, '', ',') ?>VND</del>
                </div>
            <?php }
            ?>
            </div>
            <div class="des">
                <p>Số lượng còn: <?= $result['qty'] ?></p>
                <p>Đã bán: <?= $result['soldCount'] ?></p>
                <hr>
                <?= $result['des'] ?>
            </div>
            <div class="add-cart-single">
                <a href="add_cart.php?id=<?= $result['id'] ?>">Thêm vào giỏ</a>
            </div>
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