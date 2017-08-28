# circular-linked-list.coffee - implementation of a circularly-linked list

# Node - A class to represent a node in a singly linked list.
# Each node has a key property that identifies the node and a 
# next property that points to the next node in the list.
class Node 
  constructor: (@key) ->
    @next = null

  # Return the string representation of a node.
  toString: ->
    @key.toString()

# CircularLinkedList - a class to represent a circularly linked list.
# The constructor creates a reference to the first item in the list (head).
class CircularLinkedList 
  constructor: (itemList=[]) ->
    @head = null
    @length = 0
    for item in itemList
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
      return null if currentNode is @head
    return currentNode

  # FindPrevious searches through the linked list looking for the specified
  # key. If the key is found, find returns the node prior to the node 
  # containing the key.
  # Returns the last node if the key matches the first node in the list.
  # Returns null if the key is not found or the list is empty.
  findPrevious: (key) ->    
    return null if @isEmpty()  

    currentNode = @find key
    return null unless currentNode?

    previousNode = currentNode.next
    loop
      break if previousNode.next is currentNode
      previousNode = previousNode.next
    return previousNode

  # Convenience function to add a new node at the end of the list.
  add: (key) ->
    node = new Node key
    if @isEmpty()
      # Case where the list is empty
      @head = node
      node.next = @head
    else
      # Case where the list is not empty
      # Scan through the list and return the last (current) node.
      currentNode = @head
      while currentNode.next isnt @head
        currentNode = currentNode.next

      # Point the current node to the new node.
      # Point the new node to the head
      currentNode.next = node
      node.next = @head

    @length++
    return node

  # Insert a new key into the list after an existing key.
  # Returns true if the node was inserted successfully, false otherwise.
  insertAfter: (newKey, key) ->
    node = new Node newKey
    currentNode = @find key
    return false unless currentNode?

    node.next = currentNode.next
    currentNode.next = node
    @length++
    return true

  # Insert a new key into the list before an existing key.
  # Returns true if the node was inserted successfully, false otherwise.
  insertBefore: (newKey, key) ->
    node = new Node newKey
    currentNode = @find key
    return false unless currentNode?

    # We want to insert node before the current node
    # First step is to find the previous node
    previousNode = @findPrevious key

    if currentNode is @head
      # Insert before the first (head) node
      node.next = @head
      previousNode.next = node
      @head = node
    else
      # Insert before interior node
      node.next = previousNode.next
      previousNode.next = node
    @length++
    return true

  # Remove a node from a linked list
  # Returns true if the node was removed successfully, false otherwise.
  remove: (key) ->
    currentNode = @find key
    return false unless currentNode?

    previousNode = @findPrevious key
    return false unless previousNode?

    if currentNode is @head and previousNode is @head
      # Remove the first (head) and last (head) node
      @head = null
    else if currentNode is @head
      # Remove the first (head) node
      @head = currentNode.next
      previousNode.next = @head
    else
      # Remove an interior node
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
    while node.next isnt @head
      node = node.next
    return node

  # Converts the list into an array.
  toArray: ->
    items = []
    currentNode = @head
    while currentNode
      items.push currentNode.key
      currentNode = currentNode.next
      break if currentNode is @head
    items

  # Return a string representation of the list.
  toString: ->
    @toArray().toString()

module.exports = {Node: Node, CircularLinkedList: CircularLinkedList}

# main program to test linked list
main = () ->
  cllist = new CircularLinkedList("ABCDE".split(''))
  console.log cllist.toArray()

  # test: find and findPrevious
  console.log "find D", cllist.find "D"
  console.log "findPrevious A", cllist.findPrevious "A"
  console.log "findPrevious D", cllist.findPrevious "D"
  console.log "find X", cllist.find "X"
  console.log "findPrevious X", cllist.findPrevious "X"

  # test: insertAfter and insertBefore
  console.log "insertAfter 'X', 'E'", cllist.insertAfter "X", "E"
  console.log cllist.toArray()
  console.log "insertAfter 'Y', 'B'", cllist.insertAfter "Y", "B"
  console.log cllist.toArray()
  console.log "insertAfter 'AA', 'BB'", cllist.insertAfter "AA", "BB"

  console.log "insertBefore 'S', 'A'", cllist.insertBefore "S", "A"
  console.log cllist.toArray()
  console.log "insertBefore 'T', 'D'", cllist.insertBefore "T", "D"
  console.log cllist.toArray()
  console.log "insertBefore 'AA', 'BB'", cllist.insertBefore "AA", "BB"

  # test: remove keys
  keys = cllist.toArray()
  for key in keys
    console.log "remove: #{key}", cllist.remove(key), 
        cllist.size(), cllist.toArray()

  return

# start
if module is require.main
  main()

# [ 'A', 'B', 'C', 'D', 'E' ]
# find D Node {
#   key: 'D',
#   next: Node { key: 'E', next: Node { key: 'A', next: [Object] } } }
# findPrevious A Node {
#   key: 'E',
#   next: Node { key: 'A', next: Node { key: 'B', next: [Object] } } }
# findPrevious D Node {
#   key: 'C',
#   next: Node { key: 'D', next: Node { key: 'E', next: [Object] } } }
# find X null
# findPrevious X null
# insertAfter 'X', 'E' true
# [ 'A', 'B', 'C', 'D', 'E', 'X' ]
# insertAfter 'Y', 'B' true
# [ 'A', 'B', 'Y', 'C', 'D', 'E', 'X' ]
# insertAfter 'AA', 'BB' false
# insertBefore 'S', 'A' true
# [ 'S', 'A', 'B', 'Y', 'C', 'D', 'E', 'X' ]
# insertBefore 'T', 'D' true
# [ 'S', 'A', 'B', 'Y', 'C', 'T', 'D', 'E', 'X' ]
# insertBefore 'AA', 'BB' false
# remove: S true 8 [ 'A', 'B', 'Y', 'C', 'T', 'D', 'E', 'X' ]
# remove: A true 7 [ 'B', 'Y', 'C', 'T', 'D', 'E', 'X' ]
# remove: B true 6 [ 'Y', 'C', 'T', 'D', 'E', 'X' ]
# remove: Y true 5 [ 'C', 'T', 'D', 'E', 'X' ]
# remove: C true 4 [ 'T', 'D', 'E', 'X' ]
# remove: T true 3 [ 'D', 'E', 'X' ]
# remove: D true 2 [ 'E', 'X' ]
# remove: E true 1 [ 'X' ]
# remove: X true 0 []




