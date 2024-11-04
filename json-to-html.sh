#!/bin/bash

# Sample JSON input (modify this as needed)
json='{
  "teams": [
    {
      "name": "Team A",
      "members": 5,
      "address": [
        "123 Main St",
        "Apt 4B",
        "12345"
      ],
      "skills": ["Leadership", "Strategy", "Communication"]
    },
    {
      "name": "Team B",
      "members": 10,
      "address": [
        "456 Elm St",
        "Suite 1",
        "67890"
      ],
      "skills": ["Development", "Design", "Testing"]
    }
  ]
}'

# Start the HTML structure
echo "<html>"
echo "<head><title>JSON Data</title></head>"
echo "<body>"
echo "<h1>Teams Data</h1>"
echo "<table border='1'>"
echo "<tr><th>Name</th><th>Members</th><th>Address</th><th>Skills</th></tr>"

# Parse JSON and add rows to the HTML table
echo "$json" | jq -r '
  .teams[] | 
  "<tr><td>" + 
  .name + "</td><td>" + 
  (.members | tostring) + "</td><td>" + 
  (.address | join(", ")) + "</td><td>" + 
  (.skills | join(", ")) + 
  "</td></tr>"
'

# End the HTML structure
echo "</table>"
echo "</body>"
echo "</html>"
