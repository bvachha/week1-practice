qemu-system-x86_64 -name ubuntu-server \
					-net bridge,br=virbr0 -net nic,model=virtio \
	                -drive file=output_ubuntu_server/ubuntu-server,if=virtio,cache=writeback,discard=ignore,format=qcow2 \
	                -drive file=output_ubuntu_server/ubuntu-server-1,if=virtio,cache=writeback,discard=ignore,format=qcow2 \
	                -drive file=output_ubuntu_server/ubuntu-server-2,if=virtio,cache=writeback,discard=ignore,format=qcow2 \
	                -drive file=output_ubuntu_server/ubuntu-server-3,if=virtio,cache=writeback,discard=ignore,format=qcow2 \
	                -machine type=pc,accel=kvm \
	                -smp cpus=2,sockets=2 \
	                -m 1024M 