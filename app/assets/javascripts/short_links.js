$(document).ready(function() {
  $('.new_short_link').on("ajax:success", function(event, data, status, xhr) {
    $form = $('.new-short-link-container');
    $form.empty();
    $form.show();
    $form.append(xhr.responseText);
  });
});
