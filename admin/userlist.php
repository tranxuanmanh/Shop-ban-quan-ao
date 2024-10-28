<?php
include '../lib/session.php';
include '../classes/user.php';
Session::checkSession('admin');
$role_id = Session::get('role_id');
if ($role_id == 1) {
    # code...
} else {
    header("Location:../index.php");
}

if ($_SERVER['REQUEST_METHOD'] == 'POST') {
    $user = new user();
    if (isset($_POST['block'])) {
        $result = $user->block($_POST['id']);
        if ($result) {
            echo '<script type="text/javascript">alert("Khóa người dùng thành công!");</script>';
        } else {
            echo '<script type="text/javascript">alert("Khóa người dùng thất bại!");</script>';
        }
    } else if (isset($_POST['active'])) {
        $result = $user->active($_POST['id']);
        if ($result) {
            echo '<script type="text/javascript">alert("Kích hoạt người dùng thành công!");</script>';
        } else {
            echo '<script type="text/javascript">alert("Kích hoạt người dùng thất bại!");</script>';
        }
    } else {
        echo '<script type="text/javascript">alert("Có lỗi xảy ra!");</script>';
        die();
    }
}

$user = new user();
$list = $user->getAllAdmin((isset($_GET['page']) ? $_GET['page'] : 1));
$pageCount = $user->getCountPaging();

if (isset($_GET['search'])) {
    $search = addslashes($_GET['search']);
    if (empty($search)) {
        echo '<script type="text/javascript">alert("Yêu cầu dữ liệu không được để trống!");</script>';
    } else {
        $list = $user->getUserByName($search);
        // echo '<script type="text/javascript">alert("Tính năng này đang bảo trì");</script>';
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
    <title>Danh sách Người dùng</title>
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
            <li><a href="orderlist.php">Quản lý Đơn hàng</a></li>
            <li><a href="userlist.php" class="active">Quản lý Người dùng</a></li>
            <li><a href="chartms.php">Thống kê</a></li>
            <li><a href="transfer.php">Chuyển về trang chủ</a></li>
        </ul>
    </nav>
    <div class="title">
        <h1>Danh sách người dùng</h1>
    </div>
    <div class="control-container">
        <div></div>
        <form class="c-search" action="" method="get">
            <input type="text" name="search" placeholder="Nhập tên người dùng">
            <button type="submit"><i class="fas fa-search"></i></button>
        </form>
    </div>
    <div class="container">
        <?php $count = 1;
        if ($list) { ?>
            <table class="list">
                <tr>
                    <th>STT</th>
                    <th>Họ và tên</th>
                    <th>Ngày sinh</th>
                    <th>Quê quán</th>
                    <th>Email</th>
                    <th>Chức vụ</th>
                    <th>Trạng thái</th>
                    <th>Thao tác</th>
                </tr>
                <?php foreach ($list as $key => $value) { ?>
                    <tr>
                        <td><?= $count++ ?></td>
                        <td style="text-align: left; padding-left: 6px;"><?= $value['fullname'] ?></td>
                        <td><?= $value['dob'] ?></td>
                        <td style="text-align: left; padding-left: 6px;"><?= $value['address'] ?></td>
                        <td style="text-align: left; padding-left: 6px;"><?= $value['email'] ?></td>
                        <td><?php if ($value['role_id'] == 1) {
                                echo "Admin";
                            }else if($value['role_id'] == 3){
                                echo "Staff";
                            } 
                            else echo "Khách hàng" ?></td>
                        <td><?= ($value['status']) ? "Active" : "Block" ?></td>
                        <td>
                            <?php
                            if ($value['role_id'] == 1) { ?>
                                <button class="btn-none"></button>
                            <?php } else {
                                if ($value['status']) { ?>
                                    <form action="userlist.php" method="post">
                                        <input type="text" name="id" hidden value="<?= $value['id'] ?>" style="display: none;">
                                        <input type="submit" value="Khóa" name="block">
                                    </form>
                                <?php } else { ?>
                                    <form action="userlist.php" method="post">
                                        <input type="text" name="id" hidden value="<?= $value['id'] ?>" style="display: none;">
                                        <input type="submit" value="Mở" name="active">
                                    </form>
                            <?php } } ?>
                        </td>
                    </tr>
                <?php } ?>
            </table>
        <?php } else { ?>
            <h3>...</h3>
        <?php } ?>
        <div class="pagination">
            <a href="userlist.php?page=<?= (isset($_GET['page'])) ? (($_GET['page'] <= 1) ? 1 : $_GET['page'] - 1) : 1 ?>">&laquo;</a>
            <?php
            for ($i = 1; $i <= $pageCount; $i++) {
                if (isset($_GET['page'])) {
                    if ($i == $_GET['page']) { ?>
                        <a class="active" href="userlist.php?page=<?= $i ?>"><?= $i ?></a>
                    <?php } else { ?>
                        <a href="userlist.php?page=<?= $i ?>"><?= $i ?></a>
                    <?php  }
                } else {
                    if ($i == 1) { ?>
                        <a class="active" href="userlist.php?page=<?= $i ?>"><?= $i ?></a>
                    <?php  } else { ?>
                        <a href="userlist.php?page=<?= $i ?>"><?= $i ?></a>
                    <?php   } ?>
                <?php  } ?>
            <?php }
            ?>
            <a href="userlist.php?page=<?= (isset($_GET['page'])) ? $_GET['page'] + 1 : 1 ?>">&raquo;</a>
        </div>
    </div>
    </div>
    <footer>
        <p class="copyright">copy by IVYmoda.com 2024</p>
    </footer>
</body>

</html>