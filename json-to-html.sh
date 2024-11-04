#!/bin/bash

# Sample JSON input
json='{
  "people": [
    {
      "name": "Alice",
      "DOB": "1990-01-01",
      "color": ["Blue"],
      "texture": "Smooth"
    },
    {
      "name": "Bob",
      "DOB": "1985-05-12",
      "color": ["Red", "Green"],
      "texture": "Rough"
    },
    {
      "name": "Charlie",
      "DOB": "1979-10-23",
      "color": ["Yellow", "Orange"],
      "texture": "Smooth"
    },
    {
      "name": "Daisy",
      "DOB": "1982-03-14",
      "color": ["Pink"],
      "texture": "Grainy"
    }
  ]
}'

# Start the HTML structure
echo "<html>"
echo "<head><title>People Data by Texture</title></head>"
echo "<body>"
echo "<h1>People Data Grouped by Texture</h1>"

# Get unique texture values and iterate over them
textures=$(echo "$json" | jq -r '.people | map(.texture) | unique | .[]')

# Loop through each texture and create a table for each
for texture in $textures; do
  echo "<h2>Texture: $texture</h2>"
  echo "<table border='1'>"
  echo "<tr><th>Name</th><th>DOB</th><th>Color</th></tr>"

  # Filter JSON by current texture and output table rows
  echo "$json" | jq -r --arg texture "$texture" '
    .people | 
    map(select(.texture == $texture))[] | 
    "<tr><td>" + .name + "</td><td>" + .DOB + "</td><td>" + (.color | join(", ")) + "</td></tr>"
  '

  echo "</table>"
done

# End the HTML structure
echo "</body>"
echo "</html>"
