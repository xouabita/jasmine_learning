Jasmine Learning
================

Suite (describe)
----------------

- string: title of the suite
- function: contain a suite of specs

Specification (it)
------------------

- string: title of the spec
- function: contain a codeblock w/ expectations. Pass if all expect are true

Expectation (expect)
--------------------

Chained w/ matchers function

### exemple

```coffee
describe 'a simple test' , ->   # suite
    it 'should be true' , ->    # specification
        expect(true).toBe true  # expectation
```
