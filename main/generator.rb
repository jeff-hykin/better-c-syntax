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
grammar.import("./patterns/comments.rb")
grammar.import("./patterns/char_and_string.rb")

#
# contexts
#
grammar[:$initial_context] = [
    # comments
    # preprocessor
    # literals
        # true false NULL
        # numbers
        # char
        # string
    # basic types
    # control flow
    # basic punctuation
        # ;
        # ,
        # ()
        # {}
        # []
        # .
        # ->
        # ::
    # operators
    # function call
    # misc keywords
        # namespace
        # typedef
]


# 
# export
#
grammar.save_to(
    directory: "../generated/",
    syntax_name: "syntax.tmLanguage.json",
    tag_name: "scopes.txt",
)