<?php
header("content-type:application/json");
header("Access-Control-Allow-Origin: *");

$conn = mysqli_connect("localhost","root","","todolist");

$result = mysqli_query($conn,"SELECT * FROM tasks");

$tasks = [];

while($row = mysqli_fetch_assoc($result)){
    $tasks[] = $row;
}

echo json_encode($tasks);
?>