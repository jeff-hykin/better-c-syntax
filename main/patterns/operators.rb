require_relative "../toolbox.rb"
require_relative "../tokens.rb"
grammar = Grammar.new_exportable_grammar

# what needs to be imported by these patterns
grammar.external_repos = [
]

# what will be exported by this
grammar.exports = [
    :operators
]

grammar[:operators] = Pattern.new(
    match: @tokens.that(:isOperator, :isSymbol, not(:isTernaryOperator)),
    tag_as: "keyword.operator",
)