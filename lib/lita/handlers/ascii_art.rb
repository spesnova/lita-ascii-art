require "artii"
require "lita-keyword-arguments"

module Lita
  module Handlers
    class AsciiArt < Handler
      route(
        /^aa\s+(\w*)/i,
        :ascii_art_from_text,
        command: true,
        kwargs: {
          font: {
            short: "f",
            default: "standard",
          }
        },
        help: { t("help.ascii_key") => t("help.ascii_value") },
      )

      def ascii_art_from_text(response)
        res = ""
        a = Artii::Base.new(font: response.extensions[:kwargs][:font])
        response.matches.first.each do |c|
          res += a.asciify(c)
        end
        response.reply res
      end
    end

    Lita.register_handler(AsciiArt)
  end
end
