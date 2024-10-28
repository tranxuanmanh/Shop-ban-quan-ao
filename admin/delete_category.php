<?php
include '../lib/session.php';
include '../classes/product.php';
include '../classes/categories.php';
Session::checkSession('admin');
$role_id = Session::get('role_id');

if (isset($_GET['id'])) {
    $c = new categories();
    $result = $c->delete($_GET['id']);
    if ($result) {
        echo '<script type="text/javascript">alert("Xóa sản phẩm thành công!"); history.back();</script>';
    } else {
        echo '<script type="text/javascript">alert("Xóa sản phẩm thất bại!"); history.back();</script>';
    }
}
