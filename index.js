async function fetchAndDisplayTable() {
    try {
        // Fetch the HTML page
        const response = await fetch('https://example.com/page-with-table.html'); // Replace with the actual URL of the page with the table
        const text = await response.text();

        // Parse the fetched HTML
        const parser = new DOMParser();
        const doc = parser.parseFromString(text, 'text/html');

        // Extract the table element
        const table = doc.querySelector('table');
        if (table) {
            // Insert the table into the page
            document.getElementById('table-container').innerHTML = table.outerHTML;
        } else {
            document.getElementById('table-container').innerHTML = 'No table found in the provided HTML.';
        }
    } catch (error) {
        console.error('Error fetching or displaying the table:', error);
        document.getElementById('table-container').innerHTML = 'Failed to fetch the table.';
    }
}
