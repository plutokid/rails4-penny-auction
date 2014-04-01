class @UserSessionComponent extends Rrs.Component

  init: ->
    super
    @_attachFormValidation()
    @_attachServerResonseHandling()

    $(@elements.loginButton).fancybox
      maxWidth	: 400
      maxHeight	: 400
      fitToView	: false
      width		  : '70%'
      height		: '140px'
      autoSize	: false
      closeClick	: false
      openEffect	: 'none'
      closeEffect	: 'none'

    $(@elements.signupButton).fancybox
      maxWidth	: 400
      maxHeight	: 400
      fitToView	: false
      width		  : '70%'
      height		: '160px'
      autoSize	: false
      closeClick	: false
      openEffect	: 'none'
      closeEffect	: 'none'



  elements:
    loginButton     : ".js-login"
    signupButton    : ".js-signup"
    loginForm       : "form#login-form"
    signupForm      : "form#signup-form"

  _attachServerResonseHandling: ->
    $("#{@elements.loginForm}, #{@elements.signupForm}").bind("ajax:success", (event, xhr, settings) ->
      location.reload()
    ).bind("ajax:error", (event, xhr, settings, exceptions) ->
      errorMessages = if xhr.responseJSON['error']
        xhr.responseJSON['error']
      else if xhr.responseJSON['errors']
        $.map(xhr.responseJSON["errors"], (v, k) ->
           k + " " + v
        ).join ""
      else
        "Unknown error"
      $.growlUI("Error", errorMessages)
    )

  _attachFormValidation: ->
    $(@elements.loginForm).validate
      rules:
        email:
          required: yes
          email: yes
        password:
          required: yes

      highlight: (label)->
        $(label).closest('.row').addClass('error').find('.js-error-placement').hide()
      unhighlight: (label)->
        $(label).closest('.row').removeClass('error').find('.js-error-placement').hide()

      errorPlacement: (error, element)->
        $(element).closest('.row').find('.js-error-placement').show().attr 'title', $(error).text()

#      submitHandler: =>
#        helpers.ajax.post
#          url:  'session/login'
#          data:     @_$loginForm.serialize()
#          targetEl: @_$loginForm
#          cbSuccess: (response)->
#            console.log response, response.success
#            if response.success
#              location.reload()
#            else
#              alert response.messages.error
