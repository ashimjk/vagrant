Vagrant.configure("2") do |config|
  config.vm.box = "ubuntu/xenial64"

  config.vm.define "ubuntu_minikube" do |ubuntu_minikube|

    config.vm.network "forwarded_port",
      guest: 8001,
      host:  8001,
      auto_correct: true

    config.vm.provider "virtualbox" do |vb|
        vb.name = "Ubuntu Minikube"
        vb.memory = "4096"
        vb.cpus = "4"

    args = []
    config.vm.provision "shell",
        path: "scripts/java.sh",
        args: args

    args = []
    config.vm.provision "shell",
        path: "scripts/docker.sh",
        args: args

    args = []
    config.vm.provision "shell",
        path: "scripts/minikube.sh",
        args: args

    args = []
    config.vm.provision "shell",
        path: "scripts/kubectl.sh",
        args: args
    end

  end

end