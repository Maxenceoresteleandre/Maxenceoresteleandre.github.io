// JavaScript to dynamically load the sidebar
fetch('sidenav.html') // Fetches the sidebar.html file
    .then(response => response.text()) // Converts the response to text
    .then(data => {
    document.getElementById('sidebar-container').innerHTML = data; // Injects the sidebar into the placeholder
    })
    .catch(error => console.error('Error loading the sidebar:', error)); // Logs any errors
