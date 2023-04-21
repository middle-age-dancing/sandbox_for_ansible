# sandbox_for_ansible

ansible 練習

## setup

1. docker 用の ssh 鍵を作って参照させるまで

A. まだ鍵も config が生成されていない場合

```
make ubuntu_mock_ssh_setup
```

B. すでに鍵も config もある場合（known_host だけ消します）

```
make ubuntu_mock_ssh_reload
```

2. モック環境立てる

```
make ubuntu_mock_launch
```

3. ansible 実行

```
make ubuntu_mock_middleware_setup
```

appendix:

## isucon の 11 予選を実行したい場合

1. https://github.com/middle-age-dancing/ansible-isucon を clone してくる
2. `cd isucon11-qualifier`
3. `ansible-playbook -i standalone.hosts site.yml`
4. `ssh docker_ansible_thomas` でベンチマークやコードが見れるようになる（VSCode でも接続可能）

## ansible の playbook を実行したい場合

hosts の向き先を `docker_ansible_thomas` にすると docker 内で実行される
