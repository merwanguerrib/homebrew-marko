# Modèle du cask Marko (nom du fichier conservé : `cargo xtask release verify` le lit).
# Publié dans un tap personnel (dépôt `homebrew-marko`) : `brew install --cask <compte>/marko/marko`.
# Le dépôt officiel `homebrew-cask` juge la notoriété de l'application : à tenter plus tard, pas pour une v1.
# Variables remplacées à la publication : 0.1.0, ffe555d028acb95e0a6e2cb0ea1716e3f2032cf0cb356d920799e3140e9a42a7 (du .dmg publié), md.marko.desktop (identifiant de bundle FINAL).
cask "marko" do
  version "0.1.0"
  sha256 "ffe555d028acb95e0a6e2cb0ea1716e3f2032cf0cb356d920799e3140e9a42a7"

  # L'adresse d'une version ne change jamais : le fichier publié sous un numéro n'est jamais remplacé.
  # Bucket R2 `marko-downloads`, servi sur son propre sous-domaine : indépendant du Worker de la landing.
  url "https://downloads.marko.md/Marko-#{version}-mac-arm64.dmg"
  name "Marko"
  desc "Markdown editor with review of AI changes"
  homepage "https://marko.md/"

  # Même source que le manifeste de mise à jour (`update-manifest.json.tmpl`) : une seule dernière version.
  # Pas encore publié : il le sera avec le plugin de mise à jour.
  livecheck do
    url "https://downloads.marko.md/latest.json"
    strategy :json do |json|
      json["version"]
    end
  end

  # À activer seulement quand le plugin de mise à jour est intégré à l'application (il ne l'est pas encore).
  # auto_updates true

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
