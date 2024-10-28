<?php
include_once '../lib/session.php';
Session::checkSession('admin');
$role_id = Session::get('role_id');
if ($role_id == 1) {
    # code...
} else {
    header("Location:../index.php");
}
include_once '../classes/order.php';

if (isset($_GET['orderId'])) {
    $order = new order();
    $result = $order->cancelOrder($_GET['orderId']);
    if ($result) {
        echo '<script type="text/javascript">alert("Thành công!"); window.location.href = "orderlist.php";</script>';
    } else {
        echo '<script type="text/javascript">alert("Thất bại!"); history.back();</script>';
    }
}