<?php
header("Access-Control-Allow-Origin: *");

$conn = mysqli_connect("localhost","root","","todo_app");

$id = $_POST['id'];

mysqli_query(
$conn,
"DELETE FROM tasks WHERE id='$id'"
);

?>