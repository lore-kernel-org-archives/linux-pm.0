From: Eduardo Valentin <edubezval@gmail.com>
Subject: [GIT PULL] Thermal SoC management updates for v4.0-rc2
Date: Wed, 25 Feb 2015 15:32:13 -0400
Message-ID: <20150225193210.GB2983@developer.amazonguestwifi.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="mxv5cy4qt+RJ9ypb"
Return-path: <linux-acpi-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
To: Rui Zhang <rui.zhang@intel.com>
Cc: Linux ACPI <linux-acpi@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org


--mxv5cy4qt+RJ9ypb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello Rui,

Please pull from

  git://git.kernel.org/pub/scm/linux/kernel/git/evalenti/linux-soc-thermal.git fixes

to receive Thermal SoC Management updates for v4.0-rc2 with top-most

b71d399c7f2fe06b60b96155ec0b9ae167334e4a:

  thermal: exynos: Clean-up code to use oneline entry for exynos compatible table (2015-02-24 15:00:00 -0400)

on top of commit c517d838eb7d07bbe9507871fab3931deccff539:

  Linux 4.0-rc1 (2015-02-22 18:21:14 -0800)

Specifics:
- Fixes in RCAR thermal driver to remove race conditions and fix fail path
- Fixes in TI thermal driver: removal of unnecessary code and build fix if !CONFIG_PM_SLEEP
- Cleanups in exynos thermal driver
- Add stubs for include/linux/thermal.h. Now drivers using thermal calls but that also work
without CONFIG_THERMAL will be able to compile for systems that don't care about thermal.

BR,

Eduardo Valentin
----------------------------------------------------------------
Chanwoo Choi (1):
      thermal: exynos: Clean-up code to use oneline entry for exynos compatible table

Geert Uytterhoeven (2):
      thermal: rcar: Fix race condition between init and interrupt
      thermal: rcar: Make error and remove paths symmetrical with init

Grygorii Strashko (1):
      thermal: ti-soc-thermal: bandgap: Fix build warning if !CONFIG_PM_SLEEP

Markus Elfring (1):
      ti-soc-thermal: Delete an unnecessary check before the function call "cpufreq_cooling_unregister"

Nishanth Menon (1):
      thermal: Introduce dummy functions when thermal is not defined

 drivers/thermal/rcar_thermal.c                     | 26 +++++-----
 drivers/thermal/samsung/exynos_tmu.c               | 38 ++++-----------
 drivers/thermal/ti-soc-thermal/ti-bandgap.c        |  2 +-
 drivers/thermal/ti-soc-thermal/ti-thermal-common.c |  2 +-
 include/linux/thermal.h                            | 56 +++++++++++++++++++++-
 5 files changed, 77 insertions(+), 47 deletions(-)

--mxv5cy4qt+RJ9ypb
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJU7iMwAAoJEMLUO4d9pOJWaAIH/RgEPnvdTLC7G4UAB6zMJZlx
67HONdWFuegCesi5MWI9q936VxjP6nbxT2nZkyEYAWRzRgqwEik/cb+lP06ofZpE
UwCLrvB79QY0AjFJcxq9eGN7zXoBOaj6QL1rGoVpWTchQpO7msIgbMsN+nfSHJhS
VCWV2waQ1bd2Jrd/9LCIqyxiJyfUg4G7mUZY4gHc9SFXeF5IOpX6eCzfhps9T43e
GyReMKKFB98DSqB4BAHTiP3YbZLBLP8qMd16nDAnbL+fxtaN/+hLGYdmsMqdwVIB
e26XvexccO3cTv5tBrMo5iOKc1DbFdlFjrCLo70YklnkUbJESZOkpCQhD7qdAzo=
=Ovud
-----END PGP SIGNATURE-----

--mxv5cy4qt+RJ9ypb--
