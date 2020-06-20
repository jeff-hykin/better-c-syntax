require 'textmate_grammar'

#
# alternate operator patterns
#
@double_hash          = Pattern.new(/##|%:%:|\?\?=\?\?=/)
@hash                 = Pattern.new(/##|%:|\?\?=/)
@open_square_bracket  = Pattern.new(/\[|<:|\?\?\(/)
@close_square_bracket = Pattern.new(/\[|:>|\?\?\)/)
@open_curly_brace     = Pattern.new(/\{|<%|\?\?</)
@close_curly_brace    = Pattern.new(/\}|%>|\?\?>/)
# trigraphs only
@backslash            = Pattern.new(/\\|\?\?\//)
@caret                = Pattern.new(/\^|\?\?\'/)
@pipe                 = Pattern.new(/\||\?\?!/)
@tilda                = Pattern.new(/~|\?\?-/)

@universal_character         = Pattern.new(/\\u[0-9a-fA-F]{4}/).or(/\\U[0-9a-fA-F]{8}/)


def universal_character()
    return @universal_character
end

def identifier
    first_character      = Pattern.new(/[a-zA-Z_]/).or(@universal_character)
    subsequent_character = Pattern.new(/[a-zA-Z0-9_]/).or(@universal_character)
    first_character.then(zeroOrMoreOf(subsequent_character))
end

def semicolon()
    return Grammar.import("../imports/cpp-textmate-grammar/source/shared_patterns/basic_punctuation.rb")[:semicolon]
end

def std_space()
    return Grammar.import("../imports/cpp-textmate-grammar/source/shared_patterns/std_space.rb")[:std_space]
end

def variableBounds(regex_pattern)
    lookBehindToAvoid(@standard_character).then(regex_pattern).lookAheadToAvoid(@standard_character)
end

def generateBlockFinder( name:"", tag_as:"", start_pattern:nil, needs_semicolon: true, primary_includes: [], head_includes:[], body_includes: [ :$initial_context ], tail_includes: [ :$initial_context ], secondary_includes:[])
    lookahead_endings = /[;>\[\]=]/
    if needs_semicolon
        end_pattern = Pattern.new(
            match: Pattern.new(
                    lookBehindFor(@close_curly_brace).maybe(@spaces).then(semicolon)
                ).or(
                    semicolon
                ).or(
                    lookAheadFor(lookahead_endings)
                )
            )
    else
        end_pattern = lookBehindFor(@close_curly_brace).or(lookAheadFor(lookahead_endings))
    end
    return PatternRange.new(
        tag_as: tag_as,
        start_pattern: Pattern.new(
                match: start_pattern,
                tag_as: "meta.head."+name,
            ),
        end_pattern: end_pattern,
        includes: [
            *primary_includes,
            # Head
            PatternRange.new(
                tag_as: "meta.head."+name,
                start_pattern: /\G ?/,
                zeroLengthStart?: true,
                end_pattern: Pattern.new(
                    match: @open_curly_brace.or(lookAheadFor(/;/)),
                    tag_as: "punctuation.section.block.begin.bracket.curly."+name
                ),
                includes: head_includes
            ),
            # Body
            PatternRange.new(
                tag_as: "meta.body."+name, # body is everything in the {}'s
                start_pattern: lookBehindFor(@open_curly_brace),
                end_pattern: Pattern.new(
                        match: @close_curly_brace,
                        tag_as: "punctuation.section.block.end.bracket.curly."+name
                    ),
                includes: body_includes
            ),
            # Tail
            PatternRange.new(
                tag_as: "meta.tail."+name,
                start_pattern: lookBehindFor(@close_curly_brace).then(/[\s]*/),
                end_pattern: Pattern.new(/[\s]*/).lookAheadFor(/;/),
                includes: tail_includes
            ),
            *secondary_includes
        ]
    )
end