Rails.application.config.middleware.use OmniAuth::Builder do
  provider :google_oauth2, "253971741001-qh5bdetkspmp5sjp72s9ra3nj0iiq8ht.apps.googleusercontent.com", "cLP_iSQQhCAQkmlzIteU_WRE", {
    scope: 'email, profile',
    hd: 'chronus.com'
  }
end