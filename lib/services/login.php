<?php

header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Headers: *");

$conn = mysqli_connect("localhost","root","","todo_app");

$username = $_POST['username'];
$password = $_POST['password'];

$sql = "SELECT * FROM users
WHERE username='$username'
AND password='$password'";

$result = mysqli_query($conn,$sql);

$count = mysqli_num_rows($result);

if($count > 0){

    $row = mysqli_fetch_assoc($result);

    echo json_encode([
        "status" => "success",
        "user_id" => $row['id']
    ]);

}else{

    echo json_encode([
        "status" => "failed"
    ]);

}

?>