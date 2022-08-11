#!/bin/bash -e

USERNAME=${1:-"automatic"}
USER_ID=${2:-"automatic"}
GROUP_ID=${3:-"automatic"}

echo $USER_ID
echo $GROUP_ID

# グループを作成する
if [ "$GROUP_ID" != "automatic" ]; then
    groupadd -g $GROUP_ID $USERNAME
fi

# ユーザを作成する
if [ "$USER_ID" != "automatic" ]; then
    useradd -d /home/$USERNAME -m -s /bin/bash -u $USER_ID -g $GROUP_ID $USERNAME
fi

