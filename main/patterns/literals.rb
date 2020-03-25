require_relative "../toolbox.rb"
require_relative "../tokens.rb"
grammar = Grammar.new_exportable_grammar

# what needs to be imported by these patterns
grammar.external_repos = [
]

# what will be exported by this
grammar.exports = [
    :language_constants
]

grammar[:language_constants] = Pattern.new(
    match: variableBounds(@tokens.that(:isLiteral)),
    tag_as: "constant.language.$match"
)