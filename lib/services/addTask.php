<?php
header("Access-Control-Allow-Origin: *");

$conn = mysqli_connect("localhost", "root", "", "todo_app");

$title = $_POST['title'];
$user_id = $_POST['user_id'];

mysqli_query(
    $conn,
    "INSERT INTO tasks (title,isDone,user_id)
VALUES ('$title','0','$user_id')"
);
