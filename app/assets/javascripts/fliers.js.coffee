# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.

jQuery ->
  $('#flier_start_time').datetimepicker({
  timeFormat: 'h:mm t'
  dateFormat: 'mm-dd-yy',
  ampm: true,
  stepMinute: 5,
  separator: ' @ '
  })
