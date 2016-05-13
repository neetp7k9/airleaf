//= require_self 
$(function(){
  $( "#dialog-form" ).dialog({ autoOpen: false });
  var dialog, form
 
    function addUser() {
      var valid = true;
      
      dialog.dialog( "close" );
      return valid;
    }
 
    dialog = $( "#dialog-form" ).dialog({
      autoOpen: false,
      height: 300,
      width: 350,
      modal: true,
      buttons: {
        "Create an Note": addUser,
        Cancel: function() {
          dialog.dialog( "close" );
        }
      },
      close: function() {
        form[ 0 ].reset();
      }
    });
 
    form = dialog.find( "form" ).on( "submit", function( event ) {
      event.preventDefault();
      addUser();
    });
 
    $( ".pluss-sign" ).button().on( "click", function() {
      dialog.dialog( "open" );
    });
  });

