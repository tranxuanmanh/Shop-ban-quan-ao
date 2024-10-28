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
include_once '../classes/product.php';
include_once '../classes/orderDetails.php';
include_once '../classes/statistical.php';

if (isset($_GET['orderId'])) {

    $orderDetails = new orderDetails();
    $totalPrice = $orderDetails->getTotalPriceByUserId($_GET['orderId']);
    $totalQty = $orderDetails->getTotalQtyByUserId($_GET['orderId']);

    $order = new order();
    $result = $order->deliveredOrder($_GET['orderId']);
    $listProduct = $order->get($_GET['orderId']);
    
    $product = new product();
    foreach ($listProduct as $key => $value) {
        $check = $product->updateSold($value['productId'], $value['qty']);
    }

    $statistical = new statistical();
    $addst = $statistical->getStatistical($_GET['orderId'], $totalPrice['total'], $totalQty['total']);


    $user = new user();
    $id = $user->getUserByOrder($_GET['orderId']);
    $usId = $id['id'];
    $mess = $order->messCompleted($usId);
    if ($result && $mess) {
        echo '<script type="text/javascript">alert("Thành công!"); history.back();</script>';
    } else {
        echo '<script type="text/javascript">alert("Thất bại!"); history.back();</script>';
    }
}