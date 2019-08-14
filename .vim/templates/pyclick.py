import click

@click.command()
@click.option('--foo', default=1, help="Lorem ipsum dolor sit amet")
def main(count, name):
    """ A program to put the lime in the coconut """
    raise NotImplementedError

if __name__ == '__main__':
    main()
