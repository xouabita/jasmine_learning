Jasmine Learning
================

This is a quick cheatsheet for jasmine.
You can check the official doc [here](http://jasmine.github.io/2.0/introduction.html).

The tests are written in coffeescript.
Before to run the tests, you need to install the dependencies (`npm install`).
Then, just run `gulp` or `gulp test`.

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
```coffee
describe 'toBe', ->
    it 'compare w/ "==="', ->
        a = 12
        b = a
        expect(a).toBe b
```
- **not**: invert the matcher
```coffee
 describe 'not', ->
     it 'invert the matcher', ->
         a = 5
         expect(a).not.tobe null
```
- **toEqual**: works for simple litteral, objects
```coffee
 describe 'toEqual', ->

     it 'works for simple litteral and object', ->
         a = 12
         expect(a).toEqual 12

     it 'works also w/ object', ->
         bar =
             a: 12
             b: 15
         foo =
             a: 12
             b: 15
         expect(bar).toEqual foo
```
- **toMatch**: matcher for regular expression
```coffee
describe 'toMatch', ->
    it 'is for regular expressions', ->
        message = "Hello, world !"
        expect(message).toMatch /Hello/
        expect(message).toMatch "Hello"
        expect(message).not.toMatch /foo/
```
- **toBeDefined**: check if something is defined
```coffee
describe 'toBeDefined', ->
    it 'check if it is defined', ->
        a = { foo: 8 }
        expect(a.foo).toBeDefined
        expect(a.bar).not.toBeDefined
```
- **toBeUndefined**: check if smth is undefined
```coffee
describe 'toBeUndefined', ->
    it 'check if smth is undefined', ->
        a = { foo: "baz" }
        expect(a.bar).toBeUndefined
        expect(a.foo).not.toBeUndefined
```
- **toBeNull**: check if smth is null
```coffee
describe 'toBeNull', ->
    it 'check if smth is null', ->
        a = null
        foo = "bar"
        expect(null).toBeNull
        expect(a).toBeNull
        expect(foo).not.toBeNull
```
- **toBeTruthy & toBeFalsy**: is for boolean casting checking
```coffee
describe 'toBeTruthy and toBeFalsy', ->
    it 'is for boolean casting testing', ->
        a = null
        foo = "foo"
        expect(a).toBeFalsy
        expect(foo).toBeTruthy
```
- **toContain**: check if an element is in an array
```coffee
describe 'toContain', ->
    it 'check if an element is in an Array', ->
        a = [
            "foo"
            "bar"
            "baz"
        ]
        expect(a).toContain 'foo'
        expect(a).not.toContain 'lol'
```
- **toBeGreaterThan & toBeLessThan**: is for mathematical comparisons
```coffee
describe 'toBeLessThan & toBeGreaterThan', ->
    it 'is for mathematical comparisons', ->
        pi = 3.1415926
        e  = 2.78
        expect(e).toBeLessThan pi
        expect(pi).toBeGreaterThan e
```
- **toThrow**: is for testing if a function throw an exception
```coffee
describe 'toThrow', ->
    it 'is for testing if a function trow an exception', ->
        foo = -> 1+2
        bar = -> a+3
        expect(foo).not.toThrow
        expect(bar).toThrow
```
