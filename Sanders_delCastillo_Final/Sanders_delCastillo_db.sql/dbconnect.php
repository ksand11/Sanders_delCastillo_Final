<?php
$servername = "your_host";
$username = "your_username";
$password = "your_password";
$database = "Sanders_delCastillo_db";

// Create connection
$conn = new mysqli($servername, $username, $password, $database);

// Check connection
if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
}
?>

