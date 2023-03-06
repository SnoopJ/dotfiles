import argparse


parser = argparse.ArgumentParser(
    description="A useful description of this script", formatter_class=argparse.ArgumentDefaultsHelpFormatter
)
parser.add_argument("strarg", type=str, help="A string argument")
parser.add_argument("numarg", type=float, help="A numerical argument")
parser.add_argument("reqarg", type=float, help="A required argument", required=True)
parser.add_argument(
    "-x",
    metavar="nameofx",
    nargs="+",
    type=float,
    default=32 * 32 * 32,
    help="Helpful message about this argument",
)


def main():
    args = parser.parse_args()


if __name__ == "__main__":
    main()
