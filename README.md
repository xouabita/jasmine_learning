Jasmine Learning
================

### Suite (describe)

- string: title of the suite
- function: contain a suite of specs

### Specification (it)

- string: title of the spec
- function: contain a codeblock w/ expectations. Pass if all expect are true

### Expectation (expect)

Chained w/ matchers function

#### Example:

```coffee
describe 'a simple test' , ->   # suite
    it 'should be true' , ->    # specification
        expect(true).toBe true  # expectation
```

Matcher functions
-----------------

- **toBe**: compare w/ ===
- **toEqual**: works for simple litteral, objects
- **toMatch**: matcher for regular expression
- **toBeDefined**: check if something is defined
- **toBeUndefined**: check if smth is undefined
- **toBeNull**: check if smth is null
- **toBeTruthy & toBeFalsy**: is for boolean casting checking
- **toContain**: check if an element is in an array
- **toBeGreaterThan & toBeLessThan**: is for mathematical comparisons
- **toThrow**: is for testing if a function throw an exception
