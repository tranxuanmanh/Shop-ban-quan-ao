<?php
include '../classes/statistical.php';
$start = $_POST['start'];
$end = $_POST['end'];

$statistical = new statistical();
$response = $statistical->filterByDate($start, $end);
if($response){
    echo json_encode($response);
}
else{
    echo "null";
}

?>
