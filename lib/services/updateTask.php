<?php
header("Access-Control-Allow-Origin: *");

$conn = mysqli_connect("localhost","root","","todo_app");

$id = $_POST['id'];
$title = $_POST['title'];

mysqli_query(
$conn,
"UPDATE tasks SET title='$title'
WHERE id='$id'"
);

?>