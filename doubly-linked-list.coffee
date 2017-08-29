# doubly-linked-list.coffee - object implementation of a doubly-linked list
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

# DoublyLinkedList - a class to represent a doubly linked list.
# The constructor creates references to the first node in the list (head)
# and to the last node (tail) in the list.
class DoublyLinkedList 
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
      break if currentNode is null
    return currentNode

  # Convenience function to add a new node at the end of the list.
  # Returns true if the node was added successfully.
  add: (key) ->
    node = new Node key

    if @isEmpty()
      # Case where the list is empty.
      @head = node
      @tail = node
    else
      # Case where the list is not empty.
      @tail.next = node
      node.previous = @tail
      @tail = node

    @length++
    return true

  # Insert a new key into the list after an existing key.
  # Returns true if the node was inserted successfully, false otherwise.
  insertAfter: (newKey, key) ->
    currentNode = @find key
    return false unless currentNode?

    node = new Node newKey

    subsequentNode = currentNode.next
    @tail = node unless subsequentNode?

    currentNode.next = node
    node.previous = currentNode
    node.next = subsequentNode
    if subsequentNode?
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
    @head = node unless previousNode?

    node.next = currentNode
    currentNode.previous = node
    node.previous = previousNode
    if previousNode?
      previousNode.next = node

    @length++
    return true

  # Remove a node from a linked list
  # Returns true if the node was removed successfully, false otherwise.
  remove: (key) ->
    currentNode = @find key
    return false unless currentNode?

    if not currentNode.previous
      # Current node is first node
      subsequentNode = currentNode.next
      subsequentNode.previous = currentNode.previous
      @head = subsequentNode
    else if not currentNode.next
      # Current node is last node
      previousNode = currentNode.previous
      previousNode.next = currentNode.next
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
    while currentNode
      items.push currentNode.key
      currentNode = currentNode.next
    items

  # Converts the list into an reversed array.
  toReverseArray: ->
    items = []
    currentNode = @tail
    while currentNode
      items.push currentNode.key
      currentNode = currentNode.previous
    items

  # Return a string representation of the list.
  toString: ->
    @toArray().toString()

module.exports = {Node: Node, DoublyLinkedList: DoublyLinkedList}

# main program to test doubly-linked list
main = () ->
  cdllist = new DoublyLinkedList("ABCDE".split(''))
  console.log cdllist.toArray()
  console.log cdllist.toReverseArray()

  # test: find
  console.log "find D", cdllist.find "D"
  console.log "find X", cdllist.find "X"

  # test: insert after
  console.log "insertAfter 'X', 'E'", cdllist.insertAfter "X", "E"
  console.log cdllist.toArray()
  console.log cdllist.toReverseArray()

  console.log "insertAfter 'Y', 'B'", cdllist.insertAfter "Y", "B"
  console.log cdllist.toArray()
  console.log cdllist.toReverseArray()

  # test: insert after
  console.log "insertBefore 'S', 'A'", cdllist.insertBefore "S", "A"
  console.log cdllist.toArray()
  console.log cdllist.toReverseArray()

  console.log "insertBefore 'T', 'D'", cdllist.insertBefore "T", "D"
  console.log cdllist.toArray()
  console.log cdllist.toReverseArray()

  # test: remove node
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


  # try 
  #   dllist.insertBefore 42, 77
  #   console.log dllist.toArray()
  #   console.log dllist.toReverseArray()
  # catch error 
  #   console.log "Data not found error."




# start
if module is require.main
  main()







