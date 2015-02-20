From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: [PATCH 0/5] cpuidle: exynos: add coupled cpuidle support for Exynos3250
Date: Fri, 20 Feb 2015 17:22:16 +0100
Message-ID: <1424449341-7782-1-git-send-email-b.zolnierkie@samsung.com>
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Kukjin Kim <kgene.kim@samsung.com>
Cc: Kukjin Kim <kgene@kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, Tomasz Figa <tomasz.figa@gmail.com>, Colin Cross <ccross@google.com>, Krzysztof Kozlowski <k.kozlowski@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, Marek Szyprowski <m.szyprowski@samsung.com>, linux-samsung-soc@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, b.zolnierkie@samsung.com
List-Id: linux-pm@vger.kernel.org

Hi,

The following patchset adds coupled cpuidle support for Exynos3250
to an existing cpuidle-exynos driver.  As a result it enables AFTR
mode to be used by default on Exynos3250 without the need to hot
unplug CPU1 first.

The patchset depends on:
- for-next branch (commit: aeb011501873) of linux-samsung.git
  kernel tree
- "[PATCH] ARM: EXYNOS: Fix failed second suspend on Exynos4"
  (https://lkml.org/lkml/2015/2/3/481)
- "[PATCH v2 0/4] ARM: EXYNOS: cpuidle: add AFTR mode support for
  Exynos3250"
  (https://lkml.org/lkml/2015/1/30/345)

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics


Bartlomiej Zolnierkiewicz (5):
  ARM: EXYNOS: fix exynos_boot_secondary() return value on timeout
  ARM: EXYNOS: make exynos_core_restart() less verbose
  ARM: EXYNOS: add exynos_set_boot_addr() helper
  ARM: EXYNOS: add exynos_get_boot_addr() helper
  cpuidle: exynos: add coupled cpuidle support for Exynos3250

 arch/arm/include/asm/firmware.h  |  4 ++
 arch/arm/mach-exynos/common.h    |  4 +-
 arch/arm/mach-exynos/exynos.c    |  3 +-
 arch/arm/mach-exynos/firmware.c  | 18 +++++++++
 arch/arm/mach-exynos/platsmp.c   | 86 +++++++++++++++++++++++++++-------------
 arch/arm/mach-exynos/pm.c        | 51 ++++++++++++++++++++----
 drivers/cpuidle/cpuidle-exynos.c |  3 +-
 7 files changed, 131 insertions(+), 38 deletions(-)

-- 
1.8.2.3
