#!/bin/bash

# 🔧 EDIT THESE VARIABLES
REMOTE_USER="ubuntu"
REMOTE_IP="35.154.101.133"

# Full SSH target
TARGET="$REMOTE_USER@$REMOTE_IP"

echo "📋 Using target: $TARGET"

# Check if SSH key exists
if [ ! -f ~/.ssh/id_rsa.pub ]; then
    echo "🔑 No SSH key found. Generating one..."
    ssh-keygen -t rsa -b 4096 -N "" -f ~/.ssh/id_rsa || { echo "❌ SSH key generation failed."; exit 1; }
else
    echo "✅ SSH key already exists."
fi

# Try to copy SSH key to remote server
echo "📤 Copying SSH key to $TARGET ..."
ssh-copy-id -o StrictHostKeyChecking=no "$TARGET"

# Test the SSH connection
echo "🔐 Testing SSH login..."
ssh -o StrictHostKeyChecking=no "$TARGET" "echo '✅ SSH Login Successful to $TARGET'"
