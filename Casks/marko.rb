# Modèle du cask Marko (nom du fichier conservé : `cargo xtask release verify` le lit).
# Publié dans un tap personnel (dépôt `homebrew-marko`) : `brew install --cask merwanguerrib/marko/marko`.
# Le dépôt officiel `homebrew-cask` juge la notoriété de l'application : à tenter plus tard, pas pour une v1.
# Variables remplacées par `ops/release/publish-manifests.sh` : 0.2.0, 23ff396e36990c7908ae50749ab6c83c4e9abec6761c4f560e4781e39461c1ea (du .dmg publié).
cask "marko" do
  version "0.2.0"
  sha256 "23ff396e36990c7908ae50749ab6c83c4e9abec6761c4f560e4781e39461c1ea"

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
