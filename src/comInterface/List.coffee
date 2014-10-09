module.exports = class List

	# This object provides an array-style mechanism for storing data. It can be used
	# for low-level access into Photoshop.
	#
	# This object is ideal when storing data of the same type. All items in the list
	# must be of the same type.
	#
	# You an use the "put" methods, such as putBoolean(), to append new elements,
	# and can clear the entire list using clear(), but cannot otherwise modify the list.
	constructor: (@com, list = new ActionList) ->

		@actionList = self.listify list

	# Read-only. The number of commands that comprise the action
	getCount: ->

		@actionList.count

	# Appends a new value, a reference to an object created in the script
	ref: (ref) ->

		@actionList.putReference Ref.refify(ref)

		@

	# Gets the value of a list element of type ActionReference
	getRef: (i) ->

		@com.ref @actionList.getReference i

	# Shorthand for getRef().execGet()
	getDesc: (i) ->

		@getRef(i).execGet()

	self = @

	@listify: (list) ->

		# debugger

		if list instanceof Function

			list = list()

		if list instanceof List

			return list.actionList

		unless list instanceof ActionList

			throw Error "The object is not an ActionList"

		list

Ref = require './Ref'