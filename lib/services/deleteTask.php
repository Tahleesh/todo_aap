<?php
header("Access-Control-Allow-Origin: *");

$conn = mysqli_connect("localhost","root","","todolist");

$id = $_POST['id'];

mysqli_query($conn,"DELETE FROM tasks WHERE id='$id'");


?>