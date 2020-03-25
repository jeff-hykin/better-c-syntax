require_relative "../toolbox.rb"
grammar = Grammar.new_exportable_grammar

# what needs to be imported by these patterns
grammar.external_repos = [
]

# what will be exported by this
grammar.exports = [
    :semicolon,
    :comma,
]

grammar[:semicolon] = Pattern.new(
    match: /;/,
    tag_as: "punctuation.terminator.statement",
)

grammar[:comma] = Pattern.new(
    match: /,/,
    tag_as: "punctuation.separator.delimiter.comma"
)

grammar[:line_continuation_character] = Pattern.new(
    match: /\\\n/,
    tag_as: "constant.character.escape.line-continuation",
)

grammar[:parentheses] = PatternRange.new(
    tag_as: "meta.parens",
    start_pattern: Pattern.new(
        match: /\(/,
        tag_as: "punctuation.section.parens.begin.bracket.round"
    ),
    end_pattern: Pattern.new(
        match: /\)/,
        tag_as: "punctuation.section.parens.end.bracket.round"
    ),
    includes: [
        :$initial_context
    ]
)

grammar[:block] = PatternRange.new(
    tag_as: "meta.block",
    start_pattern: Pattern.new(
        match: /\{/,
        tag_as: "punctuation.section.parens.begin.bracket.curly"
    ),
    end_pattern: Pattern.new(
        match: /\}/,
        tag_as: "punctuation.section.parens.end.bracket.curly"
    ),
    includes: [
        :$initial_context
    ]
)