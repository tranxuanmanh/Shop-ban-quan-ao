<?php
include_once 'lib/session.php';
Session::checkSession('client');
include_once 'classes/order.php';


if ($_SERVER['REQUEST_METHOD'] == 'POST') {
    $order = new order();
    $result = $order->add($_POST);
    if ($result) {
        echo '<script type="text/javascript">alert("Đặt hàng thành công!"); window.location.href = "order.php";</script>';
    }
    else {
        echo '<script type="text/javascript">alert("Đặt hàng thất bại!"); history.back();</script>';
    }
    
}
