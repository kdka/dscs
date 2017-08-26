# stack.coffee - array implementation of a stack data structure

# Stack - a pushdown stack is a container that is based on the
# last-in-first-out (LIFO) policy.
class Stack 
  constructor: () ->
    @storage = []

  # Return true if stack is empty else false.
  isEmpty: ->
    @storage.length is 0

  # Push an item on the stack
  push: (item) ->
    @storage.push item
  
  # Remove and return the top item off the stack.
  # Return undefined, if the stack is empty.
  pop: ->
    unless @isEmpty()
      @storage.pop()

  # Returns - but does not remove - the top item of the stack.
  # Return undefined, if the stack is empty.
  peek: ->
    unless @isEmpty()
      @storage[@storage.length - 1]

  # Clear the stack.
  clear: ->
    @storage = []

  # Converts the stack into an array.
  toArray: ->
    @storage

module.exports = Stack

# main app
main = ->
  items = "STACK EXAMPLE".split("")
  stack = new Stack()

  # push
  for item in items
    stack.push item

  # print array
  console.log stack.toArray()

  # peak at top
  console.log "peek: #{stack.peek()}"

  # pop items off the stack
  console.log "pop..."
  arr = []
  until stack.isEmpty()
    arr.push stack.pop()
  console.log arr.join('')

# test client
if module is require.main
  main()

# [ 'S', 'T', 'A', 'C', 'K', ' ', 'E', 'X', 'A', 'M', 'P', 'L', 'E' ]
# peek: E
# pop...
# ELPMAXE KCATS