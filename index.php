<?php
include_once 'lib/session.php';
include_once 'classes/product.php';
include_once 'classes/cart.php';

$cart = new cart();
$totalQty = $cart->getTotalQtyByUserId();

$product = new product();
$list = mysqli_fetch_all($product->getFeaturedProducts(), MYSQLI_ASSOC);
?>
<?php
    if (isset($_GET['search'])) {
        $search = addslashes($_GET['search']);
        if (empty($search)) {
            echo '<script type="text/javascript">alert("Yêu cầu dữ liệu không được để trống!");</script>';
        } else {
            $list = $product->getProductByName($search);
           
        }
    } 
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
    <script src="http://ajax.googleapis.com/ajax/libs/jquery/1/jquery.min.js"></script>
    <script>
        $(function() {
            $('.fadein img:gt(0)').hide();
            setInterval(function() {
                $('.fadein :first-child').fadeOut().next('img').fadeIn().end().appendTo('.fadein');
            }, 1500);
        });
    </script>
</head>

<body>
<nav>
        <label class="logo"><a href="index.php">IVY Moda</a></label>
        <ul id="dc_mega-menu-orange">
            <li class="li-index"><a href="index.php" class="active">Trang chủ</a></li>
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
    <section class="banner">
        <div class="fadein">
            <?php
            // display images from directory
            // directory path
            $dir = "./images/slider/";
            $scan_dir = scandir($dir);
            foreach ($scan_dir as $img) :
                if (in_array($img, array('.', '..')))
                    continue;
            ?>
                <img src="<?php echo $dir . $img ?>" alt="<?php echo $img ?>">
            <?php endforeach; ?>
        </div>
    </section>
    <!-- <div class="featuredProducts">
        <h1>Tất cả sản phẩm</h1>
    </div> -->
    <div class="title">
    NEW ARRIVAL - SALE OFF 20% + QUÀ TẶNG 0Đ BÊN DƯỚI
    </div>

    <div class="container" style="grid-template-columns: auto auto auto auto;">    
        <?php
        if ($list) {
        foreach ($list as $key => $value) { ?>
            <div class="card">
                <div class="imgBx">
                    <a href="detail.php?id=<?= $value['id'] ?>"><img src="admin/uploads/<?= $value['image'] ?>" alt="" title="<?= $value['name'] ?>"></a>
                </div>
                <div class="content">
                    <div class="productName">
                        <a href="detail.php?id=<?= $value['id'] ?>" title="<?= $value['name'] ?>">
                            <h3><?= $value['name'] ?></h3>
                        </a>
                    </div>
                    <div>
                        Đã bán: <?= $value['soldCount'] ?>
                    </div>
                    <div class="bothPrice">
                    <div class="price">
                        <?= number_format($value['promotionPrice'], 0, '', ',') ?>đ
                    </div>
                    <div class="original-price">
                        <?php
                        if ($value['promotionPrice'] < $value['originalPrice']) { ?>
                             <del><?= number_format($value['originalPrice'], 0, '', ',') ?>đ</del>
                        <?php } else { ?>
                            <p>...</p>
                        <?php } ?>
                    </div>
                    </div>
                    <div class="action">
                        <a class="add-cart" href="add_cart.php?id=<?= $value['id'] ?>"><i class="fa fa-shopping-bag"></i></a>
                        <!-- <a class="detail" href="detail.php?id=<?= $value['id'] ?>">Xem chi tiết</a> -->
                    </div>
                </div>
            </div>
        <?php }?>
        <?php } else { ?>
            <h3>Chưa có sản phẩm nào...</h3>
        <?php } ?>
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