<?php
header("Access-Control-Allow-Origin: *");

$conn = mysqli_connect("localhost","root","","todolist");

$id = $_POST['id'];
$title = $_POST['title'];

mysqli_query($conn,"UPDATE tasks SET title='$title' WHERE id='$id'");


?>