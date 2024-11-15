#!/bin/bash
echo "Enter File Name: "
read input_file
report_file="report.txt"
> "$report_file"
month_pattern='(January|February|March|April|May|June|July|August|September|October|November|December|Jan|Feb|Mar|Apr|May|Jun|Jul|Aug|Sep|Oct|Nov|Dec)'
date_patterns=(
#dd/mm/yyyy OR mm/dd/yyyy
'\b[0-9]{1,2}/[0-9]{1,2}/[0-9]{4}\b'
#dd-mm-yyyy OR mm-dd/yyyy
'\b[0-9]{1,2}-[0-9]{1,2}-[0-9]{4}\b'
#date month year
"\b(The |the )?[0-9]{1,2}([a-z]{2})?( of)?( $month_pattern)(,)? ?([0-9]{4})?(of \'[0-9]{2})?\b"
#month date year
"\b(The |the )?$month_pattern [0-9]{1,2}([a-z]{2})?(,)? ?([0-9]{4})?(of \'[0-9]{2})?\b"
#yyyy/mm/dd OR yyyy/dd/mm
'\b[0-9]{4}/[0-9]{1,2}/[0-9]{1,2}\b'
#yyyy-mm-dd OR yyyy-dd-mm
'\b[0-9]{4}-[0-9]{1,2}-[0-9]{1,2}\b'
)
total=0
for pattern in "${date_patterns[@]}"; do
	grep -oE "$pattern" "$input_file" >> "$report_file"
done

total=$(wc -l < "$report_file")

echo "Extracted Dates"
cat "$report_file"
echo "Total number of dates extracted: $total"

echo "Total number of dates extracted: $total" >> "$report_file"


