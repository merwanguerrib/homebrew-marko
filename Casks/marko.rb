# Modèle du cask Marko (nom du fichier conservé : `cargo xtask release verify` le lit).
# Publié dans un tap personnel (dépôt `homebrew-marko`) : `brew install --cask merwanguerrib/marko/marko`.
# Le dépôt officiel `homebrew-cask` juge la notoriété de l'application : à tenter plus tard, pas pour une v1.
# Variables remplacées par `ops/release/publish-manifests.sh` : 0.2.3, 2c368779f3fbfe7a36b25f13b1a873c3ff08fcdcfe657e40889519c5e2b4eb40 (du .dmg publié).
cask "marko" do
  version "0.2.3"
  sha256 "2c368779f3fbfe7a36b25f13b1a873c3ff08fcdcfe657e40889519c5e2b4eb40"

  # L'adresse d'une version ne change jamais : le fichier publié sous un numéro n'est jamais remplacé.
  # Bucket R2 `marko-downloads`, servi sur son propre sous-domaine : indépendant du Worker de la landing.
  url "https://downloads.marko.md/Marko-#{version}-mac-arm64.dmg"
  name "Marko"
  desc "Markdown editor with review of AI changes"
  homepage "https://marko.md/"

  # Même source que le mécanisme de mise à jour intégré : une seule dernière version.
  livecheck do
    url "https://downloads.marko.md/latest.json"
    strategy :json do |json|
      json["version"]
    end
  end

  # L'application se met à jour elle-même (plugin de mise à jour, depuis la 0.2.0) : `brew upgrade` ne la remplace pas sous ses pieds.
  auto_updates true

  depends_on arch: :arm64
  depends_on macos: :monterey

  app "Marko.app"

  zap trash: [
    "~/Library/Application Support/md.marko.desktop",
    "~/Library/Caches/md.marko.desktop",
    "~/Library/Preferences/md.marko.desktop.plist",
    "~/Library/Saved Application State/md.marko.desktop.savedState",
  ]
end
