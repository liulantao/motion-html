module Motion
  module HTML
    def self.parse(html)
      Doc.new(html)
    end

    class Doc
      def initialize(html)
        @doc = IGHTMLDocument.alloc.initWithHTMLString(html, error: nil)
      end

      def query(q)
        if q =~ %r{^[//|/]}
          node_set = @doc.queryWithXPath(q)
        else
          node_set = @doc.queryWithCSS(q)
        end
        nodes = []
        node_set.enumerateNodesUsingBlock -> (node, index, stop) { nodes << node }
        nodes
      end
    end
  end
end
