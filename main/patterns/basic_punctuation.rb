require_relative "../toolbox.rb"
grammar = Grammar.new_exportable_grammar

# what needs to be imported by these patterns
grammar.external_repos = [
]

# what will be exported by this
grammar.exports = [
    :semicolon,
]

grammar[:semicolon] = Pattern.new(
    match: /;/,
    tag_as: "punctuation.terminator.statement",
)