From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: [PATCH v2 0/7] ARM: EXYNOS: cpuidle: fix AFTR mode on boards with
 secure firmware enabled
Date: Mon, 02 Jun 2014 14:35:36 +0200
Message-ID: <1401712543-14281-1-git-send-email-b.zolnierkie@samsung.com>
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Kukjin Kim <kgene.kim@samsung.com>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>, Tomasz Figa <t.figa@samsung.com>, Sachin Kamat <sachin.kamat@linaro.org>, Viresh Kumar <viresh.kumar@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Kyungmin Park <kyungmin.park@samsung.com>, linux-samsung-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linaro-kernel@lists.linaro.org, b.zolnierkie@samsung.com
List-Id: linux-pm@vger.kernel.org

Hi,

This patch series fixes support for AFTR idle mode on boards with
secure firmware enabled (it also includes fix for register setup on
EXYNOS4x12 SoCs).  It has been tested on Trats2 target but should
also work on (EXYNOS4412 based) Insignal Origen board.

v2:
- synced against next-20140602
- added missing Acked-by-s

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics


Bartlomiej Zolnierkiewicz (5):
  ARM: EXYNOS: add AFTR mode support to firmware do_idle method
  ARM: EXYNOS: PM: replace EXYNOS_BOOT_VECTOR_* macros by static inlines
  ARM: EXYNOS: PM: use c15resume firmware method if secure firmware is
    enabled
  ARM: EXYNOS: PM: fix register setup on EXYNOS4x12 for AFTR mode code
  ARM: EXYNOS: cpuidle: add secure firmware support to AFTR mode code

Kyungmin Park (1):
  arm: firmware: Check firmware is running or not

Tomasz Figa (1):
  ARM: EXYNOS: add support for firmware-assisted c15resume

 arch/arm/common/firmware.c       |  5 +++++
 arch/arm/include/asm/firmware.h  | 14 +++++++++++++-
 arch/arm/mach-exynos/firmware.c  | 18 ++++++++++++++++--
 arch/arm/mach-exynos/pm.c        | 40 ++++++++++++++++++++++++++++++++--------
 drivers/cpuidle/cpuidle-exynos.c |  7 ++++++-
 5 files changed, 72 insertions(+), 12 deletions(-)

-- 
1.8.2.3
