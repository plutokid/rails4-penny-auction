class @MainPage extends Rrs.PageModule
  components:
    userSession: UserSessionComponent.create()


$(document).ready ->
  MainPage.create()