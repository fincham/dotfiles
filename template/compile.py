#!/usr/bin/python3

import argparse
import sys

import settings
import template.titen


def compile_template(input_filename):
    if input_filename == "-":
        template_string = sys.stdin.read()
    else:
        template_string = open(input_filename).read()

    template.titen._titen_globals["settings"] = settings
    return template.titen.titen(template_string)()


if __name__ == "__main__":
    parser = argparse.ArgumentParser()
    parser.add_argument(
        "template",
        nargs="?",
        default="-",
        help="filename of template to compile, reads from stdin if not specified",
    )
    args = parser.parse_args()

    sys.stdout.write(compile_template(args.template))
