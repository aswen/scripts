#!/usr/bin/python3

from html.parser import HTMLParser
import argparse, re, sys

parser = argparse.ArgumentParser();
parser.add_argument('-f', '--file', help="The file to proces", required=True)

args = parser.parse_args()

fileContents = open(args.file, "rt")

class MyHTMLParser(HTMLParser):
#  def handle_starttag(self, tag, attrs):
#    print("Encountered a start tag:", tag)
#
#  def handle_endtag(self, tag):
#    print("Encountered an end tag :", tag)
#
  def handle_data(self, data):
    print("Encountered some data  :", data)

demo = MyHTMLParser()

demo.feed(fileContents.read())
