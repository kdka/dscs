# circular-doubly-linked-list.coffee - implementation of a circular-doubly-linked list
# kindle: Data Structures and Algorithms with JavaScript
# https://github.com/nzakas/computer-science-in-javascript/blob/master/
#   key-structures/doubly-linked-list/doubly-linked-list.js
# https://code.tutsplus.com/articles/
#   key-structures-with-javascript-singly-linked-list-and-doubly-linked-list
#   --cms-23392
# http://cslibrary.stanford.edu/103/LinkedListBasics.pdf

# Node - A class to represent a node in a doubly linked list.
# Each node has a key property that identifies the node and a 
# next/previous property that points to the next/previous node in the list.
class Node 
  constructor: (@key) ->
    @next = null
    @previous = null

  # Return the string representation of a node.
  toString: ->
    @key.toString()

# CircularDoublyLinkedList - a class to represent a circularly doubly 
# linked list. The constructor creates references to the first node 
# in the list (head) and to the last node (tail) in the list.
class CircularDoublyLinkedList 
  constructor: (itemList=[]) ->
    @head = null
    @tail = null
    @length = 0

    for item in itemList
      @add item

  # Return true if list is empty else false.
  isEmpty: ->
    @length is 0

  # Return the size of the list.
  size: ->
    @length

  # Find searches through the list looking for the specified key. 
  # When the key is found find returns the node containing the key.
  # If the linked list is empty or the key is not found find returns null.
  find: (key) ->    
    return null if @isEmpty()

    currentNode = @head
    loop
      break if currentNode.key is key
      currentNode = currentNode.next
      return null if currentNode is @head
    return currentNode

  # Convenience function to add a new node to the end (tail) of the list.
  # Returns true if the node was added successfully.
  add: (key) ->
    node = new Node key

    if @isEmpty()
      # Case where the list is empty.
      @head = node
      @tail = node
      node.next = @head
      node.previous = @tail
    else
      # Case where the list is not empty.
      @tail.next = node
      node.previous = @tail
      node.next = @head
      @tail = node
      @head.previous = node

    @length++
    return true

  # Insert a new key into the list after an existing key.
  # Returns true if the node was inserted successfully, false otherwise.
  insertAfter: (newKey, key) ->
    currentNode = @find key
    return false unless currentNode?

    node = new Node newKey

    subsequentNode = currentNode.next

    if subsequentNode is @head
      # Insert new node at end of list
      node.next = @head
      node.previous = currentNode
      currentNode.next = node
      @head.previous = node
      @tail = node
    else
      # Insert new node after interior item
      currentNode.next = node
      node.previous = currentNode
      node.next = subsequentNode
      subsequentNode.previous = node

    @length++
    return true

  # Insert a new key into the list before an existing key.
  # Returns true if the node was inserted successfully, false otherwise.
  insertBefore: (newKey, key) ->
    currentNode = @find key
    return false unless currentNode?

    node = new Node newKey

    previousNode = currentNode.previous

    if previousNode is @tail
      # Insert new node at front of list
      node.previous = @tail
      node.next = currentNode
      @tail.next = node
      currentNode.previous = node
      @head = node
    else 
      # Insert new node before interior node
      node.next = currentNode
      node.previous = previousNode
      currentNode.previous = node
      previousNode.next = node

    @length++
    return true

  # Remove a node from a linked list
  # Returns true if the node was removed successfully, false otherwise.
  remove: (key) ->
    currentNode = @find key
    return false unless currentNode?

    if currentNode is @head
      # Current node is head node
      subsequentNode = currentNode.next
      subsequentNode.previous = @tail
      @tail.next = subsequentNode
      @head = subsequentNode
    else if currentNode is @tail
      # Current node is tail node
      previousNode = currentNode.previous
      previousNode.next = @head
      @head.previous = previousNode
      @tail = previousNode
    else 
      # Current node is interior node
      previousNode = currentNode.previous
      subsequentNode = currentNode.next
      previousNode.next = subsequentNode
      subsequentNode.previous = previousNode

    @length--
    return true

  # Return the head node
  getHead: ->
    @head

  # Return the tail node
  getTail: ->
    @tail

  # Converts the list into an array.
  toArray: ->
    items = []
    currentNode = @head
    loop
      items.push currentNode.key
      currentNode = currentNode.next
      break if currentNode is @head
    items

  # Converts the list into an reversed array.
  toReverseArray: ->
    items = []
    currentNode = @tail
    loop
      items.push currentNode.key
      currentNode = currentNode.previous
      break if currentNode is @tail
    items

  # Return a string representation of the list.
  toString: ->
    @toArray().toString()

module.exports = {Node: Node, CircularDoublyLinkedList: CircularDoublyLinkedList}

# main program to test doubly-linked list
main = () ->
  cdllist = new CircularDoublyLinkedList("ABCDE".split(''))
  console.log cdllist.toArray()
  console.log cdllist.toReverseArray()

  # test: find
  console.log "find D", cdllist.find "D"
  console.log "find X", cdllist.find "X"

  # test: insert after/before
  console.log "insertAfter 'X', 'E'", cdllist.insertAfter "X", "E"
  console.log cdllist.toArray()
  console.log cdllist.toReverseArray()

  console.log "insertAfter 'Y', 'B'", cdllist.insertAfter "Y", "B"
  console.log cdllist.toArray()
  console.log cdllist.toReverseArray()

  console.log "insertBefore 'S', 'A'", cdllist.insertBefore "S", "A"
  console.log cdllist.toArray()
  console.log cdllist.toReverseArray()

  console.log "insertBefore 'T', 'D'", cdllist.insertBefore "T", "D"
  console.log cdllist.toArray()
  console.log cdllist.toReverseArray()

  console.log "remove 'S'", cdllist.remove "S"
  console.log cdllist.toArray()
  console.log cdllist.toReverseArray()

  console.log "remove 'X'", cdllist.remove "X"
  console.log cdllist.toArray()
  console.log cdllist.toReverseArray()

  console.log "remove 'Y'", cdllist.remove "Y"
  console.log cdllist.toArray()
  console.log cdllist.toReverseArray()

  return

# start
if module is require.main
  main()


