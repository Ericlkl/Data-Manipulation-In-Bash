"""
Convert delimiter separated files to SQLite3 databases

Harry Scells
March 2017
"""
import argparse
import csv
import io
import sqlite3
import sys


def read_csv(input_file: io.IOBase, delim=',', quote='"') -> list:
    """
    Take a delimiter separated file and return a list of tuples representing the rows.
    :param input_file: File to read
    :param delim: Delimiter of the file
    :param quote:
    :return:
    """
    csv_reader = csv.reader(input_file, delimiter=delim, quotechar=quote)
    csv_rows = []
    for row in csv_reader:
        current_row = []
        for r in [str(x) for x in row]:
            if r.isdigit():
                current_row.append(int(r))
            elif r.replace('.', '', 1).isdigit():
                current_row.append(float(r))
            else:
                current_row.append(r)
        csv_rows.append(current_row)
    return csv_rows


if __name__ == '__main__':
    argparser = argparse.ArgumentParser(description=
                                        'Convert delimiter-separated files to SQLite3')

    argparser.add_argument('-d', '--delimiter', help='Delimiter used for separating columns',
                           default=',', required=False, type=str)
    argparser.add_argument('-q', '--quote', help='Quote delimiter used for escaping columns',
                           default='"')
    argparser.add_argument('--table-name', help='Name for the SQLite3 table', required=False,
                           default='ex', type=str)
    argparser.add_argument('--contains-headers', help='Does this file have headers?',
                           default=True, type=bool)
    argparser.add_argument('--input', help='Input delimiter-separated file', default=sys.stdin,
                           required=False, type=argparse.FileType('r'))
    argparser.add_argument('--output', help='Output filename for SQLite3 file', required=True,
                           type=str)

    args = argparser.parse_args()

    # open a connection to db
    conn = sqlite3.connect(args.output)

    # get the rows from the csv file
    rows = read_csv(args.input, args.delimiter, args.quote)

    # process header info
    headers = []
    if args.contains_headers:
        # when we have headers, use them, and skip a row
        headers = ','.join(rows[0])
        rows = rows[1:]
    else:
        # otherwise just use numbers
        headers = ','.join([str(x) for x in range(len(rows[0]))])

    # create the table
    conn.execute('CREATE TABLE {} ({})'.format(args.table_name, headers))

    # create the parameter substitutions
    params = ','.join(['?' for x in rows[0]])

    # now finally insert the data!
    conn.executemany('INSERT INTO {} VALUES ({})'.format(args.table_name, params), rows)

    conn.commit()
    conn.close()
