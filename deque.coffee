# deque.coffee - array implementation of a deque data structure

# Deque - a deque is a double-ended queue where items can be added
# or removed from the front or the back.
class Deque 
  constructor:  ->
    @storage = []

  # Return true if deque is empty else false
  isEmpty: ->
    @storage.length is 0

  # Add an item to the back of the deque
  addBack: (item) ->
    @storage.push item

  # Remove an item from the front of the deque
  # If the deque is empty, return undefined
  removeFront: ->
    unless @isEmpty()
      @storage.shift()

  # Add an item to the front of the deque
  addFront: (item) ->
    @storage.unshift item

  # Remove an item from the back of the deque
  # If the deque is empty, return undefined
  removeBack: ->
    unless @isEmpty()
      @storage.pop()

  # Returns - but does not remove - the front item in the deque.
  peekFront: ->
    unless @isEmpty()
      @storage[0]

  # Returns - but does not remove - the rear item in the deque.
  peekBack: ->
    unless @isEmpty()
      @storage[@storage.length - 1]

  # Clear the deque
  clear: ->
    @storage = []

  # Converts the deque into an array.
  toArray: ->
    @storage

module.exports = Deque

# main app
main = ->
  items = "ABCDEFGH".split("")
  deque = new Deque()

  # push
  for item in items
    deque.addBack item

  # print array
  console.log deque.toArray()

  # peak...
  console.log "peekFront: #{deque.peekFront()}"
  console.log "peekBack: #{deque.peekBack()}"

  # consume ... from left (front)
  console.log "consume left..."
  arr = []
  until deque.isEmpty()
    arr.push deque.removeFront()
  console.log arr.join('')

  # consume ... from right (back)
  deque = new Deque()

  # push
  for item in items
    deque.addBack item

  console.log "consume right..."
  arr = []
  until deque.isEmpty()
    arr.push deque.removeBack()
  console.log arr.join('')

# test client
if module is require.main
  main()

# [ 'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H' ]
# peekFront: A
# peekBack: H
# consume left...
# ABCDEFGH
# consume right...
# HGFEDCBA