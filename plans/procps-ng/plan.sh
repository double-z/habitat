pkg_name=procps-ng
pkg_derivation=chef
pkg_version=3.3.11
pkg_maintainer="The Bldr Maintainers <bldr@chef.io>"
pkg_license=('gpl' 'lgpl')
pkg_source=http://downloads.sourceforge.net/project/${pkg_name}/Production/${pkg_name}-${pkg_version}.tar.xz
pkg_shasum=e9493169a2d2adc0bc045538707310c8e877b385e4e296143b62607d2bb044ed
pkg_deps=(chef/glibc chef/ncurses)
pkg_build_deps=(chef/coreutils chef/diffutils chef/patch chef/make chef/gcc)
pkg_binary_path=(bin)
pkg_include_dirs=(include)
pkg_lib_dirs=(lib)
pkg_gpg_key=3853DA6B

do_build() {
  # The Util-linux package will provide the `kill` command
  ./configure \
    --prefix=$pkg_prefix \
    --sbindir=$pkg_prefix/bin \
    --disable-kill
  make
}

do_check() {
  make check
}


# ----------------------------------------------------------------------------
# **NOTICE:** What follows are implementation details required for building a
# first-pass, "stage1" toolchain and environment. It is only used when running
# in a "stage1" Studio and can be safely ignored by almost everyone. Having
# said that, it performs a vital bootstrapping process and cannot be removed or
# significantly altered. Thank you!
# ----------------------------------------------------------------------------
if [[ "$STUDIO_TYPE" = "stage1" ]]; then
  pkg_build_deps=(chef/gcc)
fi