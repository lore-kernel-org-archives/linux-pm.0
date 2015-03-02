From: Eduardo Valentin <edubezval@gmail.com>
Subject: [GIT PULL] Thermal management updates for v4.0-rc2
Date: Sun, 1 Mar 2015 22:38:59 -0400
Message-ID: <20150302023857.GB8925@developer.hsd1.ca.comcast.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="SUOF0GtieIMvvwua"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f42.google.com ([209.85.220.42]:36695 "EHLO
	mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752693AbbCBCjF (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sun, 1 Mar 2015 21:39:05 -0500
Content-Disposition: inline
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>, Rui Zhang <rui.zhang@intel.com>
Cc: Linux PM <linux-pm@vger.kernel.org>, Linux ACPI <linux-acpi@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>


--SUOF0GtieIMvvwua
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello Linus,

Please pull from

  git://git.kernel.org/pub/scm/linux/kernel/git/evalenti/linux-soc-thermal.git fixes-for-4.0-rc2

to receive Thermal Management updates for v4.0-rc2 with top-most

5912e264d9eec512598d8faf33440630a3aee989:

  Merge branch 'tmon-fixes' of .git into next (2015-02-28 14:07:03 +0800)

on top of commit c517d838eb7d07bbe9507871fab3931deccff539:

  Linux 4.0-rc1 (2015-02-22 18:21:14 -0800)

Specifics:
- Several fixes in tmon tool.
- Fixes in intel int340x for _ART and _TRT tables.
- Add id for Avoton SoC into powerclamp driver.
- Fixes in RCAR thermal driver to remove race conditions and fix fail path
- Fixes in TI thermal driver: removal of unnecessary code and build fix if !CONFIG_PM_SLEEP
- Cleanups in exynos thermal driver
- Add stubs for include/linux/thermal.h. Now drivers using thermal calls but that also work
without CONFIG_THERMAL will be able to compile for systems that don't care about thermal.

Note: I am sending this pull on Rui's behalf while he fixes issues in
his Linux box.

BR,

Eduardo Valentin
----------------------------------------------------------------
Brian Norris (8):
      tools/thermal: tmon: add --target-temp parameter
      tools/thermal: tmon: add min/max macros
      tools/thermal: tmon: tui: don't hard-code dialog window size assumptions
      tools/thermal: tmon: fixup tui windowing calculations
      tools/thermal: tmon: add .gitignore
      tools/thermal: tmon: support cross-compiling
      tools/thermal: tmon: use pkg-config to determine library dependencies
      tools/thermal: tmon: silence 'set but not used' warnings

Chanwoo Choi (1):
      thermal: exynos: Clean-up code to use oneline entry for exynos compatible table

Geert Uytterhoeven (2):
      thermal: rcar: Fix race condition between init and interrupt
      thermal: rcar: Make error and remove paths symmetrical with init

Grygorii Strashko (1):
      thermal: ti-soc-thermal: bandgap: Fix build warning if !CONFIG_PM_SLEEP

Markus Elfring (1):
      ti-soc-thermal: Delete an unnecessary check before the function call "cpufreq_cooling_unregister"

Miguel Bernal Marin (1):
      thermal/intel_powerclamp: add id for Avoton SoC

Nishanth Menon (1):
      thermal: Introduce dummy functions when thermal is not defined

Srinivas Pandruvada (1):
      thermal: int340x_thermal: Ignore missing _ART, _TRT tables

Zhang Rui (1):
      Merge branch 'tmon-fixes' of .git into next

 drivers/thermal/int340x_thermal/int3400_thermal.c  | 10 ++--
 drivers/thermal/intel_powerclamp.c                 |  1 +
 drivers/thermal/rcar_thermal.c                     | 26 +++++-----
 drivers/thermal/samsung/exynos_tmu.c               | 38 ++++-----------
 drivers/thermal/ti-soc-thermal/ti-bandgap.c        |  2 +-
 drivers/thermal/ti-soc-thermal/ti-thermal-common.c |  2 +-
 include/linux/thermal.h                            | 56 +++++++++++++++++++++-
 tools/thermal/tmon/.gitignore                      |  1 +
 tools/thermal/tmon/Makefile                        | 15 ++++--
 tools/thermal/tmon/tmon.8                          |  2 +
 tools/thermal/tmon/tmon.c                          | 14 +++++-
 tools/thermal/tmon/tui.c                           | 45 +++++++++++++----
 12 files changed, 145 insertions(+), 67 deletions(-)
 create mode 100644 tools/thermal/tmon/.gitignore

--SUOF0GtieIMvvwua
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJU8802AAoJEMLUO4d9pOJWxp8H/iEbvLfLBLLT8yeOrtToGYcX
f96LL9yn/OyW8alFMv5ht/ZvnH4/ws7FREWG5W3qDM0OLFYCTgqUPdFXAgsVvcwf
uiuwrJ9VNiM34Hve5j9EeT7KQcYPaQbwFqzrUBBt/zAVAyNIEN9CbFxguPbM+1Us
12fYYF0tNNfyAMVzulhOtEUcMuruNgQoXZjXysMPWh10nNCIJGU05QtHwSXQE2PW
6RmI0UdO7c+3I9RG0PZug8u6tQ8zPZkouGAkYAziPhCVf+kXv+cokUWX3AXfQ+7j
i5mPpOIKj7yt+IgIVHuNasEwH35tMCgagMASLL7iRd4oHhq0JM7XnXYrhpTneQo=
=YDyo
-----END PGP SIGNATURE-----

--SUOF0GtieIMvvwua--
