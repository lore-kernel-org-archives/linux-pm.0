From: MyungJoo Ham <myungjoo.ham@samsung.com>
Subject: [PULL REQUEST for Rafael] PM / devfreq: pull request (resend)
Date: Mon, 03 Jun 2013 20:26:14 +0900
Message-ID: <1370258774-10248-1-git-send-email-myungjoo.ham@samsung.com>
References: <1370257695-9585-1-git-send-email-myungjoo.ham@samsung.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:38676 "EHLO
	mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755703Ab3FCLZz (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 3 Jun 2013 07:25:55 -0400
Received: from epcpsbgr3.samsung.com
 (u143.gpu120.samsung.co.kr [203.254.230.143])
 by mailout4.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0MNT00AOBEF0TV30@mailout4.samsung.com> for
 linux-pm@vger.kernel.org; Mon, 03 Jun 2013 20:25:53 +0900 (KST)
In-reply-to: <1370257695-9585-1-git-send-email-myungjoo.ham@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>, linux-pm@vger.kernel.org
Cc: Abhilash Kesavan <a.kesavan@samsung.com>, myungjoo.ham@gmail.com

Hello Rafael,


Sorry for sending a pull-request again.

I've just rebased the tree from rc3 to rc4.


Thank you.


Cheers,
MyungJoo

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

The following changes since commit d683b96b072dc4680fc74964eca77e6a23d1fa6e:

  Linux 3.10-rc4 (2013-06-02 17:11:17 +0900)

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

iQIcBAEBAgAGBQJRrHzWAAoJEBOhurvWBoCKA0sP/20iLz6TbNcyf71Lrwd4HGyt
bbbJvdJkw3iVQM/viVlhj220i1cBAOhwY7NPJ8B2PvDBGbCJx5xwgGclhWRoL5a9
ZNuvtvIfT1mUsYIz6YUxzJ1tCCTHyK0URQ7HfZLAiQf2APeX27MmoU0g/7FPfkvc
j2xyrEKohtP79c4vLvNLxUGUeRU3qYn3u7P0QGhBSlTYV2BJBBHV75How2VFbltZ
hb2eZvW63NGxHIompkHny76uQCIIoa9x2msvtG9AMa5Scmjw6qGUazDAYosTRCEB
wgyrHlyA5Ft5j81Z/lFB7JxVj40xQSUosi1f2Rw92FkDq8VCSLZFJ+JCZ4eOESNI
Kjkz2oa5kt0XAFRfFXRaxBdFXAfubnkokBOx3b+Rghm3/qqHoNtcN04YDTYM6mze
+SCRHlAXuQ08RS7KW6/1phCa0Nxayhxd641BZW5JOkbpfKWl95Li6FkpwRdSHBKg
f2E+HzTr04Xj96fg3oXwmlH/iezNOFPJXNxp7y4yex/7V6Rqa5FXGrpdww6fzZwW
eqUKIFMIQA4FcimgA0hFP6s7GOs6EuUQjOr/cFNYoalSrPMtzlW1F6owvancPY8F
kasckk9DPpDLNsbDKtL/x1o5EkcgC8i10TJfGe8xzWE3t5Pzk+/+oN+Q8Bol92OE
vBdG7hdQHo0eaGPqGXVd
=/HFe
-----END PGP SIGNATURE-----
