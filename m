From: Eduardo Valentin <edubezval@gmail.com>
Subject: [GIT PULL] Thermal management updates for v4.0-rc3
Date: Thu, 5 Mar 2015 08:53:48 -0400
Message-ID: <20150305125346.GA26869@developer.amazonguestwifi.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="PEIAKu/WMn1b1Hv9"
Return-path: <linux-acpi-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>, Rui Zhang <rui.zhang@intel.com>
Cc: Linux PM <linux-pm@vger.kernel.org>, Linux ACPI <linux-acpi@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org


--PEIAKu/WMn1b1Hv9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello Linus,

Please pull from

  git://git.kernel.org/pub/scm/linux/kernel/git/evalenti/linux-soc-thermal fixes

to receive Thermal Management updates for v4.0-rc3 with top-most

2dc10f8963e6a03a1a75deafe1d1984bafab08dd:

  thermal: Make sysfs attributes of cooling devices default attributes (2015-03-05 01:47:57 -0400)

on top of commit 023a6007a08d342b64895a7342e426d12d9627dd:

  Merge tag 'gpio-v4.0-2' of git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-gpio (2015-03-02 14:13:39 -0800)

Specifics:
- adding Lukasz as maintainer of samsung thermal driver.
- driver fixes: exynos and int430x.
- one fix in the exynos cpufreq driver related to cpu cooling (acked by cpufreq maintainer).
- fix default sysfs attributes of cooling devices

Note: I am sending this pull on Rui's behalf while he fixes issues in his Linux box.

BR,

Eduardo Valentin
----------------------------------------------------------------
Chanwoo Choi (1):
      thermal: exynos: Fix wrong control of power down detection mode for Exynos7

Eduardo Valentin (1):
      Merge branch 'fixes' of github.com:lmajewski/linux-samsung-thermal into work-fixes

Lukasz Majewski (2):
      cpufreq: exynos: Use simple approach to asses if cpu cooling can be used
      MAINTAINERS: Add entry for SAMSUNG THERMAL DRIVER

Matthias Kaehlcke (1):
      thermal: Make sysfs attributes of cooling devices default attributes

Srinivas Pandruvada (1):
      Thermal/int340x: Fix memleak for aux trip

 MAINTAINERS                                        |  8 +++++
 drivers/cpufreq/exynos-cpufreq.c                   | 21 ++++--------
 .../thermal/int340x_thermal/int340x_thermal_zone.c | 10 +++---
 drivers/thermal/samsung/exynos_tmu.c               |  3 +-
 drivers/thermal/thermal_core.c                     | 37 ++++++++++------------
 5 files changed, 39 insertions(+), 40 deletions(-)

--PEIAKu/WMn1b1Hv9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJU+FHHAAoJEMLUO4d9pOJWRw8H/j4l04F4+22bI+Gt4DgHmWGu
YiXqJE0Ze2QH8TpGx5f4eKPhKLgniNW4dsarj6ze7OGyZGDxACW1Zk1BgN/jmn1O
uisQ4Kd73vW+e0/ZHc2wMXXXXSk8YrPVFmoziwm7RLYlplzt6gbsi8bd2OR36ML4
BgkyOsXpXjxVEsrHOy08heGxURWR2sVB1QIW1zs7cLezf5mYehcfan98XuBdtEsj
9xfE5uAPKdRqLpV+g6AzBcahAQUY3gJn2K6Ggsj307uffRpe8MWttJ8REviH2Z42
Iygq7sAD9aNV9bGA6KC+q3+zR9JFYk0ZAhFthge6UAXjQW7ASxzjma0gc6GdaZk=
=UcKR
-----END PGP SIGNATURE-----

--PEIAKu/WMn1b1Hv9--
