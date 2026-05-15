<?php
header("content-type:application/json");
header("Access-Control-Allow-Origin: *");

$conn = mysqli_connect("localhost","root","","todo_app");

$user_id = $_GET['user_id'];

$result = mysqli_query(
$conn,
"SELECT * FROM tasks WHERE user_id='$user_id'"
);

$data = [];

while($row = mysqli_fetch_assoc($result)){
    $data[] = $row;
}

echo json_encode($data);

?>