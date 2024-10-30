document.addEventListener("DOMContentLoaded", () => {
    async function fetchAndDisplayContent() {
        try {
            const response = await fetch('https://example.com/page-with-content.html', {
                mode: 'no-cors'
            });

            if (response.ok) {
                document.getElementById('content-container').innerHTML = 'Fetched successfully with no-cors, but content cannot be accessed due to restrictions.';
            } else {
                document.getElementById('content-container').innerHTML = 'Failed to fetch with no-cors.';
            }
        } catch (error) {
            console.error('Error fetching content:', error);
            document.getElementById('content-container').innerHTML = 'Failed to fetch the content.';
        }
    }

    // Add the fetchAndDisplayContent function to the button click
    document.querySelector('button').addEventListener('click', fetchAndDisplayContent);
});

async function fetchAndDisplayJSON() {
    try {
        // Replace with your actual JSON URL
        const response = await fetch('https://api.example.com/data');
        
        // Check if the response is OK
        if (!response.ok) {
            throw new Error('Network response was not ok');
        }

        const data = await response.json(); // Parse JSON

        // Generate HTML table from JSON data
        const table = document.createElement('table');
        const headerRow = document.createElement('tr');

        // Create table headers
        Object.keys(data[0]).forEach(key => {
            const th = document.createElement('th');
            th.textContent = key;
            headerRow.appendChild(th);
        });
        table.appendChild(headerRow);

        // Populate table with data
        data.forEach(item => {
            const row = document.createElement('tr');
            Object.values(item).forEach(value => {
                const td = document.createElement('td');
                td.textContent = value;
                row.appendChild(td);
            });
            table.appendChild(row);
        });

        // Clear previous table and append new table
        const tableContainer = document.getElementById('table-container');
        tableContainer.innerHTML = ''; // Clear previous content
        tableContainer.appendChild(table); // Append new table
    } catch (error) {
        console.error('Error fetching or displaying JSON data:', error);
        document.getElementById('table-container').innerHTML = 'Failed to fetch data.';
    }
}

