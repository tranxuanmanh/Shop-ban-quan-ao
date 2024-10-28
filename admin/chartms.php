<?php
    include '../classes/statistical.php';
    include_once '../lib/session.php';
    Session::checkSession('admin');
    $role_id = Session::get('role_id');
    if ($role_id == 1){
        # code...
    } else {
        header("Location:../index.php");
    }

    $currentDate = date('Y-m-d');
    $previousMonthDate = date('Y-m-d', strtotime('-1 month'));
    $oneWeekAgo = date('Y-m-d', strtotime("-1 week"));
    $oneYearAgo = date('Y-m-d', strtotime("-1 year"));

    $statistical = new statistical();
    $resurt_1m = $statistical->getSumTotalOrder($previousMonthDate, $currentDate);
?>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="./css/style.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
    <script src="https://use.fontawesome.com/2145adbb48.js"></script>
    <script src="https://kit.fontawesome.com/a42aeb5b72.js" crossorigin="anonymous"></script>
    <link rel="stylesheet" href="//cdnjs.cloudflare.com/ajax/libs/morris.js/0.5.1/morris.css">
    <script src="//ajax.googleapis.com/ajax/libs/jquery/1.9.0/jquery.min.js"></script>
    <script src="//cdnjs.cloudflare.com/ajax/libs/raphael/2.1.0/raphael-min.js"></script>
    <script src="//cdnjs.cloudflare.com/ajax/libs/morris.js/0.5.1/morris.min.js"></script>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <title>Thống kê chi tiết</title>

</head>
<body>
    <nav>
        <input type="checkbox" id="check">
        <label for="check" class="checkbtn">
            <i class="fas fa-bars"></i>
        </label>
        <label class="logo"><a href="index.php">ADMIN</a></label>
        <ul>
            <li><a href="productlist.php">Quản lý Sản phẩm</a></li>
            <li><a href="categoriesList.php">Quản lý Danh mục</a></li>
            <li><a href="orderlist.php">Quản lý Đơn hàng</a></li>
            <li><a href="userlist.php">Quản lý Người dùng</a></li>
            <li><a href="orderlist.php" class="active">Thống kê</a></li>
            <li><a href="transfer.php">Chuyển về trang chủ</a></li>
        </ul>
    </nav>
    <div class="title">
        <h1>Thống kê số liệu</h1>
    </div>

    <div class="container1">
        <div class="box1">
            <form id="dateForm">
                <div class="form-group">
                    <label for="startDate">Ngày bắt đầu:</label>
                    <input type="date" id="startDate" name="startDate">
                </div>
                <div class="form-group">
                    <label for="endDate">Ngày kết thúc:</label>
                    <input type="date" id="endDate" name="endDate">         
                </div>
                <select class="select-filter">
                    <option value="1">Tháng này</option>
                    <option value="2">Tuần này</option>
                    <option value="3">365 ngày qua</option>
                </select>
                <button id="btn-filter">Lọc dữ liệu</button>
                <!-- <button id="toggleButton">Chế độ 1</button> -->
            </form>

            <div class="box">
                <div class="part" id="qty">
                    <span>Số đơn hàng tháng gần đây</span>
                    <span><?=$resurt_1m['sum_order']?></span>
                </div>
                <div class="part" id="revenue">
                    <span>Tổng doanh thu tháng gần đây</span>
                    <span><?=number_format($resurt_1m['sum_sale'])?> VND</span>
                </div>
                <div class="part" id="profit">
                    <span>Tổng lợi nhuận tháng gần đây</span>
                    <span><?=number_format($resurt_1m['sum_profit'])?> VND</span>
                </div>
            </div>
        </div>

        <div id="myfirstchart" style="height: 250px;"></div>
    </div>

    <footer>
        <p class="copyright">copy by IVYmoda.com 2024</p>
    </footer>
</body>


<script>
    filter30Day();
    function filter30Day(){
        
        var startDate = "<?php echo $previousMonthDate; ?>";
        var endDate = "<?php echo $currentDate; ?>";
        $.ajax({
            url: "ajax_chart.php", 
            type: "POST",   
            data: { start: startDate, end: endDate },
            success: function(response) {
                if(response){
                    var data = JSON.parse(response);
                    chart.setData(data);
                }
                else{
                    alert("Không có đơn hàng trong thời gian này!");
                }
            }
        });
    }

    $(".select-filter").change(function(e) {
        e.preventDefault();
        $value = $(this).val();
        var startDate;
        var endDate;
        if($value == "1"){
            startDate = "<?php echo $previousMonthDate; ?>";
            endDate = "<?php echo $currentDate; ?>";
        }
        else if($value == "2"){
            startDate = "<?php echo $oneWeekAgo; ?>";
            endDate = "<?php echo $currentDate; ?>";
        }
        else if($value == "3"){
            startDate = "<?php echo $oneYearAgo; ?>";
            endDate = "<?php echo $currentDate; ?>";
        }
        
        $.ajax({
            url: "ajax_chart.php", 
            type: "POST",
            data: { start: startDate, end: endDate },
            success: function(response) {
                var data = JSON.parse(response);
                if(data != null){
                    chart.setData(data);
                }
                else{
                    alert("Không có đơn hàng trong thời gian này!");
                }
            }
        });
    });

    $("#btn-filter").click(function(e) {
        e.preventDefault();
        var startDate = $("#startDate").val();
        var endDate = $("#endDate").val();
        $.ajax({
            url: "ajax_chart.php", 
            type: "POST",
            data: { start: startDate, end: endDate },
            success: function(response) {
                var data = JSON.parse(response);
                if(data != null){
                    chart.setData(data);
                }
                else{
                    alert("Không có đơn hàng trong thời gian này!");
                }
            }
        });
    });



    var chart =  new Morris.Bar({
    element: 'myfirstchart',
    hideHover: 'auto',
    parseTime: false,
    lineColors: ['#819C79', '#fc8710', '#FF6541', '#A4ADD3', '#76656'],
    xkey: 'order_date',
    ykeys: ['total_order', 'sales', 'profit', 'quantity'],
    labels: ['Đơn hàng', 'Doanh số', 'Lợi nhuận', 'Số lượng']
    });
    

    // $("#toggleButton").click(function(e) {
        
    //         e.preventDefault();
    //         var button = $(this);
        
    //         if (button.text() === "Chế độ 1") {
    //             button.text("Chế độ 2");
    //             alert(chart.data);
    //             // Thực hiện các hành động cho chế độ 1
    //             var chart =  new Morris.Line({
    //             element: 'myfirstchart',
    //             hideHover: 'auto',
    //             parseTime: false,
    //             lineColors: ['#819C79', '#fc8710', '#FF6541', '#A4ADD3', '#76656'],
    //             xkey: 'order_date',
    //             ykeys: ['total_order', 'sales', 'profit', 'quantity'],
    //             labels: ['Đơn hàng', 'Doanh số', 'Lợi nhuận', 'Số lượng']
    //             });
    //         } else {
                
    //             button.text("Chế độ 1");
    //             alert(chart.data);
    //             // Thực hiện các hành động cho chế độ 2
    //             var chart =  new Morris.Bar({
    //             element: 'myfirstchart',
    //             hideHover: 'auto',
    //             parseTime: false,
    //             lineColors: ['#819C79', '#fc8710', '#FF6541', '#A4ADD3', '#76656'],
    //             xkey: 'order_date',
    //             ykeys: ['total_order', 'sales', 'profit', 'quantity'],
    //             labels: ['Đơn hàng', 'Doanh số', 'Lợi nhuận', 'Số lượng']
    //             });
    //         }
            
    // });
</script>
</html>




