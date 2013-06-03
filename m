From: MyungJoo Ham <myungjoo.ham@samsung.com>
Subject: [PULL REQUEST for Rafael] PM / devfreq: pull request
Date: Mon, 03 Jun 2013 20:08:15 +0900
Message-ID: <1370257695-9585-1-git-send-email-myungjoo.ham@samsung.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:8230 "EHLO
	mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753081Ab3FCLH4 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 3 Jun 2013 07:07:56 -0400
Received: from epcpsbgr2.samsung.com
 (u142.gpu120.samsung.co.kr [203.254.230.142])
 by mailout1.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0MNT003NDDL3LZZ0@mailout1.samsung.com> for
 linux-pm@vger.kernel.org; Mon, 03 Jun 2013 20:07:55 +0900 (KST)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>, linux-pm@vger.kernel.org
Cc: Abhilash Kesavan <a.kesavan@samsung.com>, myungjoo.ham@gmail.com

Dear Rafael,


Here goes a set of fixes and driver-addition that were missing.

Thank you.



Cheers,
MyungJoo

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

The following changes since commit e4aa937ec75df0eea0bee03bffa3303ad36c986b:

  Linux 3.10-rc3 (2013-05-26 16:00:47 -0700)

are available in the git repository at:
  git://git.kernel.org/pub/scm/linux/kernel/git/mzx/devfreq.git for-rafael

Abhilash Kesavan (2):
      PM / devfreq: Move exynos4 devfreq driver into a new sub-directory
      PM / devfreq: Add Exynos5-bus devfreq driver for Exynos5250

MyungJoo Ham (2):
      PM / devfreq: add comments and Documentation
      MAINTAINERS: update mailing list for devfreq(DVFS).

Paul Bolle (1):
      PM / devfreq: fix typo "CPU_EXYNOS4.12" twice

Rajagopal Venkat (1):
      PM / devfreq: account suspend/resume for stats

Wei Yongjun (1):
      PM / devfreq: fix missing unlock on error in exynos4_busfreq_pm_notifier_event()

 Documentation/ABI/testing/sysfs-class-devfreq |   20 +
 MAINTAINERS                                   |    2 +-
 drivers/devfreq/Kconfig                       |   12 +-
 drivers/devfreq/Makefile                      |    3 +-
 drivers/devfreq/devfreq.c                     |   25 ++-
 drivers/devfreq/exynos/Makefile               |    3 +
 drivers/devfreq/{ => exynos}/exynos4_bus.c    |    1 +
 drivers/devfreq/exynos/exynos5_bus.c          |  503 +++++++++++++++++++++++++
 drivers/devfreq/exynos/exynos_ppmu.c          |   56 +++
 drivers/devfreq/exynos/exynos_ppmu.h          |   78 ++++
 include/linux/devfreq.h                       |    2 +
 11 files changed, 699 insertions(+), 6 deletions(-)
 create mode 100644 drivers/devfreq/exynos/Makefile
 rename drivers/devfreq/{ => exynos}/exynos4_bus.c (99%)
 create mode 100644 drivers/devfreq/exynos/exynos5_bus.c
 create mode 100644 drivers/devfreq/exynos/exynos_ppmu.c
 create mode 100644 drivers/devfreq/exynos/exynos_ppmu.h
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJRrHgnAAoJEBOhurvWBoCKUCwP/ie2GC/gzPIzZXDmp8hGRWsl
is1NJ01dByECZaxTzFTMD7rVKX7DgWmRaPqgZXHwYdOk62e5rbR7K1qSLnJU4xpv
0jjN6gDRQmk3JuJs4l8Oc7JBLnwiWbCMQ6nM1pWM5JZlIeGcvzbMZqHtUuE8m8LR
ZFIYTXQSxTnvU1LPzHqzGZx6PObLATamXuaCK+FqzsQyc5bnYF/Usjlth0anmpe5
ksx/rAiJP1TcWnmlUKoQ02wPBsq/lA4/4s7rDbgbkA4W+fFrMjyEGyYo8KUaQwpz
/3rhjr7jx8CxxhOhb2e4AoHmL/icK/++dV3QV1rkPD7xMieT9w0BqwMqpMnloCLm
o1X2dpMqbtT3msc/jFMYMn3vp4GJvbp2C6X8QaOdlDrT1AphzQ5b0M+RH+fBgh2U
2Dxx9oVXRJgT4eCEfKXtj+1e6Nup/ClIg2k7x39ZK1QxSKVSPIlzIzzcQbgFdBib
VfPV3z7rwoPiRM7xqvxfe8BnDVZBVgPD2O3TsbOQamXOWBsn6JFbIgqZS36aJ35N
VQhuhZLfpgEBEJLbmBvh9vegBwgGT+X2pAS3SHhRYKcONvMEWmg9Zq4Jj8F6P2qp
00uuiiZbiCJMwRhVq9kL5LfrJOBm4fYtx70/lAWK1ucONoWmFDYr/MVggyioMPMO
sbVOacXZuSGmBDl4Aqg/
=rJqu
-----END PGP SIGNATURE-----
