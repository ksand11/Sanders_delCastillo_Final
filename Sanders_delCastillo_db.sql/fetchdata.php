<?php
// Database configuration
$serverName = "yourservername"; // Update with your server name
$username = "yourusername"; // Update with your database username
$password = "yourpassword"; // Update with your database password
$database = "Sanders_delCastillo_db"; // Your database name

// Create connection
$conn = new mysqli($serverName, $username, $password, $database);

// Check connection
if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
}

// SQL to fetch records
$sql = "SELECT * FROM Records WHERE is_deleted = 0";
$result = $conn->query($sql);

if ($result->num_rows > 0) {
    // Output data of each row
    while($row = $result->fetch_assoc()) {
        echo "id: " . $row["record_id"]. " - Title: " . $row["title"]. " - Artist: " . $row["artist"]. " - Year: " . $row["year"]. " - Genre: " . $row["genre"]. " - Album: " . $row["album"]. " - Price: $" . $row["price"]. " - Stock: " . $row["stock"]. " - Sales Count: " . $row["sales_count"] . "<br>";
    }
} else {
    echo "0 results";
}
$conn->close();
?>
