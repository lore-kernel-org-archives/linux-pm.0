From: Eduardo Valentin <edubezval@gmail.com>
Subject: [GIT PULL] Thermal-SoC management updates for v4.2-rc6
Date: Sun, 2 Aug 2015 20:00:34 -0700
Message-ID: <20150803030034.GC30704@localhost.localdomain>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="VywGB/WGlW4DM4P8"
Return-path: <linux-acpi-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
To: Rui Zhang <rui.zhang@intel.com>
Cc: Linux PM <linux-pm@vger.kernel.org>, Linux ACPI <linux-acpi@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org


--VywGB/WGlW4DM4P8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello Rui,

Please pull from

  git://git.kernel.org/pub/scm/linux/kernel/git/evalenti/linux-soc-thermal fixes

to receive Thermal-SoC Management updates for v4.2-rc6 with top-most

3c19d237dd8148926e49259e495ee41dddd1f09c:

  thermal: exynos: Remove unused code related to platform_data on probe() (2015-08-02 19:36:57 -0700)

on top of commit 74d33293e467df61de1b1d8b2fbe29e550dec33b:

  Linux 4.2-rc5 (2015-08-02 18:34:55 -0700)

Specifics:
- Minor fix on thermal core, while unbinding (need to remove weight_attr)
- Change a couple of tracing on power allocator governor
- Driver fixes on: Exynos

BR,

Eduardo Valentin
----------------------------------------------------------------
Chanwoo Choi (2):
      thermal: exynos: Add the dependency of CONFIG_THERMAL_OF instead of CONFIG_OF
      thermal: exynos: Remove unused code related to platform_data on probe()

Javi Merino (1):
      thermal: power_allocator: trace the real requested power

Krzysztof Kozlowski (1):
      thermal: exynos: Disable the regulator on probe failure

Viresh Kumar (1):
      thermal: remove dangling 'weight_attr' device file

 drivers/thermal/power_allocator.c    | 26 ++++++++++++++++----------
 drivers/thermal/samsung/Kconfig      |  2 +-
 drivers/thermal/samsung/exynos_tmu.c |  5 ++---
 drivers/thermal/thermal_core.c       |  1 +
 4 files changed, 20 insertions(+), 14 deletions(-)

--VywGB/WGlW4DM4P8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQEcBAEBAgAGBQJVvtlGAAoJEMLUO4d9pOJWnp8H/0T69jvFK80RwK9jY3BaEaGh
beo1mctigW1cyY33qChFBDzyQlGMRq0FmCPkTvLt9oqytfJqORy6WJeuCrtVQZhm
+Lb3fEOsU3eT6ZAxvfRBUL4FHcZwtMJeGkjZwZZQ4qacqSyFc/0vighpYKdmrjQv
LFGNZF0UY40kVIz5BI5JEOwC9ncWf8goJ8829K3GjuXsdw/3EsxL3KjwEMg1CLfM
+KQHdBi/NFkB+oJI5ia6QLMdF745h5AFdWnkJeq+852l60RtU6wo0ILkw1MUvR/m
MtCNAGpgbSHDmfcKsHrwRG6/agDG3kw/mQkNVFmvAa3HH6QvCtg9tgidKPLYUQI=
=MrxR
-----END PGP SIGNATURE-----

--VywGB/WGlW4DM4P8--
