"""
This file is a truncation of the numpy docstring standard (https://numpydoc.readthedocs.io/en/latest/format.html#docstring-standard)
with examples that can be quickly yanked into another file.
"""

def somefunc(foo, bar, baz=None, order, x, y):
    """
    A one-line summary that does not use variable names or the function name

    A few sentences giving an extended description. This section should be used
    to clarify functionality, not to discuss implementation detail or
    background theory, which should rather be explored in the Notes section
    below. You may refer to the parameters and the function name, but parameter
    descriptions still belong in the Parameters section.

    Parameters
    ----------
    foo : int
        Description of parameter `foo`.
    bar 
        Description of parameter `bar` (with type not specified)
    baz : str, optional
        Description of optional parameter `baz`
    order : {'C', 'F', 'A'}
        When a parameter can only assume one of a fixed set of values, those
        values can be listed in braces, with the default appearing first.
    x, y: array_like
        When two or more input parameters have exactly the same type, shape and
        description, they can be combined.

    Returns
    -------
    int
       Description of anonymous integer return value. If both the name and type
       are specified, the Returns section takes the same form as the Parameters
       section.

    Notes
    -----
    An optional section that provides additional information about the code,
    possibly including a discussion of the algorithm. This section may include
    mathematical equations, written in LaTeX format:
        The FFT is a fast implementation of the discrete Fourier transform:

        .. math:: X(e^{j\omega } ) = x(n)e^{ - j\omega n}

    References
    ----------
    References cited in the notes section may be listed here, e.g. if you cited
    the article below using the text [1]_, include it as in the list as
    follows:

    .. [1] O. McNoleg, "The integration of GIS, remote sensing,
       expert systems and adaptive co-kriging for environmental habitat
       modelling of the Highland Haggis using object-oriented, fuzzy-logic
       and neural-network techniques," Computers & Geosciences, vol. 22,
       pp. 585-588, 1996.

    Examples
    --------
    An optional section for examples, using the doctest format.

    >>> somefunc(1, None, 
    ...          baz='taco')
    Some kind of function output!
    """
    pass

class SomeClass:
    """
    A one-line summary that does not use variable/function/class names.

    Use the same sections as outlined above (all except Returns are
    applicable). The constructor (__init__) should also be documented here, the
    Parameters section of the docstring details the constructors parameters.

    An Attributes section, located below the Parameters section, may be used to
    describe non-method attributes of the class.

    Parameters
    ----------
    foo : int
        Description of parameter `foo`.
    bar 
        Description of parameter `bar` (with type not specified)
    baz : str, optional
        Description of optional parameter `baz`
    order : {'C', 'F', 'A'}
        When a parameter can only assume one of a fixed set of values, those
        values can be listed in braces, with the default appearing first.
    x, y: array_like
        When two or more input parameters have exactly the same type, shape and
        description, they can be combined.

    Attributes
    ----------
    x : float
        The X coordinate.
    y : float
        The Y coordinate.

    Notes
    -----
    An optional section that provides additional information about the code,
    possibly including a discussion of the algorithm. This section may include
    mathematical equations, written in LaTeX format:
        The FFT is a fast implementation of the discrete Fourier transform:

        .. math:: X(e^{j\omega } ) = x(n)e^{ - j\omega n}

    References
    ----------
    References cited in the notes section may be listed here, e.g. if you cited
    the article below using the text [1]_, include it as in the list as
    follows:

    .. [1] O. McNoleg, "The integration of GIS, remote sensing,
       expert systems and adaptive co-kriging for environmental habitat
       modelling of the Highland Haggis using object-oriented, fuzzy-logic
       and neural-network techniques," Computers & Geosciences, vol. 22,
       pp. 585-588, 1996.

    Examples
    --------
    An optional section for examples, using the doctest format.

    >>> somefunc(1, None, 
    ...          baz='taco')
    Some kind of function output!
    """

    def __init__(self, foo, bar, baz=None, order, x, y):
        pass
