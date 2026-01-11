#!/bin/zsh

docker run -d --name ansible_ee -v $PWD:/src -v $SSH_AUTH_SOCK:/tmp/ssh-sock -e SSH_AUTH_SOCK=/tmp/ssh-sock -w /src ghcr.io/ansible/community-ansible-dev-tools:latest tail -f /dev/null

ansible() {
    docker exec -it ansible_ee ansible $@
}

ansible-playbook() {
    docker exec -it ansible_ee ansible-playbook $@
}

ansible-inventory() {
    docker exec -it ansible_ee ansible-inventory $@
}

ansible-galaxy() {
    docker exec -it ansible_ee ansible-galaxy $@
}

ansible-lint() {
    docker exec -it ansible_ee ansible-lint $@
}

ansible-vault() {
    docker exec -it ansible_ee ansible-vault $@
}

export ansible
export ansible-playbook
export ansible-galaxy
export ansible-lint
export ansible-vault