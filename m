From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: [PATCH 0/4] ARM: EXYNOS: cpuidle: add AFTR mode support for Exynos3250
Date: Thu, 20 Nov 2014 16:11:45 +0100
Message-ID: <1416496309-27602-1-git-send-email-b.zolnierkie@samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Kukjin Kim <kgene.kim@samsung.com>, Kukjin Kim <kgene@kernel.org>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>, Tomasz Figa <tomasz.figa@gmail.com>, Kyungmin Park <kyungmin.park@samsung.com>, linux-samsung-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, b.zolnierkie@samsung.com
List-Id: linux-pm@vger.kernel.org

Hi,

This patch series adds support for AFTR idle mode on boards with
Exynos3250 SoC and allows EXYNOS cpuidle driver usage on these
boards.

It has been tested on Samsung Rinato board (Gear 2).

Depends on:
- for-next branch of linux-samsung.git kernel tree
  (or next-20141114 branch of linux-next kernel tree)
- [PATCH v5] ARM: EXYNOS: add Exynos3250 PMU support
  (https://www.mail-archive.com/linux-samsung-soc@vger.kernel.org/msg39109.html)

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics


Bartlomiej Zolnierkiewicz (4):
  ARM: EXYNOS: fix CPU1 hotplug for AFTR mode on Exynos3250
  ARM: EXYNOS: add code for setting/clearing boot flag
  ARM: EXYNOS: cpuidle: add AFTR mode support for Exynos3250
  ARM: EXYNOS: cpuidle: allow driver usage on Exynos3250 SoC

 arch/arm/mach-exynos/common.h   |  6 ++++++
 arch/arm/mach-exynos/exynos.c   | 26 ++++++++++++++++++++++++++
 arch/arm/mach-exynos/firmware.c |  8 +++++++-
 arch/arm/mach-exynos/platsmp.c  | 19 +++++++++++++++++--
 arch/arm/mach-exynos/pm.c       | 12 +++++++++++-
 arch/arm/mach-exynos/regs-pmu.h |  2 ++
 arch/arm/mach-exynos/smc.h      |  9 +++++++++
 7 files changed, 78 insertions(+), 4 deletions(-)

-- 
1.8.2.3
