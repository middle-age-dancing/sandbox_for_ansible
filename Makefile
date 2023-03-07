SSH_KEY_FILE = ~/.ssh/id_rsa_ansible
SSH_USER = root
SSH_HOST = localhost
SSH_CONFIG = ~/.ssh/config
SSH_PATHPHRASE = ""

define SSH_CONFIG_BODY

Host docker_ansible_thomas
    HostName $(SSH_HOST)
    User $(SSH_USER)
    IdentityFile $(SSH_KEY_FILE)
    Port 2022

Host docker_ansible_gordon
    HostName $(SSH_HOST)
    User $(SSH_USER)
    IdentityFile $(SSH_KEY_FILE)
    Port 2023

Host docker_ansible_james
    HostName $(SSH_HOST)
    User $(SSH_USER)
    IdentityFile $(SSH_KEY_FILE)
    Port 2024

Host docker_ansible_percy
    HostName $(SSH_HOST)
    User $(SSH_USER)
    IdentityFile $(SSH_KEY_FILE)
    Port 2025
endef

.PHONY: ubuntu_mock_ssh_setup
export SSH_CONFIG_BODY
ubuntu_mock_ssh_setup:
	rm -rf $(SSH_KEY_FILE)* && \
	ssh-keygen -R "[localhost]:2022" && \
	ssh-keygen -R "[localhost]:2023" && \
	ssh-keygen -R "[localhost]:2024" && \
	ssh-keygen -R "[localhost]:2025" && \
	ssh-keygen -t rsa -b 4096 -f $(SSH_KEY_FILE) -N $(SSH_PATHPHRASE) && \
	mv $(SSH_KEY_FILE).pub id_rsa.pub && \
	echo "$$SSH_CONFIG_BODY" >> $(SSH_CONFIG)


.PHONY: ubuntu_mock_ssh_reload
ubuntu_mock_ssh_reload:
	ssh-keygen -R "[localhost]:2022" && \
	ssh-keygen -R "[localhost]:2023" && \
	ssh-keygen -R "[localhost]:2024" && \
	ssh-keygen -R "[localhost]:2025"

.PHONY: ubuntu_mock_launch
ubuntu_mock_launch:
	docker-compose up --build

.PHONY: ubuntu_mock_middleware_setup
ubuntu_mock_middleware_setup:
	ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook -i hosts.yml playbook/install_apache.yml

.PHONY: centos_setup
centos_setup:
	echo wip