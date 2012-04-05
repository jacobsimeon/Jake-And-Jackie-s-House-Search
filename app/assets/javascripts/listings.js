$(function(){
  var hide = function(){
    $(document).unbind('click', hide);
    $('a#add-list').popover('hide');
  };

  $('a#add-list').popover({content : "hello popover", placement : 'bottom', trigger : 'manual' }).click(function(){
    $(this).popover('show');
    $(document).bind('click', hide);
  });
  
});
