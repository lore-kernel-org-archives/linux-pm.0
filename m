From: Amit Daniel Kachhap <amit.daniel@samsung.com>
Subject: [PATCH 00/12] soc: samsung: Modify and enhance power domain driver
Date: Mon, 03 Nov 2014 09:22:58 +0530
Message-ID: <1414986790-11940-1-git-send-email-amit.daniel@samsung.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:17541 "EHLO
	mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750706AbaKCD7W (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sun, 2 Nov 2014 22:59:22 -0500
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, linux-pm@vger.kernel.org
Cc: kgene.kim@samsung.com, pankaj.dubey@samsung.com, Amit Daniel Kachhap <amit.daniel@samsung.com>

This patch series[3 - 12] performs several implementations as described below,

1) Converts power domain driver to platform driver.
2) Registers this driver as MFD client driver.
3) Moves them into driver/soc/samsung folder.
4) Add new power domain notifier feature.
5) Uses those notfier from exynos clk.
6) Adds parent power domain and some other features mostly for exynos7 platforms.

This patch will change the DT representation of all the exynos power domain
DT nodes which will be posted as a new patch series.

This patch has dependency on following patches posted earlier and most of them are
already accepted or in final stages of review.
1) http://www.spinics.net/lists/linux-samsung-soc/msg37050.html
2) https://lkml.org/lkml/2014/10/6/581

Patches 1-2 are from Pankaj and have been posted earlier.
(http://lists.infradead.org/pipermail/linux-arm-kernel/2014-July/271555.html
They are kept in this patch series for completeness after rebase fixes.

This complete patch series is rebased on linux-next as it involves many
subsystems.

Amit Daniel Kachhap (10):
  PM / Domains: Add notifier support for power domain transitions
  mfd: exynos-pmu: Register exynos-pmu driver as a mfd driver
  arm: exynos: Add platform driver support for power domain driver
  soc: exynos: Move exynos power domain file to driver/soc/samsung
    folder
  soc: samsung: pm_domain: Use compatible name for power domain name
  soc: samsung: pm_domain: Add a new parameter for power configuration
  soc: samsung: pm_domain: Add support for parent power domain
  soc: samsung: pm_domain: Use the recently added PM Domain notifiers
  clk: samsung: save and restore clock registers for power domain
  arm64: Kconfig: Enable PM_GENERIC_DOMAINS for exynos7

Pankaj Dubey (2):
  ARM: EXYNOS: Move pmu specific header files under "linux/mfd/samsung"
  drivers: mfd: Add support for Exynos PMU driver

 .../bindings/arm/exynos/power_domain.txt           |   21 +++-
 arch/arm/mach-exynos/Kconfig                       |    1 +
 arch/arm/mach-exynos/Makefile                      |    3 +-
 arch/arm/mach-exynos/exynos.c                      |    2 +-
 arch/arm/mach-exynos/mcpm-exynos.c                 |    2 +-
 arch/arm/mach-exynos/platsmp.c                     |    2 +-
 arch/arm/mach-exynos/pm.c                          |    5 +-
 arch/arm/mach-exynos/suspend.c                     |    3 +-
 arch/arm64/Kconfig                                 |    1 +
 drivers/base/power/domain.c                        |  112 +++++++++++++++++-
 drivers/clk/samsung/clk.c                          |   66 +++++++++++
 drivers/clk/samsung/clk.h                          |   14 +++
 drivers/mfd/Kconfig                                |    9 ++
 drivers/mfd/Makefile                               |    1 +
 .../mach-exynos/pmu.c => drivers/mfd/exynos-pmu.c  |   30 ++++-
 drivers/soc/Kconfig                                |    1 +
 drivers/soc/Makefile                               |    1 +
 drivers/soc/samsung/Kconfig                        |   11 ++
 drivers/soc/samsung/Makefile                       |    1 +
 .../soc/samsung}/pm_domains.c                      |  124 ++++++++++++++++----
 .../linux/mfd/samsung}/exynos-pmu.h                |    5 +
 .../linux/mfd/samsung/exynos-regs-pmu.h            |    0
 include/linux/pm_domain.h                          |   31 +++++
 23 files changed, 409 insertions(+), 37 deletions(-)
 rename arch/arm/mach-exynos/pmu.c => drivers/mfd/exynos-pmu.c (96%)
 create mode 100644 drivers/soc/samsung/Kconfig
 create mode 100644 drivers/soc/samsung/Makefile
 rename {arch/arm/mach-exynos => drivers/soc/samsung}/pm_domains.c (51%)
 rename {arch/arm/mach-exynos => include/linux/mfd/samsung}/exynos-pmu.h (86%)
 rename arch/arm/mach-exynos/regs-pmu.h => include/linux/mfd/samsung/exynos-regs-pmu.h (100%)

-- 
1.7.9.5

