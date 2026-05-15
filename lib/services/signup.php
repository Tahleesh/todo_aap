<?php

header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Headers: *");

$conn = mysqli_connect("localhost","root","","todo_app");

$username = $_POST['username'];
$password = $_POST['password'];

$sql = "INSERT INTO users(username,password)
VALUES('$username','$password')";

mysqli_query($conn,$sql);

echo json_encode([
    "status" => "success"
]);

?>