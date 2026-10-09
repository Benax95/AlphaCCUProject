#!/usr/bin/env bash

### Verifica se l'utente ha passato l'argomento
if [ -z "$1" ]; then
    echo "Errore: Devi specificare il nome del preset."
    echo "Uso: $0 <nome_preset>"
    exit 1
fi

### Salva l'input in una variabile e pulisci solo lettere
PRESET_NAME=$(echo "$1" | sed 's/[^a-zA-Z]//g')

echo "=== Esecuzione CMake con preset: ${PRESET_NAME} ==="
cmake --preset "${PRESET_NAME}"

echo "=== Avvio compilazione ==="
cmake --build --preset "${PRESET_NAME}"

echo "=== Esecuzione comandi Bash personalizzati ==="

### Creazione symlink per il compile_command.json del preset attivo
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ln -sf "${SCRIPT_DIR}/build/${PRESET_NAME}/compile_commands.json"
