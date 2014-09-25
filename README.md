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

*There is also two other matchers which are specifics for spy*:

- **toHaveBeenCalled**: to check if the element we are spying have been called
- **toHaveBeenCalledWith**: to check if an element have been called w/ an argument

You can learn more about them in the [Spies](#spies) section.

beforeEach & afterEach
----------------------

The beforeEach is called before each spec in the `describe` is run.

#### Example:

```coffee
describe 'beforeEach & afterEach', ->
    describe 'beforeEach', ->
        foo = 0               # init the variable foo w/ 0
        beforeEach ->         # will be call before each spec ("it")
            foo += 1

        # Here beforeEach is called and foo have a value of 1
        it 'foo should be 1', ->
            expect(foo).toEqual 1

        # beforeEach is called, and foo have a value of 2
        it 'foo should not be equal to 1, but 2', ->
            expect(foo).not.toEqual 1
            expect(foo).toEqual 2

    describe 'afterEach', ->
        # to reset the value after each spec, we can use afterEach
        # afterEach is called once after each specs
        foo = 0
        beforeEach ->
            foo += 1
        afterEach ->
            foo = 0

        # beforeEach is called, foo have a value of 1
        it 'foo should be equal to 1', ->
            expect(foo).toEqual 1
        # afterEach is called, foo is reset to 0

        it 'foo should still have a value of 1', ->
            expect(foo).toEqual 1
```

We can also use `this` to share variables between specs.

#### Example:

```coffee
describe 'usage of the "this" keyword', ->
    beforeEach ->
        this.foo = 0

    it 'can use the "this" to share state', ->
        expect(this.foo).toEqual 0
        this.bar = "foobarlol"

    it 'create an empty "this" before each spec', ->
        expect(this.foo).toEqual 0
        expect(this.bar).toBeUndefined
```

Disabled suites and pending specs
---------------------------------

Suites and Specs can be disabled with the `xdescribe` and `xit` keywords.  
The suites are skipped, and the specs are pended.

#### Example:

```coffee
describe 'Disabled suites and pending specs', ->
    xdescribe 'This spec will be skipped', ->
        foo = null
        beforeEach ->
            foo = 0
            foo += 1
        it 'can be false', -> # not written as skipped in the output
            expect(foo).toBe 42

    describe 'Pending specs ....', ->

        xit 'can be declared w/ "xit"', -> # written as skipped in the output
           expect(true).toBeFalse

        it 'can be declared w/ it but w/o a function' # written as skipped in the output

        it 'can be declared by calling "pending" in the spec body', -> # written as skipped in the output
            expect(true).toBe false
            pending()
            return
```

<a name="spies"></a> Spies
--------------------------

A spy stub a function and track every call to it.
You can use two specifics matchers : `toHaveBeenCalled` and `toHaveBeenCalledWith`.

The matcher `toHaveBeenCalled` is true if the specific function was called.
The matcher `toHaveBeenCalledWith` is true if the specific function was called w/ specific arguments.

The spy will not call the implementation of the function which is spied. So you need use chaining
with `callThrough` to call the function w/ `.and.callThrough()`.

Here is an example to understand how it work:

```coffee
describe 'a simple spy exemple', ->

    my_awesome_object = undefined
    bar               = undefined
    baz               = undefined

    beforeEach ->

        # Let's create an object
        my_awesome_object =
            setBar: (value) ->
                bar = value
                return
            setBaz: (value) ->
                baz = value
                return

        # Let's create two spies
        spyOn(my_awesome_object, 'setBar')                  # A simple spy
        spyOn(my_awesome_object, 'setBaz').and.callThrough() # A spy w/ callThrough

        my_awesome_object.setBar 42
        my_awesome_object.setBaz "some text"

        return

    it 'should track that the spy was called', ->
        expect(my_awesome_object.setBar).toHaveBeenCalled
        expect(my_awesome_object.setBaz).toHaveBeenCalled

    it 'should tracks arguments of its call', ->
        expect(my_awesome_object.setBar).toHaveBeenCalledWith 42
        expect(my_awesome_object.setBaz).toHaveBeenCalledWith "some text"

    it 'will show you the difference with and without callThrough', ->

        # When called without callThrough, the bar variable is still undefined
        expect(bar).toBeUndefined

        # It's because spyOn will not the implementation of the function
        # We need to add callThrough if we want that the function work
        expect(baz).toEqual "some text"
```

### Chaining functions

- **returnValue**: all calls to the function will return the requested value
```coffee
describe 'and.returnValue', ->

    foo = undefined
    bar = undefined
    fetchedBar = undefined

    beforeEach ->
        foo =
            setBar: (value) ->
                bar = value
                return
            getBar: -> bar

        spyOn(foo,'getBar').and.returnValue 745

        foo.setBar 123
        fetchedBar = foo.getBar()
        return

    it 'track that the spy was called', ->
        expect(foo.getBar).toHaveBeenCalled

    it 'should not affect other functions', ->
        expect(bar).toEqual 123
```
- **callFake**: all calls to the spy will delegate to another function
```coffee
describe 'and.callFake', ->
    foo = undefined
    bar = undefined
    baz = undefined

    beforeEach ->
        foo =
            setBar: (value) ->
                bar = value
                return

        setBaz = (value) ->
            baz = value
            return

        spyOn(foo, 'setBar').and.callFake setBaz

        foo.setBar 79
        return

    it 'should call the fake function that will set baz to 79 and bar should be undefined', ->
        expect(bar).toBeUndefined
        expect(baz).toEqual 79
```
- **throwError**: when the function is called, it throw a specific error
```coffee
describe 'and.throwError', ->
    foo = undefined
    bar = undefined

    beforeEach ->
        foo = { setBar: (value) -> bar = value; return }

        spyOn(foo, 'setBar').and.throwError 'error'

    it 'throw the value', ->
        expect( ->
            foo.setBar 123
        ).toThrowError('error')
```
- **stub**: return to the original stubbing behavior
```coffee
describe 'and.stub', ->
    foo = null
    bar = null

    beforeEach ->
        foo = { setBar: (value) -> bar = value; return }

        spyOn(foo, 'setBar').and.callThrough()

    it 'can call through and then stub in the same spec', ->
        foo.setBar 69
        expect(bar).toEqual 69

        foo.setBar.and.stub()
        bar = null

        foo.setBar 42
        expect(bar).toBeNull
```

### Other tracking properties

- **.calls.any()**: return false if the spy has not been called at all, and true if
at least one call happened.
- **.calls.count()**: return the number of time the spy was called
- **.calls.argsFor(index)**: return the arguments to call number index
- **.calls.allArgs()**: returns the arguments to all calls

#### Example:

```coffee
describe 'Other tracking properties', ->

    foo = null
    bar = null

    beforeEach ->
        foo =
            setBar: (value) ->
                bar = value
                return
        spyOn foo, 'setBar'
        return

    describe '.calls.any()', ->
        it 'tracks if it was called at all', ->

            expect(foo.setBar.calls.any()).toBeFalsy

            foo.setBar()

            expect(foo.setBar.calls.any()).toBeTruthy

    describe '.calls.count()', ->
        it 'count the number of times it was called', ->

            expect(foo.setBar.calls.count()).toEqual 0

            foo.setBar()
            foo.setBar()

            expect(foo.setBar.calls.count()).toEqual 2

    describe '.calls.argsFor(index)', ->
        it 'tracks elements of each call', ->
            foo.setBar 42
            foo.setBar "hello", "world"
            foo.setBar
                lol: "foooooooo"
                bar: 'mmmhhhhhh'

            expect(foo.setBar.calls.argsFor(0)).toEqual [ 42 ]
            expect(foo.setBar.calls.argsFor(1)).toEqual [ "hello", "world" ]
            expect(foo.setBar.calls.argsFor(2)).toEqual [
                lol: "foooooooo"
                bar: 'mmmhhhhhh'
            ]

    describe '.calls.allArgs', ->
        it 'tracks all the arguments of all calls', ->
            foo.setBar 42
            foo.setBar "hello", "world"

            expect(foo.setBar.calls.allArgs()).toEqual [
                [ 42 ]
                [ "hello", "world" ]
            ]
```
