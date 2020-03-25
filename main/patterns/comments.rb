require_relative "../toolbox.rb"
require_relative "../tokens.rb"
grammar = Grammar.new_exportable_grammar

# what needs to be imported by these patterns
grammar.external_repos = [
]

# what will be exported by this
grammar.exports = [
    :comment,
    :inline_comment,
]

grammar[:comment] = grammar.import("../imports/cpp-textmate-grammer/source/shared_patterns/inline_comment.rb")
grammar[:inline_comment] = grammar[:comment]