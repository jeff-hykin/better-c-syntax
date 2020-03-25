require_relative "../toolbox.rb"
require_relative "../tokens.rb"
grammar = Grammar.new_exportable_grammar

# what needs to be imported by these patterns
grammar.external_repos = [
    :std_space,
    :evaluation_context,
    :c_conditional_context,
    :block_innards
]

# what will be exported by this
grammar.exports = [
    :conditional_keywords
]

grammar[:conditional_keywords] = variableBounds(@tokens.that(:isControlFlow))


# todo:
    
    # 
    # if statements
    # 
        # if () ;
        # if () {}
        # else if () ;
        # else if () {}
        # else ;
        # else {}
    
    # 
    # while
    # 
        # while (;;) ;
        # while (;;) {}

    # 
    # for
    # 
        # while (;;) ;
        # while (;;) {}
    
    # break
    # continue
    
    #
    # goto
    #
        # goto ;
        # label:
    
    # 
    # switch statements
    # 
        # switch ()
        #     case:
        #     default
        #     break
    
    