#!/usr/bin/env bash

# Bash Script

set -o errexit
set -o pipefail
set -o nounset

# Set magic variables for current file & dir
__dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
__file="${__dir}/$(basename "${BASH_SOURCE[0]}")"
__base="$(basename ${__file} .sh)"
__root="$(cd "$(dirname "${__dir}")" && pwd)" # <-- change this as it depends on your app

arg1="${1:-}"

HAS_GIT="$(type "git" &> /dev/null && echo true || echo false)"
HAS_DOCKER="$(type "docker" &> /dev/null && echo true || echo false)"
URL_RELEASES="https://github.com/haproxytech/spoa-mirror.git"

buildImage() {
    echo "🏃 Construindo imagem spoa-mirror a partir do repositorio oficial."
    docker build -t spoa-mirror https://github.com/haproxytech/spoa-mirror.git
    if [[ $STATUS_CODE == "0" ]]; then
        return 0
    else
        return 1
    fi
}

main() {
    if [[ "${HAS_GIT}" == "false" ]]; then
        echo "😐 Instale git e tente novamente."
        exit 1
    elif [[ "${HAS_DOCKER}" == "false" ]]; then
        echo "😐 Instale docker e tente novamente."
        exit 1
    else
        buildImage
        RETURN_CODE=$?
        if [[ $RETURN_CODE != 0 ]]; then
            echo "👎 Houve uma falha durante a construcao de imagem."
            exit 1
        else
            echo "🎉 A imagem foi construida com sucesso!"
        fi
    fi
}

main
