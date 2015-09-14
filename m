From: Eduardo Valentin <edubezval@gmail.com>
Subject: [GIT PULL] Thermal-SoC management updates for v4.3-rc2
Date: Sun, 13 Sep 2015 20:55:01 -0700
Message-ID: <20150914035500.GC5075@localhost.localdomain>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="MnLPg7ZWsaic7Fhd"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Rui Zhang <rui.zhang@intel.com>
Cc: Linux ACPI <linux-acpi@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org


--MnLPg7ZWsaic7Fhd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello Rui,

(apologize for duplicates, now copying the mailing lists)

Please pull from

  git://git.kernel.org/pub/scm/linux/kernel/git/evalenti/linux-soc-thermal fixes

to receive Thermal-SoC Management updates for v4.3-rc2 with top-most

eba4f88d5af84e0fcaa5d6eb4fe35a75c47203cb:

  thermal: cpu_cooling: free power table on error or when unregistering (2015-09-13 20:34:05 -0700)

on top of commit 6ff33f3902c3b1c5d0db6b1e2c70b6d76fba357f:

  Linux 4.3-rc1 (2015-09-12 16:35:56 -0700)

Specifics:
- Add compile test flags on thermal drivers that allow it without
producing compilation errors
- Fixes around memory allocation on cpu_cooling
- Fix on db8500 cpufreq code to allow autoload
- Maintainer entries for cpu cooling device

More fixes still to come, but if not for rc2, for rc3.

BR,

Eduardo Valentin
----------------------------------------------------------------
Eduardo Valentin (10):
      thermal: hisi: allow compile test
      thermal: spear: allow compile test
      thermal: rockchip: allow compile test
      thermal: kirkwood: allow compile test
      thermal: dove: allow compile test
      thermal: armada: allow compile test
      thermal: exynos: allow compile test
      thermal: qcom_spmi: allow compile test
      thermal: ti-soc: allow compile test
      thermal: ti-soc: Kconfig fix to avoid menu showing wrongly

Javi Merino (2):
      thermal: cpu_cooling: don't call kcalloc() under rcu_read_lock
      thermal: cpu_cooling: free power table on error or when unregistering

Luis de Bethencourt (1):
      thermal: db8500_cpufreq_cooling: Fix module autoload for OF platform driver

Punit Agrawal (1):
      thermal: Fix thermal_zone_of_sensor_register to match documentation

Viresh Kumar (1):
      thermal: cpu_cooling: Add MAINTAINERS entry

 MAINTAINERS                              | 10 ++++++
 drivers/thermal/Kconfig                  | 17 ++++++-----
 drivers/thermal/cpu_cooling.c            | 52 +++++++++++++++++++-------------
 drivers/thermal/db8500_cpufreq_cooling.c |  1 +
 drivers/thermal/ti-soc-thermal/Kconfig   |  8 ++---
 include/linux/thermal.h                  |  2 +-
 6 files changed, 55 insertions(+), 35 deletions(-)

--MnLPg7ZWsaic7Fhd
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQEcBAEBAgAGBQJV9kUMAAoJEMLUO4d9pOJW/4oH/187mKDBq/A74F+54NdXHQF+
Kfkw+WFnpOcqLdQGGgGkZuzhlpy7B42Z2tyf6f8EmX10abSt1BQV9tiAc6aq9tpx
o/F+ULFeobdd35nVqZ77lmMayX7YXwVdTPqmnkCJm37M5gfqAb2VMxDdkgx8WPzv
QhC46ChKqEMZHW6WPsEfoxRRaAhcFohjS0C5EzjGX1bODmiOXMvdMlTrkDF51042
XzqAkA+M8FLm6Wk7842L4rk0SKhyp2k6gMVUtZ1qRjkqfPpL//KgfOWsEvkhVnXZ
Wb2LvnxJxMOecli9iOTz/LXc28PPEVcx982EmR338uKKdbHJdwdKmFvvfTsymlk=
=zUBw
-----END PGP SIGNATURE-----

--MnLPg7ZWsaic7Fhd--
