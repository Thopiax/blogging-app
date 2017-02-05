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
//= require bootstrap/dist/js/bootstrap.min
//= require velocity
//= require_tree .

// Create a variable to store the "shift state" (whether it is pressed or not)
var shiftOn = false;
var protoOn = false;

$(document).ready(function() {

  // initialize carousel
  $("#imageCarousel").simplecarousel({
        next: $('.next'),
        prev: $('.prev'),
        slidespeed: 400,
        auto: 4000,
        width: 200,
        height: 280,
    });

  var diary_table = $("#diary_table");
  var txtArea = $('#form_post_text').find('textarea');
  var owl = $('#logo').find('img');

  $(txtArea).on('keyup', function(event) {
    var postContent = txtArea.val();
    if (postContent === "" && protoOn) {
      protoOn = unsetProto();
    } else if (!protoOn && event.keyCode != 8) {
      protoOn = setProto();
    }

  })

  $(txtArea).on('keypress', function(event) {
    var postContent = txtArea.val();
    $('#prototype .post_content').html(postContent);
    shiftOn = event.shiftKey;
    if (event.keyCode == 13) {
      if (shiftOn) {
        $('#new_post').submit();
      } else {
        event.preventDefault();
        txtArea.val( postContent + "\n" );
        buildPost();
      }
    }
  });

  $(window).on('load', emojifyPosts);
  $('#new_post').submit(emojifyPosts);

  function unsetProto() {
    diary_table.css("height", "100%");
    owl.css("width", "50%");
    $('#prototype').fadeOut("slow");
    return false;
  }

  function setProto() {
    diary_table.css("height", "50%");
    owl.css("width", "20%");
    $('#prototype').fadeIn("slow");
    return true;
  }

});

function buildPost() {
  var text = $('textarea').val();
  $('#prototype .post_content').html(text);
  $.post('/api/analyze_text/', {'txt': text}, function(result, textStatus) {
    $('#prototype').velocity(
      {'background-color': result['sentimentColour']},
      {duration: 1200}
    );

    $("#post_sentiment").val(result['sentimentColour']);
    $("#post_emojis").val(convertToEmoji(text));
    $("#post_sent_emoji").val(getSentEmoji(result['sentiment']));

    $('#prototype .post_emojis').html(convertToEmoji(text));
    $('.post_sentiment_emoji').html(getSentEmoji(result['sentiment']));

    // put up keywords and images.
    $(".keyword").find("p").text('');
    $(".images").find("img").attr('src', '');
    if (result.keywords[0] !== "") {
      for (var i = 0; i < result.keywords.length; i++) {
        var img_id = "#image" + i;
        $(img_id).find("img").attr('src', result.images[i]);
        $(img_id).find("img").attr('alt', result.keywords[i]);
      }
    }
  }, "json");
}

function emojifyPosts() {
  $(".post_message").each(function() {
    var post = $(this).find('p');
    var postContent = post.text();
    post.text(convertToEmoji(postContent));
  });
}

function convertToEmoji(text) {
  var input = text.split(" ");
  var output = ""
  for (var i = 0; i < input.length; i++) {
    var emoji = getMeAnEmoji(input[i])[0];
    if (emoji != null && emoji != "" && emoji.trim() != input[i].trim().toLowerCase() ) {
      output += emoji;
    }
  }
  return output;
}

function getSentEmoji(sent) {
  var emoji = "";
  if(sent < 0.15) {
    emoji = getMeAnEmoji('sob');
  } else if (sent < 0.3) {
    emoji = getMeAnEmoji('sad');
  } else if (sent < 0.6) {
    emoji = getMeAnEmoji('neutral_face');
  } else if (sent < 0.8) {
    emoji = getMeAnEmoji('slightly_smiling');
  } else if (sent < 1.0) {
    emoji = getMeAnEmoji('smiley');
  }
  return emoji[0];
}
