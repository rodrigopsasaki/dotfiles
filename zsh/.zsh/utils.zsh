# show_pretty_json <field> <color> <file_path> [filter]
show_pretty_json() {
  local field="$1"
  local color="$2"
  local file_path="$3"
  local filter="$4"
  local entries=()
  local max_width=0

  if [ ! -f "$file_path" ]; then
    echo "File not found: $file_path" >&2
    return 1
  fi

  while IFS= read -r entry; do
    decoded=$(echo "$entry" | base64 --decode)
    if [ -z "$filter" ] || echo "$decoded" | grep -i "$filter" > /dev/null; then
      entries+=("$entry")
      key=$(echo "$decoded" | jq -r '.key')
      [[ ${#key} -gt $max_width ]] && max_width=${#key}
    fi
  done < <(jq -r --arg field "$field" '
    .[$field] // {} 
    | to_entries[] 
    | @base64
  ' "$file_path")

  for entry in "${entries[@]}"; do
    _jq() {
      echo "$entry" | base64 --decode | jq -r "$1"
    }

    name=$(_jq '.key')
    val=$(_jq '.value')

    if [ "$field" = "scripts" ]; then
      val=$(echo "$val" | bat --color=always --plain --language=sh --theme=TwoDark --style=plain --wrap=never --terminal-width "$(tput cols)" 2>/dev/null | tr -d '\n')
    fi

    printf "%b%-${max_width}s%b %s\n" "$color" "$name" "\033[0m" "$val"
  done
}

# pretty print an env file
penv() {
  local envfile="${1:-.env}"

  if [[ ! -f "$envfile" ]]; then
    echo "❌ File not found: $envfile" >&2
    return 1
  fi

  grep -v '^\s*#' "$envfile" | grep -v '^\s*$' | sort | \
    awk -F= '{
      printf "\033[1;36m%-30s\033[0m = \033[0;32m%s\033[0m\n", $1, $2
    }'
}

# export all the values from an .env file as environment variables
load-env() {
  set -a
  source "${1:-.env}"
  set +a
}
