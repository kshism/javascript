#!/bin/bash

# Define the JSON file and the output HTML file
JSON_FILE="data.json"
OUTPUT_HTML="output.html"

# Begin the HTML structure
cat <<EOF > $OUTPUT_HTML
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>JSON Data Table</title>
    <style>
        body { font-family: Arial, sans-serif; }
        table { width: 100%; border-collapse: collapse; }
        th, td { padding: 8px 12px; border: 1px solid #ccc; text-align: left; }
        th { background-color: #f4f4f4; }
        .highlight { background-color: #dff0d8; } /* Green highlight for active status */
    </style>
</head>
<body>
    <h2>JSON Data Table</h2>
    <table>
        <tr>
            <th>Name</th>
            <th>Email</th>
            <th>Phone</th>
            <th>Website</th>
            <th>Status</th>
        </tr>
EOF

# Process each item in JSON array
jq -c '.[]' "$JSON_FILE" | while read -r item; do
    # Extract values using jq
    name=$(echo "$item" | jq -r '.name')
    email=$(echo "$item" | jq -r '.email')
    phone=$(echo "$item" | jq -r '.phone')
    website=$(echo "$item" | jq -r '.website')
    status=$(echo "$item" | jq -r '.status')

    # Apply conditional evaluation: Check if status is "active"
    if [ "$status" == "active" ]; then
        row_class="highlight"  # Apply the highlight class if active
    else
        row_class=""
    fi

    # Add each row to the HTML table
    cat <<EOF >> $OUTPUT_HTML
        <tr class="$row_class">
            <td>$name</td>
            <td><a href="mailto:$email">$email</a></td>
            <td>$phone</td>
            <td><a href="$website" target="_blank">$website</a></td>
            <td>$status</td>
        </tr>
EOF

done

# End the HTML structure
cat <<EOF >> $OUTPUT_HTML
    </table>
</body>
</html>
EOF

echo "HTML file generated: $OUTPUT_HTML"
