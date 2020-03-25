require_relative "../toolbox.rb"
grammar = Grammar.new_exportable_grammar

# what needs to be imported by these patterns
grammar.external_repos = [
    :$initial_context,
    :std_space,
    :evaluation_context,
    :c_conditional_context,
    :block_innards
]

# what will be exported by this
grammar.exports = [
    :default_statement,
    :case_statement,
    :switch_statement,
    :switch_conditional_parentheses,
    :static_assert,
    :backslash_escapes
]

grammar[:default_statement] = PatternRange.new(
    tag_as: "meta.conditional.case",
    start_pattern: Pattern.new(
        std_space.then(
            match:  variableBounds(/default/),
            tag_as: "keyword.control.default"
        )
    ),
    end_pattern: Pattern.new(
        match: /:/,
        tag_as: "punctuation.separator.colon.case.default"
    ),
    includes: [
        :evaluation_context,
        :c_conditional_context
    ]
)

grammar[:case_statement] = PatternRange.new(
    tag_as: "meta.conditional.case",
    start_pattern: Pattern.new(
        std_space.then(
            match: variableBounds(/case/),
            tag_as: "keyword.control.case"
        )
    ),
    end_pattern: Pattern.new(
        match: /:/,
        tag_as: "punctuation.separator.colon.case"
    ),
    includes: [
        :evaluation_context,
        :c_conditional_context
    ]
)

grammar[:switch_statement] = generateBlockFinder(
    name: "switch",
    tag_as: "meta.block.switch",
    start_pattern: Pattern.new(
        std_space.then(
            match: variableBounds(/switch/),
            tag_as: "keyword.control.switch"
        )
    ),
    head_includes: [
        :switch_conditional_parentheses,
        :$initial_context
    ],
    body_includes: [
        :default_statement,
        :case_statement,
        :$initial_context,
        :block_innards
    ],
    needs_semicolon: false,
)