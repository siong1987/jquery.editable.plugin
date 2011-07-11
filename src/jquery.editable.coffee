#
# jQuery plugin base
# Author: Teng Siong Ong <siong1987@gmail.com>
#
# Replace div with editable input by using the div's rel as the name for the
# new input.
$ = jQuery

onEditable = false

settings =
  myEditableClass : 'editable-input'
  onClickCallback: ->
  onBlurCallback: ->

methods =
  init: (options) ->
    settings = $.extend settings, options

    @self = $(@)
    methods.addNode @self

  # Add the invisible input element of the current element
  addNode: (element) ->
    # the name of the input is the rel of the div
    name = element.attr("rel")

    # use back the value of the div
    value = element.html()

    element.after("<input type='text' style='display:none;' class='" + settings.myEditableClass + "' name='" + name + "' value='" + value + "' >")

    element.click ->
      @self = $(@)
      methods.onClick @self

    element.next().blur ->
      @self = $(@)
      methods.onBlur @self

  onClick: (element) ->
    if not onEditable
      # To prevent click get called multiple time
      onEditable = true

      @next = element.next()
      @next.show().focus()
      element.hide()

      # return the input element
      settings.onClickCallback(@next)

  onBlur: (element) ->
    if onEditable
      # To prevent click get called multiple time
      onEditable = false

      @prev = element.prev()
      @prev.show()
      element.hide()

      # return the div element
      settings.onBlurCallback(@prev)


$.fn.editable = (options) ->
  return $.each this, ->
    methods.init.call $(this), options
