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
