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
grammar[:comments] = grammar[:comments]
# grammar.import("./patterns/literals.rb")
#     grammar.import("./patterns/numbers.rb")
#     grammar.import("./patterns/char_and_string.rb")
# grammar.import("./patterns/preprocessor.rb")


#
# contexts
#
grammar[:$initial_context] = [
    # [done] comments
    # :comments,
    # preprocessor
    # :preprocessor_context,
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
    
    # :types # DEBUGGING
]


# grammar[:void] = Pattern.new( keyword: "void", adjectives: [ :primitive, :type ])
# grammar[:int]  = Pattern.new( keyword: "int" , adjectives: [ :primitive, :type ])
# token_pattern = grammar.patternsThatAre( %(:primitive) )
# grammar[:types] = Pattern.new(
#     match: /\b\w+/,
#     dont_match: token_pattern,
#     tag_as: "storage.type.primitive storage.type.built-in.primitive"
# )


# 
# export
#
grammar.save_to(
    directory: "../generated/",
    syntax_name: "syntax.tmLanguage.json",
    tag_name: "scopes.txt",
)