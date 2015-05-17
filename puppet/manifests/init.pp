   $package = ['vim', 'vim-common', 'zsh']

   $user = 'rummy'

   $pwd = inline_template('<%= Dir.pwd %>')

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
        source => "${pwd}/modules/vimrc",
	    require => [ Package['vim'], User[$user] ]
    }

    file { "/home/${user}/.vim" :
        recurse => true,
        source =>  "${pwd}/modules/vim",
        require => Package['vim']
    }

    file { "/home/${user}/.zshrc" :
        source => "${pwd}/modules/zshrc",
        require => Package['zsh']
    }
