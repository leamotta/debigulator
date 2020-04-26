if Rails.env.development?
  AdminUser.create!(email: 'admin@example.com', password: 'password', password_confirmation: 'password')
  Link.create!(code: 'abcdfghj', destination: 'https://devs.gapfish.com/')
  Parnter.create!(name: 'Google', token: 'yes')
end