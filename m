From: MyungJoo Ham <myungjoo.ham@samsung.com>
Subject: [PULL REQUEST for Rafael] PM / devfreq: pull request
Date: Tue, 20 Nov 2012 16:50:50 +0900
Message-ID: <1353397850-21949-1-git-send-email-myungjoo.ham@samsung.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:24697 "EHLO
	mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751534Ab2KTHuz (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 20 Nov 2012 02:50:55 -0500
Received: from epcpsbgm2.samsung.com (epcpsbgm2 [203.254.230.27])
 by mailout3.samsung.com
 (Oracle Communications Messaging Server 7u4-24.01(7.0.4.24.0) 64bit (built Nov
 17 2011)) with ESMTP id <0MDS00K340FFI4P0@mailout3.samsung.com> for
 linux-pm@vger.kernel.org; Tue, 20 Nov 2012 16:50:52 +0900 (KST)
Received: from localhost.localdomain ([10.90.51.65])
 by mmp2.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTPA id <0MDS00AOC0GQ2S80@mmp2.samsung.com> for
 linux-pm@vger.kernel.org; Tue, 20 Nov 2012 16:50:52 +0900 (KST)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rjw@sisk.pl
Cc: linux-pm@vger.kernel.org, myungjoo.ham@gmail.com, myungjoo.ham@samsung.com, nm@ti.com, rajagopal.venkat@linaro.org, kyungmin.park@samsung.com, sh007.yi@samsung.com, jonghwa3.lee@samsung.com, sachin.kamat@linaro.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

The following changes since commit 77b67063bb6bce6d475e910d3b886a606d0d91f7:

  Linux 3.7-rc5 (2012-11-11 13:44:33 +0100)

are available in the git repository at:
  git://git.kernel.org/pub/scm/linux/kernel/git/mzx/devfreq.git tags/pull_req_20121120
, which is based on Rafael's linux-pm.git pm-devfreq.

Jonghwa Lee (1):
      PM / devfreq: Add sysfs node for representing frequency transition information.

Nishanth Menon (12):
      PM / devfreq: kernel-doc typo corrections
      PM / devfreq: fix sscanf handling for writable sysfs entries
      PM / devfreq: make devfreq_class static
      PM / devfreq: documentation cleanups for devfreq header
      PM / devfreq: Add sysfs node to expose available frequencies
      PM / devfreq: export update_devfreq
      PM / devfreq: provide hooks for governors to be registered
      PM / devfreq: register governors with devfreq framework
      PM / devfreq: map devfreq drivers to governor using name
      PM / devfreq: governors: add GPL module license and allow module build
      PM / devfreq: allow sysfs governor node to switch governor
      PM / devfreq: Add sysfs node to expose available governors

Rajagopal Venkat (3):
      PM / devfreq: Core updates to support devices which can idle
      PM / devfreq: Add suspend and resume apis
      PM / devfreq: Add current freq callback in device profile

Sachin Kamat (1):
      PM / devfreq: Use devm_* functions in exynos4_bus.c

Sangho Yi (1):
      PM / devfreq: exynos4_bus.c: Fixed an alignment of the func call args.

 Documentation/ABI/testing/sysfs-class-devfreq |   44 +-
 drivers/devfreq/Kconfig                       |    8 +-
 drivers/devfreq/devfreq.c                     |  885 +++++++++++++++++--------
 drivers/devfreq/exynos4_bus.c                 |   45 +-
 drivers/devfreq/governor.h                    |   17 +
 drivers/devfreq/governor_performance.c        |   38 +-
 drivers/devfreq/governor_powersave.c          |   38 +-
 drivers/devfreq/governor_simpleondemand.c     |   55 ++-
 drivers/devfreq/governor_userspace.c          |   45 ++-
 include/linux/devfreq.h                       |  134 ++--
 10 files changed, 915 insertions(+), 394 deletions(-)
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJQqzYmAAoJEBOhurvWBoCKFHUP/3dM8TjCCbpLCXISig+3qCy9
RLjH18vbWqDNmEfticjPM/t+kbKwnW/opVbpRxwpncHrrA7hUqKOdefs6pyo1/wH
p1xFoZfzHLiQoGMpHeNnAm3ItBO9H/UYqfw+5DWvU2bGZVHs2OAynom3KCKkL6JZ
pkvE33m56cP9kFoa4tI5TmR7cItUj6ShIMj6m/TB2VcbZ//xJ3X1ONk53/5Au3iW
SSW9UM/O2rR+z6Xr1/AvVcy9zuhfhxt5/37GjsYwKHF1J7ZRF40l4+jTG6Nw1geq
a2H2AVNEQrUjU9JmcnarvkFGffcVNmLJDMYBII2DvdLScW7Bx8qfORL0blxLdDcr
LbOkQjA1GAFf3e/ZuKNABL6PM+V/tCay+HrWMC9bEy7yCkhE+4iBx5IRhixhogsm
Qcx8hOpYca1Tmj9v1yXrDcyFPfKqqtXvDoTnX9UgWQKTyYROpJ3Kc/vwWJAJ4CnV
ppk8Ocdl6P2X0E0BelJGpsONrhyyrzMcGEtJBxNhM1NcmiAN037Ym6zAq78BcqHr
O6aLdSQuODY/vUc37Y0Zd6FqSdc4EfPaveJz03Q7x+CQ9NT/yzg06AWAtqbJnDQM
nVf1oPwMve29aK7v7A5ObKl9Tg9/KbOPb/Lycym7fFlEiCN9RbNEcQ2PR1894AvG
NDujl9d0CmYBo7jVlnuw
=zoRw
-----END PGP SIGNATURE-----
