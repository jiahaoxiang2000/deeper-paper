#!/usr/bin/env python3

import os
import csv
from bs4 import BeautifulSoup
import pandas as pd
import re

# Define the path to the HTML file
HTML_FILE = '../temp/bestpapers.html'
OUTPUT_CSV = '../data/awards.csv'  # Updated path to match Makefile

def extract_award_info():
    # Read the HTML file
    with open(HTML_FILE, 'r', encoding='utf-8') as file:
        html_content = file.read()

    # Parse the HTML content
    soup = BeautifulSoup(html_content, 'lxml')

    # Find all award entries (rows)
    award_rows = soup.find_all('div', class_='row py-2 border-top')

    awards_data = []

    for row in award_rows:
        # Skip empty rows
        if not row.text.strip():
            continue

        # Extract columns
        columns = row.find_all('div', class_=re.compile('col-'))
        if len(columns) < 3:
            continue

        # Extract award date, publication date, and title container
        award_date = columns[0].text.strip()
        pub_date = columns[1].text.strip()
        title_container = columns[2]

        # Extract title
        title_element = title_container.find('span', class_='pub-title')
        title = title_element.text.strip() if title_element else ""

        # Extract award
        award_element = title_container.find('div', class_='award')
        award = award_element.text.strip() if award_element else ""
        # Clean up award text (remove '★' and extra spaces)
        award = re.sub(r'★\s*', '', award).strip()

        # Extract authors
        authors_element = title_container.find('div', class_='authors')
        authors = ""
        if authors_element:
            author_spans = authors_element.find_all('span', class_='author')
            authors = ", ".join([author.text.strip() for author in author_spans])

        # Extract abstract
        abstract_element = title_container.find('div', class_='abstract')
        abstract = abstract_element.text.strip() if abstract_element else ""

        # Add to data list
        awards_data.append({
            "award_date": award_date,
            "publish_date": pub_date,
            "title": title,
            "award": award,
            "authors": authors,
            "abstract": abstract
        })

    return awards_data

def save_to_csv(data):
    # Convert to DataFrame
    df = pd.DataFrame(data)

    # Save to CSV
    df.to_csv(OUTPUT_CSV, index=False, quoting=csv.QUOTE_ALL)
    print(f"Data saved to {OUTPUT_CSV}")

def main():
    print("Extracting award information from HTML...")
    awards_data = extract_award_info()
    print(f"Found {len(awards_data)} award entries")
    
    save_to_csv(awards_data)
    print("Done!")

if __name__ == "__main__":
    main()