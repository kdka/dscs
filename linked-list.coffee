# linked-list.coffee - object-based linked-list implementation

# Node - A class to represent a node in a singly linked list.
# Each node has a key property that identifies the node and a 
# next property that points to the next node in the list.
class Node 
  constructor: (@key) ->
    @next = null

  # Return the string representation of a node.
  toString: ->
    @key.toString()

# LinkedList - a class to represent a singly linked list.
# The constructor creates a reference to the first item in the list.
class LinkedList 
  constructor: (list=[]) ->
    @head = null
    @length = 0
    for item in list
      @add item

  # Return true if list is empty else false.
  isEmpty: ->
    @length is 0

  # Return the size of the list.
  size: ->
    @length

  # Find searches through the linked list looking for the first
  # instance of the specified key. When the key is found, find 
  # returns the node containing the key.
  # Returns null if the key is not found or the list is empty.
  find: (key) ->  
    return null if @isEmpty()  

    currentNode = @head
    loop
      break if currentNode.key is key
      currentNode = currentNode.next
      break if currentNode is null
    return currentNode

  # FindPrevious searches through the linked list looking for the specified
  # key. If the key is found, find returns the node prior to the node 
  # containing the key.
  # Returns null if the key matches the first node in the list.
  # Returns null if the key is not found or the list is empty.
  findPrevious: (key) ->    
    return null if @isEmpty()  

    currentNode = @head
    previousNode = null
    if currentNode.key is key
      # First node in the list matches the key
      return previousNode

    while currentNode.next
      if currentNode.next.key is key
        previousNode = currentNode
        break
      currentNode = currentNode.next
    return previousNode

  # Convenience function to add a new node at the end of the list.
  # Returns true if the node was added successfully.
  add: (key) ->
    node = new Node key
    if @isEmpty()
      @head = node
      @length++
      return true

    # Scan through the list and return the last (current) node.
    currentNode = @head
    while currentNode.next
      currentNode = currentNode.next

    # Point the current node to the new node.
    currentNode.next = node
    @length++
    return true

  # Insert a new key into the list after an existing key.
  # Returns true if the node was inserted successfully, false otherwise.
  insertAfter: (newKey, key) ->
    node = new Node newKey
    currentNode = @find key
    return false unless currentNode?

    if currentNode.next
      # Insert after interior node
      node.next = currentNode.next
      currentNode.next = node
    else
      # Insert after last (tail) node
      currentNode.next = node
    @length++
    return true

  # Insert a new key into the list before an existing key.
  # Returns true if the node was inserted successfully, false otherwise.
  insertBefore: (newKey, key) ->
    node = new Node newKey
    currentNode = @find key
    return false unless currentNode?

    if currentNode is @head
      # Insert before the first (head) node
      node.next = @head
      @head = node
    else
      # Insert before interior node
      previousNode = @findPrevious key
      return false unless previousNode?
      node.next = previousNode.next
      previousNode.next = node
    @length++
    return true

  # Remove a node from a linked list
  # Returns true if the node was removed successfully, false otherwise.
  remove: (key) ->
    currentNode = @find key
    return false unless currentNode?

    if currentNode is @head
      # Remove the first (head) node
      @head = currentNode.next
    else
      # Remove an interior node
      previousNode = @findPrevious key
      return false unless previousNode?
      previousNode.next = currentNode.next
    @length--
    return true

  # Return the head node
  getHead: ->
    @head

  # Return the tail node
  getTail: ->
    if @isEmpty() then return @head

    node = @head
    while node.next
      node = node.next
    return node

  # Converts the collection of keys to an array.
  toArray: ->
    items = []
    currentNode = @head
    while currentNode
      items.push currentNode.key
      currentNode = currentNode.next
    items

  # Return a string representation of the list.
  toString: ->
    @toArray().toString()

module.exports = {Node: Node, LinkedList: LinkedList}

# main program to test linked list
main = () ->
  llist = new LinkedList("ABCDE".split(''))
  console.log llist.toArray()

  # test: find and findPrevious
  console.log "find D", llist.find "D"
  console.log "findPrevious A", llist.findPrevious "A"
  console.log "findPrevious D", llist.findPrevious "D"
  console.log "find X", llist.find "X"

  # test: insertAfter and insertBefore
  console.log "insertAfter 'X', 'E'", llist.insertAfter "X", "E"
  console.log llist.toArray()

  console.log "insertAfter 'Y', 'B'", llist.insertAfter "Y", "B"
  console.log llist.toArray()

  console.log "insertAfter 'Z', 'T'", llist.insertAfter "Z", "T"
  console.log llist.toArray()

  console.log "insertBefore 'S', 'A'", llist.insertBefore "S", "A"
  console.log llist.toArray()

  console.log "insertBefore 'T', 'D'", llist.insertBefore "T", "D"
  console.log llist.toArray()

  console.log "insertBefore 'AA', 'BB'", llist.insertBefore "AA", "BB"
  console.log llist.toArray()

  # test: remove keys
  keys = llist.toArray()
  for key in keys
    console.log "remove: #{key}", llist.remove(key), llist.toArray()

  return


# start
if module is require.main
  main()

# [ 'A', 'B', 'C', 'D', 'E' ]
# find D Node { key: 'D', next: Node { key: 'E', next: null } }
# findPrevious A null
# findPrevious D Node {
#   key: 'C',
#   next: Node { key: 'D', next: Node { key: 'E', next: null } } }
# find X null
# insertAfter 'X', 'E' true
# [ 'A', 'B', 'C', 'D', 'E', 'X' ]
# insertAfter 'Y', 'B' true
# [ 'A', 'B', 'Y', 'C', 'D', 'E', 'X' ]
# insertAfter 'Z', 'T' false
# [ 'A', 'B', 'Y', 'C', 'D', 'E', 'X' ]
# insertBefore 'S', 'A' true
# [ 'S', 'A', 'B', 'Y', 'C', 'D', 'E', 'X' ]
# insertBefore 'T', 'D' true
# [ 'S', 'A', 'B', 'Y', 'C', 'T', 'D', 'E', 'X' ]
# insertBefore 'AA', 'BB' false
# [ 'S', 'A', 'B', 'Y', 'C', 'T', 'D', 'E', 'X' ]
# remove: S true [ 'A', 'B', 'Y', 'C', 'T', 'D', 'E', 'X' ]
# remove: A true [ 'B', 'Y', 'C', 'T', 'D', 'E', 'X' ]
# remove: B true [ 'Y', 'C', 'T', 'D', 'E', 'X' ]
# remove: Y true [ 'C', 'T', 'D', 'E', 'X' ]
# remove: C true [ 'T', 'D', 'E', 'X' ]
# remove: T true [ 'D', 'E', 'X' ]
# remove: D true [ 'E', 'X' ]
# remove: E true [ 'X' ]
# remove: X true []







