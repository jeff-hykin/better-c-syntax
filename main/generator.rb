require 'textmate_grammar'

# 
# create the grammar
# 
grammar = Grammar.new(
    name: "C",
    scope_name: "source.c",
    fileTypes: [
		"cc",
		"C",
		"h",
    ],
    version: "",
)

# 
# imports
# 
grammar.import("./patterns/strings.rb")
grammar.import("../imports/cpp-textmate-grammer/source/shared_patterns/inline_comment.rb")
grammar.import("../imports/cpp-textmate-grammer/source/shared_patterns/std_space.rb")


#
# contexts
#
grammar[:$initial_context] = [
    :string
]


# 
# export
#
grammar.save_to(
    directory: "../generated/",
    syntax_name: "syntax.tmLanguage.json",
    tag_name: "scopes.txt",
)