<?php
include 'dbconnect.php'; // Include the database connection file

header('Content-Type: application/json'); // Set the content type of the response

$sql = "SELECT * FROM Records WHERE is_deleted = 0"; // SQL query to fetch records
$result = $conn->query($sql);

$records = [];

if ($result->num_rows > 0) {
    // Output data of each row
    while($row = $result->fetch_assoc()) {
        $records[] = $row; // Add each row to the records array
    }
    echo json_encode($records); // Encode the records array as JSON and output it
} else {
    echo json_encode([]); // Return an empty array if no records found
}

$conn->close(); // Close the database connection
?>
