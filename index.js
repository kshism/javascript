async function fetchAndDisplayContent() {
    try {
        const response = await fetch('https://example.com/page-with-content.html', {
            mode: 'no-cors' // Enable no-cors mode
        });

        // `no-cors` doesn't allow reading the response content directly
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
