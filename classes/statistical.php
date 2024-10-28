<?php
$filepath = realpath(dirname(__FILE__));
include_once($filepath . '/../lib/database.php');
include_once($filepath . '/../lib/session.php');
include_once($filepath . '/../classes/statistical.php');
?>


 
<?php
/**
 * 
 */
class statistical
{
    private $db;
    public function __construct()
    {
        $this->db = new Database();
    }

    public function getStatistical($id, $sale, $quantity)
    {   

        $query = "SELECT receivedDate FROM orders WHERE id = $id ";
        $mysqli_result = $this->db->select($query);
        $row_order = $mysqli_result->fetch_assoc();
        $order_date = $row_order['receivedDate'];
        $profit = $sale;
        
        $query1 = "SELECT * FROM statistical WHERE order_date = '$order_date'";
        $mysqli_result1 = $this->db->select($query1);
        if($mysqli_result1){
            $query2 = 
            "UPDATE `statistical` SET `sales` = `sales` + '$sale', `profit` = `profit` + '$profit', 
            `quantity` = `quantity` + '$quantity', `total_order` = `total_order` + 1 
            WHERE `order_date` = '$order_date'";

            $mysqli_result2 = $this->db->update($query2);
        }
        else{
            $query3 = "INSERT INTO statistical VALUES (NULL, '$order_date', '$sale', '$profit', '$quantity', 1)";
            $mysqli_result3 = $this->db->insert($query3);
        }

    }

    public function getDatesInRange($startDate, $endDate) 
    {
        $dateArray = array();
        $currentDate = strtotime($startDate);
    
        while ($currentDate <= strtotime($endDate)) {
          $dateArray[] = date('Y-m-d', $currentDate);
          $currentDate = strtotime('+1 day', $currentDate);
        }
    
        return $dateArray;
    }

    public function filterByDate($start, $end) 
    {
        $query = "SELECT * FROM statistical WHERE order_date BETWEEN '$start' AND '$end'";
        $mysqli_result = $this->db->select($query);
        if ($mysqli_result) {
            $result = mysqli_fetch_all($this->db->select($query), MYSQLI_ASSOC);
            return $result;
        }
        return false;
    }

    public function getSumTotalOrder($start, $end) 
    {
        $query = "SELECT SUM(total_order) AS sum_order, SUM(sales) AS sum_sale, SUM(profit) AS sum_profit  FROM statistical WHERE order_date BETWEEN '$start' AND '$end'";
        $mysqli_result = $this->db->select($query);
        if ($mysqli_result) {
            $result = $mysqli_result->fetch_assoc();
            return $result;
        }
        return false;
    }



    

}
?>