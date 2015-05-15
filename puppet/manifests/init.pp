class rummy {

    $package = ['vim-common', 'vim-enhanced', 'zsh']

    $user = 'rummy'

    user { 
        $user:
            ensure => "present",
            managehome => true
    }

    package { 
        $package:
            ensure => "installed"
    } 

    file {
            "/home/${user}/.vimrc" :
            source => "puppet:///modules/${user}/.vimrc",
            require => [ Package['vim-enhanced'], User[$user] ]
    }

    file {
            "/home/${user}/.vim" :
            ensure => directory,
            recurse => true,
            purge => true,
            source => "puppet:///modules/${user}/.vim",
            require => Package['vim-enhanced']
    }

}
