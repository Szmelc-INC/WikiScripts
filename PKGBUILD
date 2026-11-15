# Maintainer: SilverX <serainox@gmail.com>
pkgname=wikiscripts-git
_repo=WikiScripts
pkgver=r0.0000000
pkgrel=1
pkgdesc="Scripts, scrapers and CLI tools for scripting Wikipedia.org (wiki-random, wiki-random-article, wiki-pdf, wiki-file-details)"
arch=('any')
url="https://github.com/Szmelc-INC/WikiScripts"
license=('MIT')
depends=('bash' 'curl' 'wget' 'file' 'sed' 'grep')
makedepends=('git')
source=("git+$url.git")
sha256sums=('SKIP')

pkgver() {
  cd "$_repo"
  ( set -o pipefail
    git describe --long --tags --abbrev=7 2>/dev/null | sed 's/^v//;s/\([^-]*-g\)/r\1/;s/-/./g' ||
    printf "r%s.%s" "$(git rev-list --count HEAD)" "$(git rev-parse --short=7 HEAD)" )
}

prepare() {
  cd "$_repo"
  # random-article calls its sibling by relative path; use the installed command.
  sed -i 's|bash download-article-in-pdf.sh|wiki-pdf|' random-article.sh
}

package() {
  cd "$_repo"
  install -Dm755 random.sh "$pkgdir/usr/bin/wiki-random"
  install -Dm755 random-article.sh "$pkgdir/usr/bin/wiki-random-article"
  install -Dm755 download-article-in-pdf.sh "$pkgdir/usr/bin/wiki-pdf"
  install -Dm755 file-details.sh "$pkgdir/usr/bin/wiki-file-details"
  install -Dm644 LICENSE "$pkgdir/usr/share/licenses/$pkgname/LICENSE"
  install -Dm644 README.md "$pkgdir/usr/share/doc/$pkgname/README.md"
}
