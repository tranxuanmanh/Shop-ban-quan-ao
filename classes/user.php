<?php
$filepath = realpath(dirname(__FILE__));
include_once($filepath . '/../lib/session.php');
include_once($filepath . '/../lib/database.php');
include_once($filepath . '/../lib/PHPMailer.php');
include_once($filepath . '/../lib/SMTP.php');
include_once($filepath . '/../lib/Exception.php');

use PHPMailer\PHPMailer\PHPMailer;
?>

<?php
/**
 * 
 */
class user
{
	private $db;
	public function __construct()
	{
		$this->db = new Database();
	}

	public function login($email, $password)
	{
		$query = "SELECT * FROM users WHERE email = '$email' AND password = '$password'";
		$result = $this->db->select($query);
		if ($result) {
			$value = $result->fetch_assoc();
			if ($value['status'] == 0 || $value['isConfirmed'] == 0) {
				$alert = "Tài khoản bạn đang bị khóa hoặc chưa được xác nhận. Vui lòng liên hệ với ADMIN để được xử lý!";
				return $alert;
			} else {
				Session::set('user', true);
				Session::set('userId', $value['id']);
				Session::set('role_id', $value['role_id']);
				header("Location:index.php");
			}
		} else {
			$alert = "Tên đăng nhập hoặc mật khẩu không đúng!";
			return $alert;
		}
	}

	public function insert($data)
	{
		$fullName = $data['fullName'];
		$email = $data['email'];
		$dob = $data['dob'];
		$address = $data['address'];
		$password = md5($data['password']);


		$check_email = "SELECT * FROM users WHERE email='$email' LIMIT 1";
		$result_check = $this->db->select($check_email);

		
		if ($result_check) {
			$check_confirm = "SELECT isConfirmed FROM users WHERE email='$email' LIMIT 1";
			$result_confirm = $this->db->select($check_confirm);
			$confirm_row = $result_confirm->fetch_assoc();
			if($confirm_row['isConfirmed']){
				return 'Email đã tồn tại!';
			} else{
				$query1 = "DELETE FROM users WHERE email='$email'";
				$row1 = $this->db->delete($query1);
				if ($row1) {
					return 'Email tồn tại nhưng chưa xác minh. Hãy đăng ký lại!';
				}
				return false;
			}
		} else {
			// Genarate captcha
			$captcha = rand(10000, 99999);

			$query = "INSERT INTO users VALUES (NULL,'$email','$fullName','$dob','$password',2,1,'$address',0,'" . $captcha . "') ";
			$result = $this->db->insert($query);
			if ($result) {
				// Send email
				$mail = new PHPMailer();
				$mail->IsSMTP();
				$mail->Mailer = "smtp";

				$mail->SMTPDebug  = 0;
				$mail->SMTPAuth   = TRUE;
				$mail->SMTPSecure = "tls";
				$mail->Port       = 587;
				$mail->Host       = "smtp.gmail.com";
				$mail->Username   = "nguyenthdat7680@gmail.com";
				$mail->Password   = "udfhechjekxifivj";

				$mail->IsHTML(true);
				$mail->CharSet = 'UTF-8';
				$mail->AddAddress($email, "recipient-name");
				$mail->SetFrom("nguyenthdat7680@gmail.com", "HB-shop");
				$mail->Subject = "Xác nhận email tài khoản - HB-shop";
				$mail->Body = "<h3>Cảm ơn bạn đã đăng ký tài khoản tại website HB-shop </h3></br>Đây là mã xác minh tài khoản của bạn: " . $captcha . "";

				$mail->Send();

				return true;
			} else {
				return false;
			}
		}
	}


	public function update($data)
	{
		$userId = Session::get('userId');
		$fullName = $data['fullName'];
		$email = $data['email'];
		$dob = $data['dob'];
		$address = $data['address'];
		$password = md5($data['password']);

		$query = "UPDATE users SET email = '$email', fullname = '$fullName', dob = '$dob', password = '$password', address = '$address' WHERE id = '$userId' ";
		$result = $this->db->update($query);
		return $result;
	}

	public function get()
	{
		$userId = Session::get('userId');
		$query = "SELECT * FROM users WHERE id = '$userId' LIMIT 1";
		$mysqli_result = $this->db->select($query);
		if ($mysqli_result) {
			$result = mysqli_fetch_all($this->db->select($query), MYSQLI_ASSOC)[0];
			return $result;
		}
		return false;
	}

	public function getUserById($id)
	{
		$query = "SELECT * FROM users where id = '$id'";
		$result = $this->db->select($query);
		return $result;
	}

	public function getAllAdmin($page = 1, $total = 8)
	{
		if ($page <= 0) {
			$page = 1;
		}
		$tmp = ($page - 1) * $total;
		$query =
			"SELECT users.*, role.name as roleName
			 FROM users INNER JOIN role ON users.role_id = role.id
             limit $tmp,$total";
		$result = $this->db->select($query);
		return $result;
	}

	public function getAll()
	{
		$query =
			"SELECT users.*, role.name as cateName
			 FROM users INNER JOIN role ON users.role_id = role.id";
		$result = $this->db->select($query);
		return $result;
	}

	public function getCountPaging($row = 8)
	{
		$query = "SELECT COUNT(*) FROM users";
		$mysqli_result = $this->db->select($query);
		if ($mysqli_result) {
			$totalrow = intval((mysqli_fetch_all($mysqli_result, MYSQLI_ASSOC)[0])['COUNT(*)']);
			$result = ceil($totalrow / $row);
			return $result;
		}
		return false;
	}

	public function getUserByName($name_u)
	{
		$query =
			"SELECT *
			 FROM users
			 WHERE fullname LIKE '%$name_u%'";
		$mysqli_result = $this->db->select($query);
		if ($mysqli_result) {
			$result = mysqli_fetch_all($mysqli_result, MYSQLI_ASSOC);
			return $result;
		}
		return false;
	}

	public function getLastUserId()
	{
		$query = "SELECT * FROM users ORDER BY id DESC LIMIT 1";
		$mysqli_result = $this->db->select($query);
		if ($mysqli_result) {
			$result = mysqli_fetch_all($this->db->select($query), MYSQLI_ASSOC)[0];
			return $result;
		}
		return false;
	}

	public function confirm($userId, $captcha)
	{
		$query = "SELECT * FROM users WHERE id = '$userId' AND captcha = '$captcha' LIMIT 1";
		$mysqli_result = $this->db->select($query);
		if ($mysqli_result) {
			// Update comfirmed
			$sql = "UPDATE users SET isConfirmed = 1 WHERE id = $userId";
			$update = $this->db->update($sql);
			if ($update) {
				return true;
			}
		}
		return 'Mã xác minh không đúng!';
	}

	public function block($id)
	{
		$query = "UPDATE users SET status = 0 where id = '$id'";
		$result = $this->db->delete($query);
		if ($result) {
			return true;
		} else {
			return false;
		}
	}

	public function delete($id)
	{
		$query = "DELETE FROM users WHERE id = $id";
		$row = $this->db->delete($query);
		if ($row) {
			return true;
		}
		return false;
	}

	public function active($id)
	{
		$query = "UPDATE users SET status = 1 where id = '$id'";
		$result = $this->db->delete($query);
		if ($result) {
			return true;
		} else {
			return false;
		}
	}
	public function updateStatus($id)
	{
		$query = "UPDATE users SET `status` = 1 where id = '$id' ";
		$result = $this->db->update($query);
		if ($result) {
			return true;
		} else {
			return false;
		}
	}

	public function getUserByOrder($orderId)
	{
		$query1 = "SELECT * FROM orders WHERE id = '$orderId'";
		$mysqli_result1 = $this->db->select($query1);
		$user = $mysqli_result1->fetch_assoc();
		$userId = $user['userId'];
		$query = "SELECT * FROM users WHERE id = $userId LIMIT 1";
		$mysqli_result = $this->db->select($query);
		if ($mysqli_result) {
			$result = mysqli_fetch_all($this->db->select($query), MYSQLI_ASSOC)[0];
			return $result;
		}
		return false;
	}

	public function getPassword($email)
	{
		$check_email = "SELECT * FROM users WHERE email='$email' LIMIT 1";
		$result_check = $this->db->select($check_email);
		if ($result_check) {
			// Genarate captcha
			$newPassword = rand(10000, 99999);
			$newPass = md5($newPassword);
			$query = "UPDATE `users` SET `password` = '$newPass' WHERE `email` = '$email'";
			$result = $this->db->update($query);
			if ($result) {
				// Send email
				$mail = new PHPMailer();
				$mail->IsSMTP();
				$mail->Mailer = "smtp";

				$mail->SMTPDebug  = 0;
				$mail->SMTPAuth   = TRUE;
				$mail->SMTPSecure = "tls";
				$mail->Port       = 587;
				$mail->Host       = "smtp.gmail.com";
				$mail->Username   = "nguyenthdat7680@gmail.com";
				$mail->Password   = "udfhechjekxifivj";

				$mail->IsHTML(true);
				$mail->CharSet = 'UTF-8';
				$mail->AddAddress($email, "recipient-name");
				$mail->SetFrom("nguyenthdat7680@gmail.com", "HB-shop");
				$mail->Subject = "Lấy lại mật khẩu - HB-shop";
				$mail->Body = "<h3>Mật khẩu mới của bạn là: " . $newPassword . ". Bạn nên đổi lại mật khẩu dễ nhớ trong phần chỉnh sửa thông tin nhé >.<";

				$mail->Send();

				return true;
			} else {
				return false;
			}
		} else {
			return 'Email chưa tồn tại!';
		}
	}


}
?>