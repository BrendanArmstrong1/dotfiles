import argparse
import os
import pytesseract

parser = argparse.ArgumentParser()
parser.add_argument("--temp_file")
args = parser.parse_args()

if os.path.isfile(args.temp_file):
    text = pytesseract.image_to_string(args.temp_file)
    print(text)



