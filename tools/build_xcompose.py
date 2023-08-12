"""
A program I wrote to rebuild my .XCompose when I accidentally deleted it
"""
from functools import lru_cache
import string
import sys
import unicodedata
from itertools import chain


@lru_cache(1)
def codepoint_names():
    result = {}
    for n in range(sys.maxunicode + 1):
        char = chr(n)
        try:
            name = unicodedata.name(char)
        except ValueError:
            continue
        key = (n, char)
        result[key] = name

    return result


def find_chars(*patterns):
    for ((n, char), name) in codepoint_names().items():
        for pattern in patterns:
            parts = pattern.split()
            if any(part.casefold() not in name.casefold() for part in parts):
                continue

            yield char


GREEK_LATIN_PAIRS = [
    *zip(
        "αβγδεζηικλμνοπρστυφχωΑΒΓΔΕΖΗΙΚΛΜΝΟΠΡΣΤΥΦΧΩ",
        "abgdezhiklmnoprstufxwABGDEZHIKLMNOPRSTUFXW",
    ),
    ("θ", "th"),
    ("ξ", "xi"),
    ("ψ", "psi"),
    ("Θ", "TH"),
    ("Ξ", "XI"),
    ("Ψ", "PSI"),
]

GREEK_TO_LATIN = {greek: latin for greek, latin in GREEK_LATIN_PAIRS}


def xcompose_rule(char, seq):
    name = unicodedata.name(char)
    n = ord(char)
    hexcode = f"U{hex(n).upper()[2:]}"

    rule = f"<Multi_key> {seq} : \"{char}\" {hexcode}  # {name}"
    return rule


def greek_rules():
    for char in chain(find_chars("greek letter")):
        if char.lower() not in GREEK_TO_LATIN:
            continue

        tr = GREEK_TO_LATIN[char]
        seq = "<asterisk> " + " ".join(f"<{c}>" for c in tr)

        yield xcompose_rule(char, seq=seq)


def doublestruck_rules():
    DOUBLESTRUCK_PATTERNS = ["double-struck capital", "double-struck small"]

    for char in chain(find_chars(*DOUBLESTRUCK_PATTERNS)):
        is_italic = "italic" in unicodedata.name(char).lower()
        is_latin = unicodedata.normalize('NFKC', char) in string.ascii_letters
        if (is_italic or not is_latin):
            continue

        normed = unicodedata.normalize('NFKC', char)
        seq = f"<d> <s> <{normed}>"

        yield xcompose_rule(char, seq=seq)


if __name__ == "__main__":
    ALL_RULES = [
        greek_rules(),
        doublestruck_rules(),
    ]
    for rulegroup in ALL_RULES:
        for rule in rulegroup:
            print(rule)
        print()
