   $package = ['vim', 'vim-common', 'zsh']

   $user = 'rummy'

   user { $user:
    	ensure => "present",
    	home   => "/home/${user}",
    	shell  => '/bin/zsh',
    	managehome => true
   }

   exec { 'update':
       command => "/usr/bin/apt-get update"
   }

    package { $package:
            ensure => "installed"
    } 

    file { "/home/${user}/.vimrc" :
        source => inline_template('<%= Dir.pwd + \'/modules/vimrc\' %>'),
	    require => [ Package['vim'], User[$user] ]
    }

    file { "/home/${user}/.vim" :
        recurse => true,
        source =>  inline_template('<%= Dir.pwd + \'/modules/vim\' %>'),
        require => Package['vim']
    }
