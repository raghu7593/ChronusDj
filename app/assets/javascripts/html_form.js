var HtmlForm = {
  floatLabels: function() {
    var inputFields = $('.floating-labels .cd-label').next();
    inputFields.each(function(){
      var singleInput = $(this);
      //check if user is filling one of the form fields 
      HtmlForm.checkVal(singleInput);
      singleInput.on('change keyup', function(){
        HtmlForm.checkVal(singleInput);  
      });
    });
  },

  checkVal: function(inputField) {
    ( inputField.val() == '' ) ? inputField.prev('.cd-label').removeClass('float') : inputField.prev('.cd-label').addClass('float');
  }
}