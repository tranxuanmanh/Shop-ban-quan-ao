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
include_once '../classes/user.php';

if (isset($_GET['orderId'])) {
    $user = new user();
    $id = $user->getUserByOrder($_GET['orderId']);
    $result1 = $user->updateStatus($id['id']);

    $order = new order();
    $result = $order->deleteOrder($_GET['orderId']);
    
    if ($result && $result1) {
        echo '<script type="text/javascript">alert("Thành công!"); history.back();</script>';
    } else {
        echo '<script type="text/javascript">alert("Thất bại!"); history.back();</script>';
    }
}