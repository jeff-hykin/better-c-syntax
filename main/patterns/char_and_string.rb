grammar = Grammar.new_exportable_grammar

# what needs to be imported by these patterns
grammar.external_repos = [
]

# what will be exported by this
grammar.exports = [
    :string
]

# content
    # double quotes
        # simple escapes
        # complex escapes
    # single quotes
        # escapes
    # raw? string

grammar[:string] =  PatternRange.new(
    start_pattern: Pattern.new(
        match: /"/,
        tag_as: "punctuation.definition.string",
        reference: "string_start"
    ),
    end_pattern: Pattern.new(
        match: /"/,
        tag_as: "punctuation.definition.string"
    ),
    includes: [
        # normal escapes \r, \n, \t
        Pattern.new(
            match: /\\./,
            tag_as: "constant.character.escape",
        ),
    ],
)