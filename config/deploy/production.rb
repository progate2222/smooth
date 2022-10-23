server '52.198.152.103', user: 'app', roles: %w{app db web}
set :ssh_options, keys: '/home/sayaka/.ssh/id_rsa'
