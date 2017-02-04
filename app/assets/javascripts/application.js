// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require emoji-translate/emoji-translate
//= require emojilib/emojis
//= require velocity
//= require_tree .

// Create a variable to store the "shift state" (whether it is pressed or not)
shiftOn = false;

$(document).ready(function() {

  $(window).on('keypress', function(event) {
    shiftOn = event.shiftKey;
    if (event.keyCode == 13) {
      if (shiftOn) {
        event.preventDefault();
        var txtArea = $('#form_post_text').find('textarea');
        var postContent = txtArea.val();
        txtArea.val( postContent + "\n" );
      } else {
        $('#new_post').submit();
      }
    }
  });

  $(window).on('load', emojifyPosts);
  $('#new_post').submit(emojifyPosts);

});

function emojifyPosts() {
  $(".post_message").each(function() {
    var post = $(this).find('p');
    var postContent = post.text();
    post.text(convertToEmoji(postContent));
  });
}

function convertToEmoji(text) {
  var input = text.split(" ");
  for (var i = 0; i < input.length; i++) {
    var emoji = getMeAnEmoji(input[i])[0];
    if (emoji != null && emoji !== "" && emoji !== input[i].toLowerCase() ) {
      console.log(emoji);
      input[i] = emoji;
    }
  }
  return input.join(" ");
}
