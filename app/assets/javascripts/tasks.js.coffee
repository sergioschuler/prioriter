# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
jQuery ->
  # Required for best in place gem
  $('.best_in_place').best_in_place()

  # Reload page when task checklist is edited
  $(".task_checkbox").bind('ajax:success', ->  location.reload() )

  # Drag and drop elements of the task list
  $('#todo_task').sortable(
    axis: 'y'
    update: ->
      $.post($(this).data('update-url'), $(this).sortable('serialize'))
  );

  # Datepicker
  $('#task_deadline').datepicker
    dateFormat: 'yy-mm-dd'    

  # change the chevron when collapsing the list
  $('#completed_tasks').on('show.bs.collapse', ->
    $(".chevron").addClass('glyphicon-chevron-down').removeClass('glyphicon-chevron-right')
  )

  $('#completed_tasks').on('hide.bs.collapse', ->
    $(".chevron").addClass('glyphicon-chevron-right').removeClass('glyphicon-chevron-down')
  )