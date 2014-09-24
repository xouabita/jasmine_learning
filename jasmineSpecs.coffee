describe 'a simple test', ->    # suite
    it 'should be true', ->     # specification
        expect(true).toBe true  # expectation

describe 'Jasmine learning', ->

    describe 'Included matchers:', ->

        describe 'toBe', ->
            it 'compare w/ "==="', ->
                a = 12
                b = a
                expect(a).toBe b

        describe 'not', ->
            it 'invert the matcher', ->
                a = 5
                expect(a).not.toBe null

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

        describe 'toMatch', ->
            it 'is for regular expressions', ->
                message = "Hello, world !"
                expect(message).toMatch /Hello/
                expect(message).toMatch "Hello"
                expect(message).not.toMatch /foo/

        describe 'toBeDefined', ->
            it 'check if it is defined', ->
                a = { foo: 8 }
                expect(a.foo).toBeDefined
                expect(a.bar).not.toBeDefined

        describe 'toBeUndefined', ->
            it 'check if smth is undefined', ->
                a = { foo: "baz" }
                expect(a.bar).toBeUndefined
                expect(a.foo).not.toBeUndefined

        describe 'toBeNull', ->
            it 'check if smth is null', ->
                a = null
                foo = "bar"
                expect(null).toBeNull
                expect(a).toBeNull
                expect(foo).not.toBeNull

        describe 'toBeTruthy and toBeFalsy', ->
            it 'is for boolean casting testing', ->
                a = null
                foo = "foo"
                expect(a).toBeFalsy
                expect(foo).toBeTruthy

        describe 'toContain', ->
            it 'check if an element is in an Array', ->
                a = [
                    "foo"
                    "bar"
                    "baz"
                ]
                expect(a).toContain 'foo'
                expect(a).not.toContain 'lol'

        describe 'toBeLessThan & toBeGreaterThan', ->
            it 'is for mathematical comparisons', ->
                pi = 3.1415926
                e  = 2.78
                expect(e).toBeLessThan pi
                expect(pi).toBeGreaterThan e

        describe 'toThrow', ->
            it 'is for testing if a function trow an exception', ->
                foo = -> 1+2
                bar = -> a+3
                expect(foo).not.toThrow
                expect(bar).toThrow

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

        describe 'usage of the "this" keyword', ->
            beforeEach ->
                this.foo = 0

            it 'can use the "this" to share state', ->
                expect(this.foo).toEqual 0
                this.bar = "foobarlol"

            it 'create an empty "this" before each spec', ->
                expect(this.foo).toEqual 0
                expect(this.bar).toBeUndefined

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

