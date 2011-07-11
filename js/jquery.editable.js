(function() {
  var $, methods, onEditable, settings;
  $ = jQuery;
  onEditable = false;
  settings = {
    myEditableClass: 'editable-input',
    onClickCallback: function() {},
    onBlurCallback: function() {}
  };
  methods = {
    init: function(options) {
      settings = $.extend(settings, options);
      this.self = $(this);
      return methods.addNode(this.self);
    },
    addNode: function(element) {
      var name, value;
      name = element.attr("rel");
      value = element.html();
      element.after("<input type='text' style='display:none;' class='" + settings.myEditableClass + "' name='" + name + "' value='" + value + "' >");
      element.click(function() {
        this.self = $(this);
        return methods.onClick(this.self);
      });
      return element.next().blur(function() {
        this.self = $(this);
        return methods.onBlur(this.self);
      });
    },
    onClick: function(element) {
      if (!onEditable) {
        onEditable = true;
        this.next = element.next();
        this.next.show().focus();
        element.hide();
        return settings.onClickCallback(this.next);
      }
    },
    onBlur: function(element) {
      if (onEditable) {
        onEditable = false;
        this.prev = element.prev();
        this.prev.show();
        element.hide();
        return settings.onBlurCallback(this.prev);
      }
    }
  };
  $.fn.editable = function(options) {
    return $.each(this, function() {
      return methods.init.call($(this), options);
    });
  };
}).call(this);
