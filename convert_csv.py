import csv
from io import StringIO
from datetime import datetime

# Get input data
input_data = _input.all()
output_items = []

for item in input_data:
    # Access the data key
    csv_string = item["json"]["data"]
    
    # Parse CSV
    csv_reader = csv.DictReader(StringIO(csv_string))
    parsed_data = list(csv_reader)
    
    for row in parsed_data:

        row["load_date"] = datetime.today().strftime("%Y-%m-%d %H:%M:%S")
        row["source_file_name"] = 'ads_spend.csv'
      
        try:
            row["spend"] = float(row["spend"])
            row["clicks"] = int(row["clicks"])
            row["impressions"] = int(row["impressions"])
            row["conversions"] = int(row["conversions"])
        except (ValueError, KeyError):
            pass
        
        output_item = {
            "json": row
        }
        output_items.append(output_item)

return output_items