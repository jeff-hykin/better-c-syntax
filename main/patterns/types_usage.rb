require_relative "../toolbox.rb"
require_relative "../tokens.rb"
grammar = Grammar.new_exportable_grammar

# what needs to be imported by these patterns
grammar.external_repos = [
]

# what will be exported by this
grammar.exports = [
    :simple_type,
    :complex_type,
    :storage_specifier,
]

# content
    # basic types: void, int, etc
    # storage specifiers: const static inline
    # struct thing;
    # reference, pointer
    # vararg_ellipses
    # function pointers

grammar[:simple_type] = Pattern.new(
    match: variableBounds(@tokens.that(:isType)),
    tag_as: "storage.type",
)

grammar[:complex_type] = Pattern.new(
    match: variableBounds(@tokens.that(:isTypeCreator)),
    tag_as: "storage.type.$match",
)

grammar[:storage_specifier] = Pattern.new(
    match: variableBounds(@tokens.that(:isSpecifier).or(@tokens.that(:isQualifier))),
    tag_as: "storage.modifier",
)

