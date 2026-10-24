# Environment Variables
export GOPATH="$HOME/go"
export EDITOR='nvim'

# PATH Configuration
# Go
export PATH="$PATH:$GOPATH/bin"

# Python
export PATH="$PATH:`python3 -m site --user-base`/bin"

# Rust
export PATH="$PATH:$HOME/.cargo/bin"

# Java
export PATH="/opt/homebrew/opt/openjdk/bin:$PATH"

# Node
export PATH="/opt/homebrew/opt/node@20/bin:$PATH"

# PostgreSQL
export PATH="/opt/homebrew/opt/postgresql@15/bin:$PATH"

# Kubernetes Tools
export PATH="${KREW_ROOT:-$HOME/.krew}/bin:$PATH"
export PATH="$PATH:$HOME/.istioctl/bin"
