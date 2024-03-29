    // Add a click event listener to the button
    document.getElementById('checkout').addEventListener('click', function() {
        // Display the popup
        alert('Checkout Popup');
    });
    
    document.getElementById('login').addEventListener('click', function() {
        // Display the popup
        alert('Login Popup');
    });
    
    document.getElementById('sign-up').addEventListener('click', function() {
        // Display the popup
        alert('Sign up Popup');
    });
    
const mysql = require('mysql');

// Create a connection
const connection = mysql.createConnection({
    host: 'localhost',
    user: 'your_username',
    password: 'your_password',
    database: 'your_database'
});

// Connect to the database
connection.connect((err) => {
    if (err) {
        console.error('Error connecting to the database:', err);
        return;
    }
    console.log('Connected to the database');
});

// Perform database operations
// ...

// Close the connection
connection.end((err) => {
    if (err) {
        console.error('Error closing the database connection:', err);
        return;
    }
    console.log('Connection closed');
});

    // Search for records
    document.getElementById('search').addEventListener('click', function() {
        // Get the search query from the input field
        const searchQuery = document.getElementById('search-input').value;

        // Perform the database query
        connection.query('SELECT * FROM Records WHERE name LIKE ?', '%' + searchQuery + '%', (err, rows) => {
            if (err) {
                console.error('Error executing the query:', err);
                return;
            }
            console.log('Search results:', rows);
            // Display the search results on the page
            // ...
    // Fetch records from the database
    connection.query('SELECT * FROM Records', (err, rows) => {
        if (err) {
            console.error('Error fetching records:', err);
            return;
        }
        
        // Get the table body element
        const tableBody = document.getElementById('records-table-body');
        
        // Clear existing table rows
        tableBody.innerHTML = '';
        
        // Generate HTML markup for each record
        rows.forEach((record) => {
            const row = document.createElement('tr');
            
            const recordTile = document.createElement('td');
            const recordTitle = document.createElement('h2');
            const recordArtist = document.createElement('p');
            const recordAlbum = document.createElement('p');
            const recordGenre = document.createElement('p');
            const recordPrice = document.createElement('p');
            const addBtn = document.createElement('button');
            
            recordTitle.textContent = 'Record Title';
            recordArtist.textContent = 'Record Artist';
            recordAlbum.textContent = 'Record Album';
            recordGenre.textContent = 'Record Genre';
            recordPrice.textContent = 'Record Price';

            addBtn.textContent = 'Add to Cart'; // Add a click event listener to the button
            addBtn.addEventListener('click', function() {
                // Add the record to the cart
                alert('Record added to cart');
            });

            recordTile.appendChild(recordTitle);
            recordTile.appendChild(recordArtist);
            recordTile.appendChild(recordAlbum);
            recordTile.appendChild(recordGenre);
            recordTile.appendChild(recordPrice);
            recordTile.appendChild(addBtn);
            row.appendChild(recordTile);          
            tableBody.appendChild(row);
            
        });
    });
        });
    });

    // Insert a new record
    const newRecord = { name: 'John Doe', age: 25, email: 'johndoe@example.com' };
    connection.query('INSERT INTO Records SET ?', newRecord, (err, result) => {
        if (err) {
            console.error('Error inserting a new record:', err);
            return;
        }
        console.log('New record inserted:', result);
    });

    // Delete a record
    connection.query('DELETE FROM Records WHERE id = ?', [1], (err, result) => {
        if (err) {
            console.error('Error deleting a record:', err);
            return;
        }
        console.log('Record deleted:', result);
    });

    // Update an existing record
    const updatedRecord = { name: 'Jane Doe', age: 30, email: 'janedoe@example.com' };
    const recordId = 1; // Assuming you want to update the record with id 1
    connection.query('UPDATE Records SET ? WHERE id = ?', [updatedRecord, recordId], (err, result) => {
        if (err) {
            console.error('Error updating the record:', err);
            return;
        }
        console.log('Record updated:', result);
    });