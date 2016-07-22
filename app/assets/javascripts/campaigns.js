$(document.ready(function() {
$('#rewards')
  .on('cocoon:before-insert', function(e,task_to_be_added) {
    task_to_be_added.fadeIn('slow');
  })

  .on('cocoon:before-remove', function(e, task) {
    // allow some time for the animation to complete
    $(this).data('remove-timeout', 1000);
    task.fadeOut('slow');
  });
});
