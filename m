From: Chanwoo Choi <cw00.choi@samsung.com>
Subject: [PATCHv3 0/8] devfreq: exynos4: Support dt and use common ppmu driver
Date: Fri, 14 Mar 2014 18:30:00 +0900
Message-ID: <1394789408-14648-1-git-send-email-cw00.choi@samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: myungjoo.ham@samsung.com, kyungmin.park@samsung.com
Cc: rafael.j.wysocki@intel.com, nm@ti.com, b.zolnierkie@samsaung.com, pawel.moll@arm.com, mark.rutland@arm.com, swarren@wwwdotorg.org, ijc+devicetree@hellion.org.uk, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org, linux-doc@vger.kernel.org, Chanwoo Choi <cw00.choi@samsung.com>
List-Id: linux-pm@vger.kernel.org

This patchset support devicetree and use common ppmu driver instead of
individual code of exynos4_bus.c to remove duplicate code. Also this patchset
get the resources for busfreq from dt data by using DT helper function.
- PPMU register address
- PPMU clock
- Regulator for INT/MIF block

This patchset use SET_SYSTEM_SLEEP_PM_OPS macro intead of legacy method.
To remove power-leakage in suspend state, before entering suspend state,
disable ppmu clocks.

Changes from v2:
- Add detailed description to Documentation/devicetree/bindings/exynos4_bus.txt
  and change patch description of patch#8
- Change the sequence of patchset in patch #1 ~ #4
- Fix minor issue

Changes from v1:
- Add exynos4_bus.txt documentation for devicetree guide
- Fix probe failure if CONFIG_PM_OPP is disabled
- Fix typo and resource leak(regulator/clock/memory) when happening probe failure
- Add additionally comment for PPMU usage instead of previous PPC
- Split separate patch to remove ambiguous of patch

Chanwoo Choi (8):
  devfreq: exynos4: Fix bug of resource leak and code clean on probe()
  devfreq: exynos4: Support devicetree to get device id of Exynos4 SoC
  devfreq: exynos4: Use common ppmu driver and get ppmu address from dt data
  devfreq: exynos4: Add ppmu's clock control and code clean about regulator control
  devfreq: exynos4: Use SET_SYSTEM_SLEEP_PM_OPS macro
  devfreq: exynos4: Fix power-leakage of clock on suspend state
  devfreq: exynos4: Add CONFIG_PM_OPP dependency to fix probe fail
  Documentation: dt: devfreq: Add device tree binding of Exynos4
    busfreq

 .../devicetree/bindings/devfreq/exynos4_bus.txt    |  50 +++
 drivers/devfreq/Kconfig                            |   1 +
 drivers/devfreq/exynos/Makefile                    |   2 +-
 drivers/devfreq/exynos/exynos4_bus.c               | 415 ++++++++++++++-------
 4 files changed, 342 insertions(+), 126 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/devfreq/exynos4_bus.txt

-- 
1.8.0
