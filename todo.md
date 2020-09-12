- consider removing `word_cannot_be_any_of`
- update the tests to use MiniTest assertions
- add `grammar.patternsThat(map:->(each){each+"somethin"})`
- remove the non-ideal things from `utils.rb`
- make it easier to use placeholders by checking for symbols
- start using the tokens
- add a `.grammar.rb` to library files that are ready to be imported
- fix the `.map` calls
- better error messages 

DONE
- create pattern matching for matching any top level pattern
- /REGEX_BEFORE(?>(?<exceptions_group_1>EXCEPTION_PATTERN)|YOUR_NORMAL_PATTERN)(?(<exceptions_group_1>)always(?<=fail)|)REGEX_AFTER/
- change the `.json` extension
- rename the token process
- use `grammar.patternsThat()` instead of `grammar[/pattern/]`
- have a `grammar.add {
       thing1: Pattern.new(),
       thing2: Pattern.new(),
  }