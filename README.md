# clip

A simple clipboard utility for piping content to xclip.

## Install

```bash
gem install clip
```

Requires `xclip` to be installed on your system.

## Usage

```bash
# Copy file contents to clipboard
cat file.txt | clip

# Copy and echo the content
cat file.txt | clip -e

# Copy only the first N lines
cat file.txt | clip -l 10

# Wrap content in markdown code fence
cat script.rb | clip -m ruby

# Append to existing clipboard content
cat more.txt | clip -a

# Paste clipboard contents to stdout
clip

# Copy grep results to clipboard
grep -rn "TODO" src/ | clip
```

### Options

- `-l`, `--line NUMBER` - Copy only the first N lines
- `-e`, `--echo` - Output copied content to stdout
- `-a`, `--append` - Append to clipboard instead of replacing
- `-m`, `--markdown [LANGUAGE]` - Wrap in markdown code fence
- `-h`, `--help` - Print help

## Contributing

Bug reports and pull requests are welcome on GitHub.

## Development

After checking out the repo:

```bash
bin/setup
bundle exec rake test
```

## License

The gem is available as open source under the terms of the [MIT License](LICENSE.txt).
