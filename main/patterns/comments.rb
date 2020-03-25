require_relative "../toolbox.rb"
grammar = Grammar.new_exportable_grammar

# what needs to be imported by these patterns
grammar.external_repos = [
]

# what will be exported by this
grammar.exports = [
    :comment,
    :inline_comment,
]

grammar[:comment] = Grammar.import("../../imports/cpp-textmate-grammer/source/languages/cpp/lib/inline_comment.rb")[:inline_comment]
grammar[:inline_comment] = grammar[:comment]