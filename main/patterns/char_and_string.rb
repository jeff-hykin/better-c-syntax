grammar = Grammar.new_exportable_grammar

# what needs to be imported by these patterns
grammar.external_repos = [
]

# what will be exported by this
grammar.exports = [
    :string_context
]

# content
    # double quotes
        # simple escapes
        # complex escapes
    # single quotes
        # escapes

grammar[:string_context] = [
    
    # double quotes
    PatternRange.new(
        tag_as: "string.quoted.double",
        start_pattern: Pattern.new(
            tag_as: "punctuation.definition.string.begin",
            match: maybe(match: /u|u8|U|L/, tag_as: "meta.encoding").then(/"/),
        ),
        end_pattern: Pattern.new(
            tag_as: "punctuation.definition.string.end",
            match: /"/,
        ),
        includes: [
            # universal characters \u00AF, \U0001234F
            Pattern.new(
                match: universal_character,
                tag_as: "constant.character.escape",
            ),
            # normal escapes \r, \n, \t
            Pattern.new(
                match: /\\['"?\\abfnrtv]/,
                tag_as: "constant.character.escape",
            ),
            # octal escapes \017
            Pattern.new(
                match: Pattern.new("\\").then(
                    match: /[0-7]/,
                    at_least: 1.times,
                    at_most: 3.times,
                ),
                tag_as: "constant.character.escape",
            ),
            # hex escapes
            Pattern.new(
                match: Pattern.new("\\x").then(
                    match: /[0-9a-fA-F]/,
                    how_many_times?: 2.times,
                ),
                tag_as: "constant.character.escape",
            ),
            :string_escapes_context_c
        ]
    ),
    
    # single quotes
    PatternRange.new(
        tag_as: "string.quoted.single",
        start_pattern: Pattern.new(
            tag_as: "punctuation.definition.string.begin",
            match: lookBehindToAvoid(/[0-9A-Fa-f]/).maybe(match: /u|u8|U|L/, tag_as: "meta.encoding")
                .then(/'/),
        ),
        end_pattern: Pattern.new(
            tag_as: "punctuation.definition.string.end",
            match: /'/,
        ),
        includes: [
            :string_escapes_context_c,
            :line_continuation_character,
        ]
    ),
]

grammar[:backslash_escapes] = LegacyPattern.new(
    match: "(?x)\\\\ (\n\\\\\t\t\t |\n[abefnprtv'\"?]   |\n[0-3][0-7]{,2}\t |\n[4-7]\\d?\t\t|\nx[a-fA-F0-9]{,2} |\nu[a-fA-F0-9]{,4} |\nU[a-fA-F0-9]{,8} )",
    name: "constant.character.escape"
)

grammar[:string_escapes_context_c] = [
    :backslash_escapes,
    LegacyPattern.new(
        match: "\\\\.",
        name: "invalid.illegal.unknown-escape"
    ),
    LegacyPattern.new(
        # %
        # (\d+\$)?                             # field (argument #)
        # [#0\- +']*                           # flags
        # [,;:_]?                              # separator character (AltiVec)
        # ((-?\d+)|\*(-?\d+\$)?)?              # minimum field width
        # (\.((-?\d+)|\*(-?\d+\$)?)?)?         # precision
        # (hh|h|ll|l|j|t|z|q|L|vh|vl|v|hv|hl)? # length modifier
        # [diouxXDOUeEfFgGaACcSspn%]           # conversion type
        match: "(?x) (?!%')(?!%\")%\n(\\d+\\$)?\t\t\t\t\t\t   # field (argument #)\n[#0\\- +']*\t\t\t\t\t\t  # flags\n[,;:_]?\t\t\t\t\t\t\t  # separator character (AltiVec)\n((-?\\d+)|\\*(-?\\d+\\$)?)?\t\t  # minimum field width\n(\\.((-?\\d+)|\\*(-?\\d+\\$)?)?)?\t# precision\n(hh|h|ll|l|j|t|z|q|L|vh|vl|v|hv|hl)? # length modifier\n[diouxXDOUeEfFgGaACcSspn%]\t\t   # conversion type",
        name: "constant.other.placeholder"
    ),
]