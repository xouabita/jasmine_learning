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

    describe 'Spies', ->

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

        describe 'Chaining functions', ->

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

                it 'when called return the requested value', ->
                    expect(fetchedBar).toEqual 745

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

        describe 'Matching anything with & partial matching', ->

            describe 'jasmine.any', ->
                it 'matches any value', ->
                    expect({}).toEqual jasmine.any(Object)
                    expect(42).toEqual jasmine.any(Number)
                it 'is useful for comparing arguments when used w/ a spy', ->
                    foo = jasmine.createSpy('foo')
                    foo 12, -> return true

                    expect(foo).toHaveBeenCalledWith jasmine.any(Number), jasmine.any(Function)

        describe 'jasmine.objectContaining', ->

            foo = undefined

            beforeEach ->
                foo =
                    a: 1
                    b: 2
                    bar: 'baz'
                return

            it 'matches objects w/ the expect key/value pair', ->
                expect(foo).toEqual jasmine.objectContaining
                    bar: 'baz'
                expect(foo).not.toEqual jasmine.objectContaining
                    c: false
