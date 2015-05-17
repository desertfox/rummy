   
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
        owner => $user,
        group => $user,
	    require => [ Package['vim'], User[$user] ]
    }

    file { "/home/${user}/.vim" :
        recurse => true,
        owner => $user,
        group => $user,
        source =>  "${pwd}/modules/vim",
        require => Package['vim']
    }

    file { "/home/${user}/.zshrc" :
        source => "${pwd}/modules/zshrc",
        owner => $user,
        group => $user,
        require => Package['zsh']
    }

    vcsrepo { "/home/${user}/.oh-my-zsh":
        ensure => present,
        provider => git,
        source => "git://github.com/robbyrussell/oh-my-zsh.git"
    }

    #file { "/home/${user}/.oh-my-zsh" :
    #    recurse => true,
    #    owner => $user,
    #    group => $user,
    #    source => "${pwd}/modules/oh-my-zsh",
    #    require => Package['zsh']
    #}
