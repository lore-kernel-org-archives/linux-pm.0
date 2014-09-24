From: Bartlomiej Zolnierkiewicz <b.zolnierkie-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Subject: [PATCH v7 0/5] ARM: EXYNOS: cpuidle: fix AFTR mode on boards with
 secure firmware enabled
Date: Wed, 24 Sep 2014 14:24:43 +0200
Message-ID: <1411561488-1739-1-git-send-email-b.zolnierkie@samsung.com>
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Kukjin Kim <kgene.kim-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Cc: Daniel Lezcano <daniel.lezcano-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Tomasz Figa <tomasz.figa-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Sachin Kamat <sachin.kamat-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Viresh Kumar <viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Kyungmin Park <kyungmin.park-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linaro-kernel-cunTk1MwBs8s++Sfvej+rw@public.gmane.org, b.zolnierkie-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org
List-Id: linux-pm@vger.kernel.org

Hi,

This patch series adds support for AFTR idle mode on boards with
secure firmware enabled and allows EXYNOS cpuidle driver usage on
Exynos4x12 SoCs.

It has been tested on Trats2 board (using Exynos4412 SoC with secure
firmware enabled) on which AFTR mode reduces power consumption by ~12%
when EXYNOS cpuidle driver is enabled (in both cases the default
exynos_defconfig config is used and CPU1-3 are offlined).

Currently Exynos4412 SoC support is limited to Trats2 board.

Depends on:
- for-next branch of linux-samsung.git kernel tree
- [PATCH v3 0/5] Firmware-assisted suspend/resume of Exynos SoCs
  (https://www.mail-archive.com/linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org/msg35921.html)

Changes since v6:
- rebased on top of for-next branch of linux-samsung.git kernel tree +
  [PATCH v3 0/5] Firmware-assisted suspend/resume of Exynos SoCs
  (https://www.mail-archive.com/linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org/msg35921.html)
- fixed build on Tegra
- updated patch #2 summary line

Changes since v5:
- rebased on top of next-20140904 +
  "irqchip: Properly fetch the per cpu offset" patch
  (https://www.mail-archive.com/linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org/msg716674.html)
  [PATCH v3 0/5] Firmware-assisted suspend/resume of Exynos SoCs
  (https://www.mail-archive.com/linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org/msg35921.html)
- limit Exynos4412 SoC support to Trats2 board for now

Changes since v4:
- rebased on top of next-20140804 +
  [PATCH v5][next-20140804] ARM: EXYNOS: Fix suspend/resume sequences
  (http://www.mail-archive.com/linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org/msg35262.html)
  [PATCH v2 0/2] Firmware-assisted suspend/resume of Exynos SoCs
  (http://www.mail-archive.com/linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org/msg34282.html)
- call exynos_save_cp15() only on A9 type core (this is needed for the future
  Exynos3250 SoC support)

Changes since v3:
- rebased on top of next-20140804 +
  [PATCH v4][next-20140804] ARM: EXYNOS: Fix suspend/resume sequences
  (http://www.mail-archive.com/linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org/msg35192.html)
  [PATCH v2 0/2] Firmware-assisted suspend/resume of Exynos SoCs
  (http://www.mail-archive.com/linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org/msg34282.html)
- (re-)added patch fixing S5P_CENTRAL_SEQ_OPTION register setup

Changes since v2:
- rebased on top of next-20140708 +
  [PATCH 5/6] ARM: EXYNOS: Fix suspend/resume sequencies
  (http://www.mail-archive.com/linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org/msg32809.html)
  [with rejects fixed]
  [PATCH 6/6] ARM: EXYNOS: Register cpuidle device only on Exynos4210 and 5250
  (http://www.mail-archive.com/linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org/msg32808.html)
  [PATCH 0/2] Firmware-assisted suspend/resume of Exynos SoCs
  (http://www.mail-archive.com/linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org/msg32991.html)
  [with rejects fixed in patch #2]
- addressed review comments from Tomasz Figa and Daniel Lezcano

Changes since v1:
- synced against next-20140602
- added missing Acked-by-s

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics

Bartlomiej Zolnierkiewicz (5):
  ARM: EXYNOS: PM: replace EXYNOS_BOOT_VECTOR_* macros by static inlines
  ARM: add AFTR mode support to firmware do_idle method
  ARM: EXYNOS: cpuidle: add secure firmware support to AFTR mode code
  ARM: EXYNOS: PM: fix register setup for AFTR mode code
  ARM: EXYNOS: cpuidle: allow driver usage on Exynos4x12 SoCs

 arch/arm/include/asm/firmware.h        |  2 +-
 arch/arm/mach-exynos/common.h          |  5 +++
 arch/arm/mach-exynos/exynos.c          |  5 ++-
 arch/arm/mach-exynos/firmware.c        | 34 ++++++++++++++-----
 arch/arm/mach-exynos/pm.c              | 60 ++++++++++++++++++++--------------
 arch/arm/mach-tegra/cpuidle-tegra114.c |  2 +-
 6 files changed, 72 insertions(+), 36 deletions(-)

-- 
1.8.2.3
