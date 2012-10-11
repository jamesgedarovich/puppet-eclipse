# = Class: eclipse
#
# Manage Eclipse through Puppet
#
# == Parameters:
#
# == Actions:
#   Install Eclipse Juno
#
# == Requires:
#   - Module['Archive']
class eclipse {
	$url32 = "http://www.eclipse.org/downloads/download.php?file=/technology/epp/downloads/release/indigo/SR2/eclipse-jee-indigo-SR2-linux-gtk-x86_64.tar.gz&url=http://ftp.osuosl.org/pub/eclipse/technology/epp/downloads/release/indigo/SR2/eclipse-jee-indigo-SR2-linux-gtk-x86_64.tar.gz&mirror_id=272"
	$url64 = "http://www.eclipse.org/downloads/download.php?file=/technology/epp/downloads/release/indigo/SR2/eclipse-jee-indigo-SR2-linux-gtk-x86_64.tar.gz&url=http://ftp.osuosl.org/pub/eclipse/technology/epp/downloads/release/indigo/SR2/eclipse-jee-indigo-SR2-linux-gtk-x86_64.tar.gz&mirror_id=272"

    Exec {
         path => "/home/vagrant/.rvm/gems/ruby-1.9.3-p194/bin:/home/vagrant/.rvm/gems/ruby-1.9.3-p194@global/bin:/home/vagrant/.rvm/rubies/ruby-1.9.3-p194/bin:/home/vagrant/.rvm/bin:/usr/lib64/ccache:/usr/local/bin:/bin:/usr/bin:/usr/local/sbin:/usr/sbin:/sbin:/home/vagrant/.rvm/bin:/sbin:/usr/sbin:/home/vagrant/.local/bin:/home/vagrant/bin"
     }

    archive::download { "eclipse-jee-indigo-SR2-linux-gtk-x86_64.tar.gz":
	    ensure        => present,
	    url           => $url32,
        timeout       => 360,
	    checksum      => false,
    }

    archive::extract { "eclipse-jee-indigo-SR2-linux-gtk-x86_64":
        ensure     => present,
        target     => "/usr/java",
        require    => Archive::Download["eclipse-jee-indigo-SR2-linux-gtk-x86_64.tar.gz"],
        notify     => Exec["chown-eclipse-jee-indigo-SR2-linux-gtk-x86_64"]
    }

    exec { "chown-eclipse-jee-indigo-SR2-linux-gtk-x86_64.tar.gz" :
        command => "chown -R root:eclipse /usr/java/eclipse",
        require => Archive::Extract["eclipse-jee-indigo-SR2-linux-gtk-x86_64"],
        refreshonly => true,
    }
} 