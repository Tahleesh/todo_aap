<?php
header("Access-Control-Allow-Origin: *");

$conn = mysqli_connect("localhost","root","","todolist");

$title = $_POST['title'];

mysqli_query($conn,"INSERT INTO tasks (title, isDone) VALUES ('$title',0)");


?>