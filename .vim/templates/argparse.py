import argparse

parser = argparse.ArgumentParser(description='A useful description of this script (might want to set this to __doc__)', formatter_class=argparse.ArgumentDefaultsHelpFormatter)
parser.add_argument('strarg', type=str, help='A string argument')
parser.add_argument('numarg', type=float, help='A numerical argument')
parser.add_argument('numarg', type=float, help='A required argument', required=True)
parser.add_argument('-x', metavar='nameofx', nargs='+', type=float, default=32*32*32, help='Helpful message about this argument')

args = parser.parse_args()
