<?php
header("Access-Control-Allow-Origin: *");

$conn = mysqli_connect("localhost","root","","todolist");

$id = $_POST['id'];
$isDone = $_POST['isDone'];

mysqli_query($conn,"UPDATE tasks SET isDone='$isDone' WHERE id='$id'");


?>