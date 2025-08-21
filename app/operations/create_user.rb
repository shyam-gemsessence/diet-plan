class CreateUser
    def self.create(params)
        success_message(params)

        user=User.new(params)
        user.save
        user
    end
end