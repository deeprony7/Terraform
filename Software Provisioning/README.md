* In instance.tf we first set oursleves a keypair to use
* We need to specify the public key we will use by running `ssh-keygen -f mykey`

* We then provision the instance specifying the ami with a vars lookup from a map variable in vars.tf

* We use `provisioner "file"` to copy over the shell script to the instance

* We use `provisioner "remote-exec"` to execute remote commands 

* We ue the `connection` tag to declare how we want to connect to the instance.

* Make sure you allow ssh from your IP on SG via console(later we ll do it over code)