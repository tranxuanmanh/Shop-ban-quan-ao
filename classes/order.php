<?php
$filepath = realpath(dirname(__FILE__));
include_once($filepath . '/../lib/database.php');
include_once($filepath . '/../lib/session.php');
include_once($filepath . '/../classes/cart.php');
include_once($filepath . '/../classes/product.php');
include_once($filepath . '/../lib/PHPMailer.php');
include_once($filepath . '/../lib/SMTP.php');
include_once($filepath . '/../lib/Exception.php');

use PHPMailer\PHPMailer\PHPMailer;
?>


 
<?php
/**
 * 
 */
class order
{
    private $db;
    public function __construct()
    {
        $this->db = new Database();
    }
    public function add($data)
    {
        $fullName = $data['fullName'];
        $phoneNumber = $data['phoneNumber'];
        $address = $data['address'];

        $userId = Session::get('userId');
        //Add new order
        $sql_insert_cart = "INSERT INTO orders VALUES(NULL,'$userId','" . date('y/m/d') . "',NULL,'Processing', '$fullName', '$phoneNumber', ' $address' )";
        $insert_cart = $this->db->insert($sql_insert_cart);
        if (!$insert_cart) {
            return false;
        }

        //Get cart list by userId
        $cart = new cart();
        $cart_user = $cart->get();

        //Get last orderid
        $sql_get_cart_last_id = "SELECT id FROM orders ORDER BY id DESC LIMIT 1";
        $get_cart_last_id = $this->db->select($sql_get_cart_last_id);
        if ($get_cart_last_id) {
            $orderId = mysqli_fetch_row($get_cart_last_id)[0];
        }

        //Update product qty
        $product = new product();
        foreach ($cart_user as $key => $value) {
            //Add item cart to order detail
            $sql_insert_order_details = "INSERT INTO order_details VALUES(NULL,'$orderId'," . $value['productId'] . "," . $value['qty'] . "," . $value['productPrice'] . ",'" . $value['productName'] . "','" . $value['productImage'] . "')";
            $insert_order_details = $this->db->insert($sql_insert_order_details);
            if (!$insert_order_details) {
                return false;
            }

            $product->updateQty($value['productId'], $value['qty']);
            if (!$product) {
                return false;
            }
        }

        //Delete cart
        $sql_delete_cart = "DELETE FROM cart WHERE userId = $userId";
        $delete_cart = $this->db->delete($sql_delete_cart);
        if ($delete_cart) {
            return true;
        }

        return false;
    }


    function updateReceivedDateOrder($id)
    {
        $query = "UPDATE orders SET receivedDate = '" . Date('y/m/d', strtotime('+3 days')) . "' WHERE id = $id";
        $mysqli_result = $this->db->update($query);
        if ($mysqli_result) {
            return true;
        }
        return false;
    }

    public function getOrderByUser()
    {
        $userId = Session::get('userId');
        $query = "SELECT * FROM orders WHERE userId = '$userId' ";
        $mysqli_result = $this->db->select($query);
        if ($mysqli_result) {
            $result = mysqli_fetch_all($this->db->select($query), MYSQLI_ASSOC);
            return $result;
        }
        return false;
    }

    public function getById($id)
    {
        $query = "SELECT * FROM orders WHERE id = '$id' ";
        $mysqli_result = $this->db->select($query);
        if ($mysqli_result) {
            $result = mysqli_fetch_all($this->db->select($query), MYSQLI_ASSOC)[0];
            return $result;
        }
        return false;
    }

    public function getProcessingOrder()
    {
        $query = "SELECT * FROM orders WHERE status = 'Processing'";
        $mysqli_result = $this->db->select($query);
        if ($mysqli_result) {
            $result = mysqli_fetch_all($this->db->select($query), MYSQLI_ASSOC);
            return $result;
        }
        return false;
    }

    public function getProcessedOrder()
    {
        $query = "SELECT * FROM orders WHERE status = 'Processed'";
        $mysqli_result = $this->db->select($query);
        if ($mysqli_result) {
            $result = mysqli_fetch_all($this->db->select($query), MYSQLI_ASSOC);
            return $result;
        }
        return false;
    }

    public function getDeliveringOrder()
    {
        $query = "SELECT * FROM orders WHERE status = 'Delivering'";
        $mysqli_result = $this->db->select($query);
        if ($mysqli_result) {
            $result = mysqli_fetch_all($this->db->select($query), MYSQLI_ASSOC);
            return $result;
        }
        return false;
    }

    public function getCompleteOrder()
    {
        $query = "SELECT * FROM orders WHERE status = 'Complete' OR status = 'Delivered'";
        $mysqli_result = $this->db->select($query);
        if ($mysqli_result) {
            $result = mysqli_fetch_all($this->db->select($query), MYSQLI_ASSOC);
            return $result;
        }
        return false;
    }

    public function getCancelOrder()
    {
        $query = "SELECT * FROM orders WHERE status = 'Cancel' OR status = 'Spam'";
        $mysqli_result = $this->db->select($query);
        if ($mysqli_result) {
            $result = mysqli_fetch_all($this->db->select($query), MYSQLI_ASSOC);
            return $result;
        }
        return false;
    }

    public function processedOrder($id)
    {
        $query = "UPDATE orders SET status = 'Processed' WHERE id = $id";
        $mysqli_result = $this->db->update($query);
        if ($mysqli_result) {
            if ($this->updateReceivedDateOrder($id)) {
                return true;
            }
        }
        return false;
    }

    public function spamOrder($id)
    {
        $query = "SELECT userId FROM orders WHERE id = $id";
        $mysqli_result = $this->db->select($query);
        if ($mysqli_result){
            $row = $mysqli_result->fetch_assoc();
            $userId = $row['userId'];
            $query1 = "UPDATE orders SET status = 'Spam' WHERE id = $id";
            $mysqli_result1 = $this->db->update($query1);

            $query2 = "UPDATE users SET status = 2 WHERE id = $userId";
            $mysqli_result2 = $this->db->update($query2);

            if ($mysqli_result1 && $mysqli_result2) {
                $targetDate = date('Y-m-d', strtotime('+10 days'));
                $query3 = "UPDATE orders SET receivedDate = '$targetDate' WHERE id = $id";
                $mysqli_result3 = $this->db->update($query3);
                return true;
            }
            return false;
        }
        return false;
    }

    public function cancelOrder($id)
    {
        $query = "UPDATE orders SET status = 'Cancel' WHERE id = $id";
        $mysqli_result = $this->db->update($query);
        if ($mysqli_result) {
            return true;
        }
        return false;
    }

    public function deliveringOrder($id)
    {
        $query = "UPDATE orders SET status = 'Delivering' WHERE id = $id";
        $mysqli_result = $this->db->update($query);
        if ($mysqli_result) {
            return true;
        }
        return false;
    }

    public function completeOrder($id)
    {
        $query = "UPDATE orders SET status = 'Complete', receivedDate = '" . date('y/m/d') . "' WHERE id = $id";
        $mysqli_result = $this->db->update($query);
        if ($mysqli_result) {
            return true;
        }
        return false;
    }

    public function deliveredOrder($id)
    {
        $query = "UPDATE orders SET status = 'Delivered' WHERE id = $id";
        $mysqli_result = $this->db->update($query);
        if ($mysqli_result) {
            return true;
        }
        return false;
    }

    public function deleteOrder($id)
    {
        $query = "DELETE FROM order_details WHERE orderId = $id";
        $mysqli_result = $this->db->delete($query);
        if ($mysqli_result) {
            $query1 = "DELETE FROM orders WHERE id = $id";
            $mysqli_result1 = $this->db->delete($query1);
            if ($mysqli_result1) {
                return true;
            }
            return false;
        }
        return false;
    }

    public function getDate($id)
    {
        $query = "SELECT `receivedDate` FROM `orders` WHERE `userId` = $id AND `status` = 'Spam' LIMIT 1";
        $mysqli_result = $this->db->select($query);
        if ($mysqli_result) {
            return $mysqli_result;
        }
        return false;
    }

    public function toOrderCancel($id)
    {
        $query = "UPDATE orders SET status = 'Cancel' WHERE userId = $id AND status = 'Spam'";
        $mysqli_result = $this->db->update($query);
        if ($mysqli_result) {
            return true;
        }
        return false;
    }


    public function messCompleted($userId)
	{
		$query = "SELECT * FROM users WHERE id = $userId LIMIT 1";
		$result = $this->db->select($query);
        $email_check = $result->fetch_assoc();
        $email = $email_check['email'];
		if ($email) {
            // Send email
            $mail = new PHPMailer();
            $mail->IsSMTP();
            $mail->Mailer = "smtp";

            $mail->SMTPDebug  = 0;
            $mail->SMTPAuth   = TRUE;
            $mail->SMTPSecure = "tls";
            $mail->Port       = 587;
            $mail->Host       = "smtp.gmail.com";
            $mail->Username   = "buihuyhai@gmail.com";
            $mail->Password   = "udfhechjekxifivj";

            $mail->IsHTML(true);
            $mail->CharSet = 'UTF-8';
            $mail->AddAddress($email, "recipient-name");
            $mail->SetFrom("buihuyhai@gmail@gmail.com", "HB-shop");
            $mail->Subject = "Giao hàng thành công - HB-SHOP";
            $mail->Body = "<h3>Đơn hàng đã được giao thành công! <br> Nếu bạn chưa nhận được hàng xin liên hệ chúng tôi sớm nhất để được xử lý! <br> Cảm ơn bạn đã mua hàng tại HB-Shop >.<";

            $mail->Send();

			return true;
		} 
        else {
            return false;
        }
	}

    public function get($orderId)
    {
        $query = "SELECT * FROM order_details WHERE orderId = '$orderId' ";
        $mysqli_result = $this->db->select($query);
        if ($mysqli_result) {
            $result = mysqli_fetch_all($mysqli_result, MYSQLI_ASSOC);
            return $result;
        }
        return false;
    }
    

}
?>