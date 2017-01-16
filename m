From: Marek Szyprowski <m.szyprowski@samsung.com>
Subject: [PATCH 00/12] Move pad retention control to Exynos pin controller
 driver
Date: Mon, 16 Jan 2017 07:44:55 +0100
Message-ID: <1484549107-5957-1-git-send-email-m.szyprowski@samsung.com>
References: <CGME20170116064523eucas1p161a8e060b2883c076fc470ce7b522332@eucas1p1.samsung.com>
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: linux-gpio@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org
Cc: Marek Szyprowski <m.szyprowski@samsung.com>, Sylwester Nawrocki <s.nawrocki@samsung.com>, Krzysztof Kozlowski <krzk@kernel.org>, Linus Walleij <linus.walleij@linaro.org>, Tomasz Figa <tomasz.figa@gmail.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
List-Id: linux-pm@vger.kernel.org

Hello,

This patchset is a follow-up of my work on adding runtime PM support
to Exynos pin controller driver:
http://www.spinics.net/lists/arm-kernel/msg550161.html

Runtime PM support itself needs a bit more discussion, so lets first focus on
the prerequisites.

In case of Exynos pin controller driver it is a pad retention control. In
current code it was handled by machine and PMU code and had no relation to
what pin controller driver does. This patch series moves pad retention
control to pin controller driver. While implmenting it, I also did a little
cleanup of both Exynos PMU and pin controller drivers.

Patches are based on linux-next from 2017.01.16 with Exynos4415 support
removal patch applied: https://lkml.org/lkml/2017/1/14/137


Changelog:

v1:
- removed the need to add PMU phandles to all pin controller nodes, so old DTBs
  are properly supported. This has been achieved by getting PMU regmap from
  the "exynos-pmu" device of fixed name.
- more cleanup in Exynos pin controller driver: added missing entries in DT
  documentation, removed "memory allocation failed" messages and added
  initconst annotations.
- added support for s5pv210.
- reworked retention control code to be simpler and ready for adding Exynos5433
  support.

v0: http://www.spinics.net/lists/arm-kernel/msg550161.html
- initial version
- part of "Runtime PM for Exynos pin controller driver" patchset

Patch summary:

Marek Szyprowski (12):
  soc: samsung: pmu: Use common device name to let others to find it
    easily
  soc: samsung: pmu: Use of_device_get_match_data helper
  soc: samsung: pmu: Remove messages for failed memory allocation
  pinctrl: samsung: Document Exynos3250 SoC support
  pinctrl: samsung: Remove messages for failed memory allocation
  pinctrl: samsung: Add missing initconst annotation
  pinctrl: samsung: Remove dead code
  pinctrl: samsung: Use generic of_device_get_match_data helper
  pinctrl: samsung: Add infrastructure for pin-bank retention control
  pinctrl: samsung: Move retention control from mach-exynos to the
    pinctrl driver
  pinctrl: samsung: Move retention control from mach-s5pv210 to the
    pinctrl driver
  pinctrl: samsung: Replace syscore ops with standard platform device
    pm_ops

 .../bindings/pinctrl/samsung-pinctrl.txt           |   1 +
 arch/arm/mach-exynos/suspend.c                     |  64 ------
 arch/arm/mach-s5pv210/pm.c                         |   7 -
 arch/arm/mach-s5pv210/regs-clock.h                 |   4 -
 drivers/pinctrl/samsung/pinctrl-exynos.c           | 235 +++++++++++++++++++--
 drivers/pinctrl/samsung/pinctrl-s3c64xx.c          |  12 +-
 drivers/pinctrl/samsung/pinctrl-samsung.c          | 122 +++--------
 drivers/pinctrl/samsung/pinctrl-samsung.h          |  42 ++++
 drivers/soc/samsung/exynos-pmu.c                   |  12 +-
 include/linux/soc/samsung/exynos-pmu.h             |  19 ++
 10 files changed, 321 insertions(+), 197 deletions(-)

-- 
1.9.1
