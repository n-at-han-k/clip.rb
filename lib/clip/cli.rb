# frozen_string_literal: true

require "optparse"

module Clip
  module Clipboard
    extend self

    def <<(text)
      IO.popen("xclip -selection clipboard", "w") { |clip| clip.print text }
    end

    def paste
      `xclip -selection clipboard -o`
    end
  end

  class CLI
    def call(argv)
      options = { line_number: false, echo: false, markdown: false, append: false }

      OptionParser.new do |opts|
        opts.banner = "Usage: cat file | clip [options]"

        opts.on("-l", "--line NUMBER", Integer, "Line number to copy (default: all)") do |n|
          options[:line_number] = n
        end

        opts.on("-e", "--echo", "After copying, output the copied contents to stdout") do
          options[:echo] = true
        end

        opts.on("-a", "--append", "Append to clipboard instead of replacing") do
          options[:append] = true
        end

        opts.on("-m", "--markdown [LANGUAGE]", "Wrap in markdown code fence") do |lang|
          options[:markdown] = lang || ""
        end

        opts.on("-h", "--help", "Prints this help") do
          puts opts
          return 0
        end
      end.parse!(argv)

      if $stdin.tty?
        puts Clipboard.paste
      else
        output = $stdin.read

        if options[:line_number] && options[:line_number] > 0
          output = output.lines.first(options[:line_number]).join
        end

        if options[:markdown]
          output = "```#{options[:markdown]}\n#{output}\n```"
        end

        if options[:append]
          output = Clipboard.paste + output
        end

        Clipboard << output

        options[:echo] ? puts(output) : puts("Copied! #{output.lines.count} lines")
      end

      0
    end
  end
end
