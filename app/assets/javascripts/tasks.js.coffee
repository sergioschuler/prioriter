# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
jQuery ->
  $('.best_in_place').best_in_place() # Required for best in place gem

  $(".task_checkbox").bind('ajax:success', ->  location.reload() ) # Reload when task checklist is edited

  $('#completed_tasks').on('show.bs.collapse', ->
    $(".chevron").addClass('glyphicon-chevron-down').removeClass('glyphicon-chevron-right')
  )

  $('#completed_tasks').on('hide.bs.collapse', ->
    $(".chevron").addClass('glyphicon-chevron-right').removeClass('glyphicon-chevron-down')
  )