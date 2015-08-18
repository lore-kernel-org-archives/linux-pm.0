From: Eduardo Valentin <edubezval@gmail.com>
Subject: [GIT PULL] Last minute fixes on Thermal-SoC for v4.2-rc8
Date: Tue, 18 Aug 2015 16:44:37 -0700
Message-ID: <20150818234436.GB4494@localhost.localdomain>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="3lcZGd9BuhuYXNfi"
Return-path: <linux-acpi-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>, Rui Zhang <rui.zhang@intel.com>
Cc: Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Linux ACPI <linux-acpi@vger.kernel.org>, Russell King <rmk+kernel@arm.linux.org.uk>
List-Id: linux-pm@vger.kernel.org


--3lcZGd9BuhuYXNfi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello Linus,


I have these last minute fixes on the thermal-soc tree. It has gone through
linux-next. There is a fix of a long lasting bug in cpu cooling device,
thanks for RMK for being pushing this.

So, if there is still time, please pull from:

  git://git.kernel.org/pub/scm/linux/kernel/git/evalenti/linux-soc-thermal fixes

to receive Thermal-SoC Management updates for v4.2-rc8 with top-most

1afb9c539daebc2c8a7b33d0e0b8fc9f74671b02:

  thermal/cpu_cooling: update policy limits if clipped_freq < policy->max (2015-08-14 18:26:23 -0700)

on top of commit 7ddab73346a1277b90fd6a4d044bc948f9cc9ad8:

  Merge branch 'fixes' of git://ftp.arm.linux.org.uk/~rmk/linux-arm (2015-08-13 16:34:56 -0700)


Specifics:
- I am sending in behalf of Rui this time, as he does not have any
  further patches.
- Urgent fix: Lockdep fix in the cpu cooling code.
- Refactoring in the cpu cooling code.
- Remove devm* functions from power allocator.

BR,

Eduardo Valentin
----------------------------------------------------------------
Dmitry Torokhov (1):
      thermal: power_allocator: do not use devm* interfaces

Russell King (1):
      thermal: cpu_cooling: fix lockdep problems in cpu_cooling

Viresh Kumar (6):
      thermal/cpu_cooling: No need to initialize max_freq to 0
      thermal/cpu_cooling: quit early after updating policy
      thermal/cpu_cooling: convert 'switch' block to 'if' block in notifier
      thermal/cpu_cooling: rename cpufreq_val as clipped_freq
      thermal/cpu_cooling: rename max_freq as clipped_freq in notifier
      thermal/cpu_cooling: update policy limits if clipped_freq < policy->max

 drivers/thermal/cpu_cooling.c     | 73 +++++++++++++++++++++++----------------
 drivers/thermal/power_allocator.c |  8 ++---
 2 files changed, 48 insertions(+), 33 deletions(-)

--3lcZGd9BuhuYXNfi
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQEcBAEBAgAGBQJV08NWAAoJEMLUO4d9pOJWOGEH/RH60zORt81Ihkzc1BsJbEZB
9iqTs4WGkMr3g6LJHG5cmOkl+CUjQ2t6EbBzDZ1cPrJn0b8DMmeqH6Nn2E9m1SGe
ikXjMvi4nO66cMo3+O4AEv34sLZ5BjcsfsLSO69NZ3Z0FB1uk5tkDVLWTWBYs22W
Tnol96q/N1VMTh53c4L1KHHV1x4CzNWBfe5Zaktbcc5cXU+NzcnDWB5EzQUss8/r
0llWwUFN/VIGGdTy3ialIEg0+UDjG1KHXGOVG2spYo6oixm94rxF4B4KY4eQlrYg
qZlPQdzD7V3eBP6TK3PcTwh+9mNH+xCLFoBq8AK9Ioj0yJgv+1MWmkt95jYlu4k=
=QII+
-----END PGP SIGNATURE-----

--3lcZGd9BuhuYXNfi--
