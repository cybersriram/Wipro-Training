<?php
$date=date_create($_POST["date"]);
$date2 = date_create(date("m/d/Y"));
$interval = date_diff($date,$date2);
$conn = mysqli_connect(
    "localhost", 
    "root", 
    '',
    'ip4');
if(!$conn){
    echo 'Connection error: ' . mysqli_connect_error();
}
$conn-> autocommit(TRUE);
$res = $interval->format('%y').' years'.$interval->format('%m').' months';
$sql = "insert into details values('".$_POST['name']."','".$res."')";
if ($conn->query($sql) === TRUE){
    print "rec addded";
}
?>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Result</title>
</head>
<body>
    <div style="text-align:center;margin-top:140px">
    <h1> Hello <?php $_POST['name']?></h1>
    <h1> Your  age is <?php echo $interval->format('%y');?> years and <?php echo $interval->format('%m');?> months </h1>
    </div>
</body>
</html>