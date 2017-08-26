# queue.coffee - array implementation of a queue data structure

# Queue - a queue is a container that is based on the 
# first-in-first-out (FIFO) policy.
class Queue 
  constructor:  ->
    @storage = []

  # Return true if queue is empty else false
  isEmpty: ->
    @storage.length is 0

  # Add an item to the back of the queue
  add: (item) ->
    @storage.push item

  # Remove an item from the front of the queue
  # If the queue is empty, return undefined
  remove: ->
    unless @isEmpty()
      @storage.shift()

  # Returns - but does not remove - the first item in the queue.
  peek: ->
    unless @isEmpty()
      @storage[0]

  # Clear the queue
  clear: ->
    @storage = []

  # Converts the queue into an array.
  toArray: ->
    @storage

module.exports = Queue

# main app
main = ->
  items = "QUEUE EXAMPLE".split("")
  queue = new Queue()

  # push
  for item in items
    queue.add item

  # print array
  console.log queue.toArray()

  # peak at top
  console.log "peek: #{queue.peek()}"

  # pop items off the queue
  console.log "pop..."
  arr = []
  until queue.isEmpty()
    arr.push queue.remove()
  console.log arr.join('')

# test client
if module is require.main
  main()

# [ 'Q', 'U', 'E', 'U', 'E', ' ', 'E', 'X', 'A', 'M', 'P', 'L', 'E' ]
# peek: Q
# pop...
# QUEUE EXAMPLE