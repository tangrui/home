if [ -d /opt/homebrew/bin ]; then
  export PATH="/opt/homebrew/bin:$PATH"
elif [ -d /usr/local/bin ]; then
  export PATH="/usr/local/bin:$PATH"
fi

# Hugging Face
export HF_ENDPOINT="https://hf-mirror.com"
