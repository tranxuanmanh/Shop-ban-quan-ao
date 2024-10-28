<?php
include_once 'lib/session.php';
include_once 'classes/user.php';
Session::checkSession('client');
include_once 'classes/order.php';
include_once 'classes/cart.php';
include_once 'classes/product.php';
$order = new order();
$product = new product();
$cart = new cart();
$listProductId = $cart->getListProductIdInCartByUserId();
// print_r($listProductId);
foreach ($listProductId as $key => $value) {
    $ts = $value['productId'];
    $checkProduct = $product->checkQty($ts);
    if($checkProduct == false){
        $check = 1;
    }

}

if (isset($_GET['status']) && $_GET['status'] == 2) {
    $currentDate = date('Y-m-d');
    $mysqli_result = $order->getDate($_GET['userId']);
    $row = $mysqli_result->fetch_assoc();
    $targetDate = $row['receivedDate'];
    if($currentDate >= $targetDate) {
        $user = new user();
        $result = $user->updateStatus($_GET['userId']);
        $_GET['status'] = 1;
        $toOrderCancel = $order->toOrderCancel($_GET['userId']);
    }
    if($_GET['status'] == 2) {
        echo '<script type="text/javascript">alert("Tài khoản của bạn không thể đặt hàng trong 10 ngày do phát hiện có đơn spam!"); history.back();</script>';
    }
    else {
        if($check == 1){
            echo '<script type="text/javascript">alert("Số lượng hàng không đủ!"); history.back();</script>';
        }
        else{
            header("Location: delivery_address.php");
        }
        
    
    }
}
else {
    if($check == 1){
        echo '<script type="text/javascript">alert("Số lượng hàng không đủ!"); history.back();</script>';
    }
    else{
        header("Location: delivery_address.php");
    }

} 
