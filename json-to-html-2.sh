#!/bin/bash

# Define the JSON file and the output HTML file
JSON_FILE="data.json"
OUTPUT_HTML="output.html"

# Start the HTML structure
echo '<!DOCTYPE html>' > "$OUTPUT_HTML"
echo '<html lang="en">' >> "$OUTPUT_HTML"
echo '<head>' >> "$OUTPUT_HTML"
echo '    <meta charset="UTF-8">' >> "$OUTPUT_HTML"
echo '    <meta name="viewport" content="width=device-width, initial-scale=1.0">' >> "$OUTPUT_HTML"
echo '    <title>JSON Data Table</title>' >> "$OUTPUT_HTML"
echo '    <style>' >> "$OUTPUT_HTML"
echo '        body { font-family: Arial, sans-serif; }' >> "$OUTPUT_HTML"
echo '        table { width: 100%; border-collapse: collapse; }' >> "$OUTPUT_HTML"
echo '        th, td { padding: 8px 12px; border: 1px solid #ccc; text-align: left; }' >> "$OUTPUT_HTML"
echo '        th { background-color: #f4f4f4; }' >> "$OUTPUT_HTML"
echo '        .highlight { background-color: #dff0d8; }' >> "$OUTPUT_HTML" # Green highlight for active status
echo '    </style>' >> "$OUTPUT_HTML"
echo '</head>' >> "$OUTPUT_HTML"
echo '<body>' >> "$OUTPUT_HTML"
echo '    <h2>JSON Data Table</h2>' >> "$OUTPUT_HTML"
echo '    <table>' >> "$OUTPUT_HTML"
echo '        <tr>' >> "$OUTPUT_HTML"
echo '            <th>Name</th>' >> "$OUTPUT_HTML"
echo '            <th>Email</th>' >> "$OUTPUT_HTML"
echo '            <th>Phone</th>' >> "$OUTPUT_HTML"
echo '            <th>Website</th>' >> "$OUTPUT_HTML"
echo '            <th>Status</th>' >> "$OUTPUT_HTML"
echo '        </tr>' >> "$OUTPUT_HTML"

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
    echo "        <tr class=\"$row_class\">" >> "$OUTPUT_HTML"
    echo "            <td>$name</td>" >> "$OUTPUT_HTML"
    echo "            <td><a href=\"mailto:$email\">$email</a></td>" >> "$OUTPUT_HTML"
    echo "            <td>$phone</td>" >> "$OUTPUT_HTML"
    echo "            <td><a href=\"$website\" target=\"_blank\">$website</a></td>" >> "$OUTPUT_HTML"
    echo "            <td>$status</td>" >> "$OUTPUT_HTML"
    echo "        </tr>" >> "$OUTPUT_HTML"
done

# Close HTML tags
echo '    </table>' >> "$OUTPUT_HTML"
echo '</body>' >> "$OUTPUT_HTML"
echo '</html>' >> "$OUTPUT_HTML"

echo "HTML file generated: $OUTPUT_HTML"
