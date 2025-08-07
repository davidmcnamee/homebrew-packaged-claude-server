class Editor3 < Formula
  desc "Editor3 backend server"
  homepage "https://github.com/yourusername/editor3"
  url "https://github.com/davidmcnamee/packaged-claude-server/archive/v1.0.1.tar.gz"
  sha256 "UPDATE_THIS_SHA256_HASH"
  license "MIT"

  depends_on "node"
  depends_on "yarn"

  def install
    libexec.install Dir["*"]
    
    # Create executable script
    (bin/"editor3").write <<~EOS
      #!/bin/bash
      cd #{libexec}
      yarn install --production
      yarn prisma migrate deploy
      exec node server.js "$@"
    EOS
    
    chmod 0755, bin/"editor3"
  end

  def caveats
    <<~EOS
      To start the editor3 backend:
        editor3
      
      The server will start on http://localhost:3000
      
      First run will install dependencies and set up the database.
    EOS
  end

  service do
    run [opt_bin/"editor3"]
    keep_alive true
    log_path var/"log/editor3.log"
    error_log_path var/"log/editor3.log"
  end

  test do
    system "#{bin}/editor3", "--help"
  end
end
