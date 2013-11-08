# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
jQuery ->
  # Required for best in place gem
  $('.best_in_place').best_in_place()

  # Drag and drop elements of the task list
  $('#todays_tasks, #future_tasks').sortable(
    axis: 'y'
    update: ->
      $.post($(this).data('update-url'), $(this).sortable('serialize'))
  );

  # Remove update buttons and listens to checkbox
  jQuery.fn.submitOnCheck = ->
   @find('input[type=submit]').remove()
   @find('input[type=checkbox]').click ->
     $(this).parent('form').submit()
   this
 
  jQuery ->
   $('.edit_task').submitOnCheck()

  # Datepicker
  $('body').on('focus', "#task_deadline", ->
    $(this).datepicker
      dateFormat: 'yy-mm-dd'
  )
  #$('#task_deadline').datepicker
  #  dateFormat: 'yy-mm-dd'    

  # change the chevron when collapsing the list
  $('#completed_tasks').on('show.bs.collapse', ->
    $(".chevron").addClass('glyphicon-chevron-down').removeClass('glyphicon-chevron-right')
  )

  $('#completed_tasks').on('hide.bs.collapse', ->
    $(".chevron").addClass('glyphicon-chevron-right').removeClass('glyphicon-chevron-down')
  )