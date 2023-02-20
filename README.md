# sandbox_for_ansible

ansible 練習

## setup

1. ssh 鍵を作ります

```
ssh-keygen -t rsa
```

2. 作った公開鍵をルートディレクトリに `id_rsa.pub` で置いてください
3. ssh の設定に以下追加

```
Host docker_ansible_thomas
        HostName localhost
        User root
        IdentityFile ~/.ssh/id_rsa_ansible
        Port 2022

Host docker_ansible_gordon
        HostName localhost
        User root
        IdentityFile ~/.ssh/id_rsa_ansible
        Port 2023

Host docker_ansible_james
        HostName localhost
        User root
        IdentityFile ~/.ssh/id_rsa_ansible
        Port 2024

Host docker_ansible_percy
        HostName localhost
        User root
        IdentityFile ~/.ssh/id_rsa_ansible
        Port 2025
```

4. 以下実行

```
docker-compose up
```

5. ssh で入れるようになってるはず
6. playbook 実行テスト

```
ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook -i hosts.yml playbook/install_apache.yml
```

`ANSIBLE_HOST_KEY_CHECKING` は環境変数に仕込んでもいいが他の ssh に影響出るので非推奨(後で Makefile 作る)
