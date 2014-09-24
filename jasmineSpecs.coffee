describe 'a simple test', ->
    it 'should be true', ->
        expect(true).toBe true

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
