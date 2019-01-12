import click
import lxml.etree as ET


@click.command()
@click.option('--xml', type=click.File(), help="XML file to transform")
@click.option('--xsl', type=click.File(), help="XSL file that defines the transformation")
@click.option('--out', type=str, help="Destination path and filename")
def main(**options):
    dom = ET.parse(options['xml'])
    xslt = ET.parse(options['xsl'])
    transform = ET.XSLT(xslt)
    newdom = transform(dom)

    with open(options['out'], 'wb') as handle:
        handle.write(ET.tostring(newdom, pretty_print=True))


if __name__ == '__main__':
    main()
