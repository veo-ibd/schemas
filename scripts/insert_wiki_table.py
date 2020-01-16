#!/usr/bin/env python3

"""
Program: insert_wiki_table.py

Purpose: Read in a csv file, use it to insert a table into a markdown string,,
         and then use the markdown string to create a Synapse wiki page.

         The markdown file is expected to contain the string
         "INSERT_CSV_FILE_HERE" at the location where the table is supposed to
         be inserted.

Input parameters: Synapse ID of the csv file
                  Synapse ID of the markdown file
                  Synapse ID of the wiki page

Outputs: Synapse wiki page

Execution: insert_wiki_table.py <csv file Synapse ID>
                                <markdown file Synapse ID>
                                <wiki page Synapse ID>

"""

import argparse
import csv
import synapseclient
from synapseclient import Wiki

def main():

    parser = argparse.ArgumentParser()
    parser.add_argument("csv_syn_id", type=str,
                        help="Synapse ID of the csv file")
    parser.add_argument("md_syn_id", type=str,
                        help="Synapse ID of the markdown file")
    parser.add_argument("wiki_syn_id", type=str,
                        help="Synapse ID of the wiki page")

    args = parser.parse_args()

    syn = synapseclient.Synapse()
    syn.login(silent=True)

    INSERTION_STRING = "INSERT_CSV_FILE_HERE"

    # Read the csv file into a string with vertical bar separators.
    table_string = "" 
    csv_entity = syn.get(args.csv_syn_id)

    with open(csv_entity.path, "r") as csv_file:
        csv_contents = csv.reader(csv_file)
        for row in csv_contents:
            table_string += "|".join(row) + "\n"

    # Read the markdown file and insert the table in the appropriate location.
    md_entity = syn.get(args.md_syn_id)
    with open(md_entity.path, "r") as md_file:
        new_markdown = md_file.read().replace(INSERTION_STRING, table_string)

    # Write out the wiki page.
    wiki_entity = syn.get(args.wiki_syn_id)
    wiki = Wiki(owner=wiki_entity, markdown=new_markdown)

    wiki_out = syn.store(wiki)


if __name__ == "__main__":
    main()
