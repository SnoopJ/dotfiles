"""
  Template for a file meant to be run from the commandline with args
"""
import argparse

parser = argparse.ArgumentParser(description='A useful description of this script (might want to set this to __doc__)', formatter_class=argparse.ArgumentDefaultsHelpFormatter)
parser.add_argument('-x', metavar='nameofx', nargs='+', type=float, default=32*32*32, help='Helpful message about this argument')

grp = parser.add_mutually_exclusive_group()
grp.add_argument('--option1', dest='destination', action='store_const', const='option1_const')
grp.add_argument('--option2', dest='destination', action='store_const', const='option2_const')

def main(args):
    pass

if __name__ == "__main__":
    args = parser.parse_args()
    main(args)
