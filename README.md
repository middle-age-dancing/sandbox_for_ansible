# sandbox_for_ansible

ansible 練習

## setup

1. docker 用の ssh 鍵を作って参照させるまで

```
make ubuntu_mock_ssh_setup
```

2. モック環境立てる

```
make ubuntu_mock_launch
```

3. ansible 実行

```
make ubuntu_mock_middleware_setup
```
