From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: [PATCH 0/8] ARM: move cpuidle drivers to drivers/cpuidle/
Date: Wed, 26 Jun 2013 12:15:39 +0200
Message-ID: <1372241747-21083-1-git-send-email-b.zolnierkie@samsung.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:26668 "EHLO
	mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751853Ab3FZKQN (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 26 Jun 2013 06:16:13 -0400
Received: from epcpsbgm2.samsung.com (epcpsbgm2 [203.254.230.27])
 by mailout1.samsung.com
 (Oracle Communications Messaging Server 7u4-24.01(7.0.4.24.0) 64bit (built Nov
 17 2011)) with ESMTP id <0MOZ002N2WIVQ6V0@mailout1.samsung.com> for
 linux-pm@vger.kernel.org; Wed, 26 Jun 2013 19:16:12 +0900 (KST)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: linux-pm@vger.kernel.org, linux@maxim.org.za, nicolas.ferre@atmel.com, plagnioj@jcrosoft.com, nsekhar@ti.com, khilman@deeprootsystems.com, kernel@pengutronix.de, shawn.guo@linaro.org, tony@atomide.com, ben-linux@fluff.org, kgene.kim@samsung.com, horms@verge.net.au, magnus.damm@gmail.com, swarren@wwwdotorg.org, srinidhi.kasagar@stericsson.com, linus.walleij@linaro.org, daniel.lezcano@linaro.org, rjw@sisk.pl, kyungmin.park@samsung.com, b.zolnierkie@samsung.com

Hi,

This patchset moves ARM cpuidle drivers to drivers/cpuidle/ to make
code match new driver placement rules (per commit a8e39c3 "cpuidle: add
maintainer entry").

[ Please note that movement of Samsung EXYNOS cpuidle driver is handled
  in separate patchset since it needs some other changes applied first. ]

Patches are based on linux-next (next-20130624) and are compile tested
only.  If agreed they all should probably go together through one tree
(linux-pm or arm-soc) since they all modify drivers/cpuidle/Makefile.

PS It seems that majority of cpuidle drivers is not used by default
(CONFIG_CPU_IDLE is not turned on in corresponding defconfigs). The only
exceptions are shmobile (kota2_defconfig) and tegra (tegra_defconfig).
This is probably also something that needs updating.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics


Bartlomiej Zolnierkiewicz (8):
  ARM: at91: move cpuidle driver to drivers/cpuidle/
  ARM: davinci: move cpuidle driver to drivers/cpuidle/
  ARM: imx: move cpuidle drivers to drivers/cpuidle/
  ARM: OMAP: move cpuidle drivers to drivers/cpuidle/
  ARM: S3C64XX: move cpuidle driver to drivers/cpuidle/
  ARM: shmobile: move cpuidle driver to drivers/cpuidle/
  ARM: tegra: move cpuidle drivers to drivers/cpuidle/
  ARM: ux500: move cpuidle drivers to drivers/cpuidle/

 arch/arm/mach-at91/Makefile            |   1 -
 arch/arm/mach-at91/cpuidle.c           |  68 -------
 arch/arm/mach-davinci/Makefile         |   1 -
 arch/arm/mach-davinci/cpuidle.c        | 105 ----------
 arch/arm/mach-imx/Makefile             |   5 -
 arch/arm/mach-imx/cpuidle-imx5.c       |  37 ----
 arch/arm/mach-imx/cpuidle-imx6q.c      |  75 -------
 arch/arm/mach-omap2/Makefile           |   5 -
 arch/arm/mach-omap2/cpuidle34xx.c      | 344 ---------------------------------
 arch/arm/mach-omap2/cpuidle44xx.c      | 217 ---------------------
 arch/arm/mach-s3c64xx/Makefile         |   1 -
 arch/arm/mach-s3c64xx/cpuidle.c        |  63 ------
 arch/arm/mach-shmobile/Makefile        |   1 -
 arch/arm/mach-shmobile/cpuidle.c       |  37 ----
 arch/arm/mach-tegra/Makefile           |   9 -
 arch/arm/mach-tegra/cpuidle-tegra114.c |  35 ----
 arch/arm/mach-tegra/cpuidle-tegra20.c  | 217 ---------------------
 arch/arm/mach-tegra/cpuidle-tegra30.c  | 149 --------------
 arch/arm/mach-ux500/Makefile           |   1 -
 arch/arm/mach-ux500/cpuidle.c          | 128 ------------
 drivers/cpuidle/Makefile               |  42 ++++
 drivers/cpuidle/cpuidle-at91.c         |  68 +++++++
 drivers/cpuidle/cpuidle-davinci.c      | 104 ++++++++++
 drivers/cpuidle/cpuidle-imx5.c         |  37 ++++
 drivers/cpuidle/cpuidle-imx6q.c        |  74 +++++++
 drivers/cpuidle/cpuidle-omap34xx.c     | 342 ++++++++++++++++++++++++++++++++
 drivers/cpuidle/cpuidle-omap44xx.c     | 216 +++++++++++++++++++++
 drivers/cpuidle/cpuidle-s3c64xx.c      |  62 ++++++
 drivers/cpuidle/cpuidle-shmobile.c     |  37 ++++
 drivers/cpuidle/cpuidle-tegra114.c     |  35 ++++
 drivers/cpuidle/cpuidle-tegra20.c      | 217 +++++++++++++++++++++
 drivers/cpuidle/cpuidle-tegra30.c      | 149 ++++++++++++++
 drivers/cpuidle/cpuidle-ux500.c        | 128 ++++++++++++
 33 files changed, 1511 insertions(+), 1499 deletions(-)
 delete mode 100644 arch/arm/mach-at91/cpuidle.c
 delete mode 100644 arch/arm/mach-davinci/cpuidle.c
 delete mode 100644 arch/arm/mach-imx/cpuidle-imx5.c
 delete mode 100644 arch/arm/mach-imx/cpuidle-imx6q.c
 delete mode 100644 arch/arm/mach-omap2/cpuidle34xx.c
 delete mode 100644 arch/arm/mach-omap2/cpuidle44xx.c
 delete mode 100644 arch/arm/mach-s3c64xx/cpuidle.c
 delete mode 100644 arch/arm/mach-shmobile/cpuidle.c
 delete mode 100644 arch/arm/mach-tegra/cpuidle-tegra114.c
 delete mode 100644 arch/arm/mach-tegra/cpuidle-tegra20.c
 delete mode 100644 arch/arm/mach-tegra/cpuidle-tegra30.c
 delete mode 100644 arch/arm/mach-ux500/cpuidle.c
 create mode 100644 drivers/cpuidle/cpuidle-at91.c
 create mode 100644 drivers/cpuidle/cpuidle-davinci.c
 create mode 100644 drivers/cpuidle/cpuidle-imx5.c
 create mode 100644 drivers/cpuidle/cpuidle-imx6q.c
 create mode 100644 drivers/cpuidle/cpuidle-omap34xx.c
 create mode 100644 drivers/cpuidle/cpuidle-omap44xx.c
 create mode 100644 drivers/cpuidle/cpuidle-s3c64xx.c
 create mode 100644 drivers/cpuidle/cpuidle-shmobile.c
 create mode 100644 drivers/cpuidle/cpuidle-tegra114.c
 create mode 100644 drivers/cpuidle/cpuidle-tegra20.c
 create mode 100644 drivers/cpuidle/cpuidle-tegra30.c
 create mode 100644 drivers/cpuidle/cpuidle-ux500.c

-- 
1.8.2.3

