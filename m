From: MyungJoo Ham <myungjoo.ham@samsung.com>
Subject: [PULL REQUEST for Rafael] PM / devfreq: pull request
Date: Tue, 26 Feb 2013 19:27:21 +0900
Message-ID: <1361874441-370-1-git-send-email-myungjoo.ham@samsung.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:38437 "EHLO
	mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755004Ab3BZK0z (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 26 Feb 2013 05:26:55 -0500
Received: from epcpsbgr2.samsung.com
 (u142.gpu120.samsung.co.kr [203.254.230.142])
 by mailout1.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0MIT00DFTP0TS931@mailout1.samsung.com> for
 linux-pm@vger.kernel.org; Tue, 26 Feb 2013 19:26:54 +0900 (KST)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rafael.j.wysocki@intel.com
Cc: linux-pm@vger.kernel.org, yongjun_wei@trendmicro.com.cn, nm@ti.com, rajagopal.venkat@linaro.org, a.kesavan@samsung.com, myungjoo.ham@gmail.com, myungjoo.ham@samsung.com

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

The following changes since commit 19f949f52599ba7c3f67a5897ac6be14bfcb1200:

  Linux 3.8 (2013-02-18 15:58:34 -0800)

are available in the git repository at:
  git://git.kernel.org/pub/scm/linux/kernel/git/mzx/devfreq.git for-rafael

Abhilash Kesavan (2):
      PM / devfreq: Move exynos4 devfreq driver into a new sub-directory
      PM / devfreq: Add Exynos5-bus devfreq driver for Exynos5250

MyungJoo Ham (1):
      PM / devfreq: add comments and Documentation

Rajagopal Venkat (1):
      PM / devfreq: account suspend/resume for stats

Wei Yongjun (1):
      PM / devfreq: fix missing unlock on error in exynos4_busfreq_pm_notifier_event()

 Documentation/ABI/testing/sysfs-class-devfreq |   20 +
 drivers/devfreq/Kconfig                       |   10 +
 drivers/devfreq/Makefile                      |    3 +-
 drivers/devfreq/devfreq.c                     |   25 ++-
 drivers/devfreq/exynos/Makefile               |    3 +
 drivers/devfreq/{ => exynos}/exynos4_bus.c    |    1 +
 drivers/devfreq/exynos/exynos5_bus.c          |  503 +++++++++++++++++++++++++
 drivers/devfreq/exynos/exynos_ppmu.c          |   56 +++
 drivers/devfreq/exynos/exynos_ppmu.h          |   78 ++++
 include/linux/devfreq.h                       |    2 +
 10 files changed, 697 insertions(+), 4 deletions(-)
 create mode 100644 drivers/devfreq/exynos/Makefile
 rename drivers/devfreq/{ => exynos}/exynos4_bus.c (99%)
 create mode 100644 drivers/devfreq/exynos/exynos5_bus.c
 create mode 100644 drivers/devfreq/exynos/exynos_ppmu.c
 create mode 100644 drivers/devfreq/exynos/exynos_ppmu.h
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJRLIzeAAoJEBOhurvWBoCKWroP/2bAUWTJ73XhbnJcDoVnr+gV
9ZaDjD0MGEjTN5iDpKdhXludvzcVEwqyX/JHBH58kXIPaWi6CZPaiST/6bQP7LHh
SWgyyiTkVNGeHJi2eGgupUY8dsWCtub4vaJznPukgLR5ug/TZk1ltMzT56pBPsWu
kwUl6XHvcwJtzgUjkydnEC97ruhobrgbDQFUJdmT6sJHFrHGWEAVudW+zVYoXN9z
JQT+w6NXxr7DXLbT3SNDH6G722LJ/h8oyDB7wzNQOLJUcjv3+lEWYut0jYO0Lxfa
V51strELYI1FooMuUsM0FCOBp7uftDVUdtA3pRMZKpAqzesFEv72ofE9V+E/Ehh0
84TJJefuvrSmstvVDH00m0SCcWoIUZ03g2kaUh4vG/CkyrcUF3LLXx1aUW8Bvnej
SwZDOMsJb9AGADA2chL9m1QFgCpM5Tarc4xU8G6AV+j8NVC/8LO6YS2iGlDzI1Ry
xTJFtngjnHdwlehepdU0HxrdYZ8fx+UYiRAs18XzQ0mCPL4XcNS8QbPB4dEfbpvE
wYYUAe5kFjIuSaRqJBjIwaVfSeNj8gTwOTp+ewKhKKvQPq3c4i6FTLi+/vRIzOqg
+VzcNkn+Fa54e1XxL4y6Bvca+hIpSgqzl9m4yZMOEG8uhTmscxLO+BRfAuGzu90I
EFo9EJpdGXUl5dO5wAbf
=Eh48
-----END PGP SIGNATURE-----
