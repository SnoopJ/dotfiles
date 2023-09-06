import click


@click.command(context_settings={"show_default": True})
@click.option('--foo', default=1, help="Information about the foo parameter")
@click.argument('bar', nargs=-1)
def cli(foo, bar):
    """Information about this program"""
    print(f"{foo = }")
    print(f"{bar = }")


if __name__ == '__main__':
    cli()
