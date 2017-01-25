From: Marek Szyprowski <m.szyprowski@samsung.com>
Subject: [PATCH v5 0/4] Add runtime PM support for clocks (on Exynos SoC
 example)
Date: Wed, 25 Jan 2017 12:53:10 +0100
Message-ID: <1485345194-3196-1-git-send-email-m.szyprowski@samsung.com>
References: <CGME20170125115327eucas1p172866fa87417f59f1dea60185d6d8b60@eucas1p1.samsung.com>
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: linux-clk@vger.kernel.org, linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Marek Szyprowski <m.szyprowski@samsung.com>, Stephen Boyd <sboyd@codeaurora.org>, Michael Turquette <mturquette@baylibre.com>, Ulf Hansson <ulf.hansson@linaro.org>, Sylwester Nawrocki <s.nawrocki@samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>, Inki Dae <inki.dae@samsung.com>, Krzysztof Kozlowski <krzk@kernel.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
List-Id: linux-pm@vger.kernel.org

Dear All,

This patchset adds runtime PM support to common clock framework. This is an
attempt to implement support for clock controllers, which belongs to a power
domain. This approach works surprisingly well on Exynos 5433 SoC, what allowed
us to solve various freeze/crash issues related to power management.

The main idea behind this patchset is to keep clock's controller power domain
enabled every time when at least one of its clock is enabled or access to its
registers is being made. Clock controller driver (clock provider) can
supply a struct device pointer, which is the used by clock core for tracking and
managing clock's controller runtime pm state. Each clk_prepare() operation will
first call pm_runtime_get_sync() on the supplied device, while clk_unprepare()
will do pm_runtime_put() at the end.

This runtime PM feature has been tested with Exynos4412 (not included in this
patchset) and Exynos5433 clocks drivers. Both have some clocks, which belongs to
respective power domains and need special handling during power on/off
procedures. Till now it wasn't handled at all, what caused various problems.

Patches for clocks drivers change the way the clock provider is initialized.
Instead of CLK_OF_DECLARE based initialization, a complete platform device driver
infrastructure is being used. This is needed to let driver to use runtime PM
feature and integrate with generic power domains. The side-effect of this change
is a delay in clock provider registeration during system boot, so early
initialized drivers might get EPROBEDEFER error when requesting their clocks.
This is an issue for IOMMU drivers, so this patchset will be fully functional
once the deferred probe for IOMMU will be merged. v7 of the IOMMU deferred probe
support has been posted two days ago:
https://www.spinics.net/lists/arm-kernel/msg557110.html

Patches are based on linux-next from 25th January 2017.

This is a part of a larger task, which goal is to add support for power
domains on Exynos5433 SoCs / TM2 boards. All patches needed to get it
working have been pushed to the following git repo:
https://git.linaro.org/people/marek.szyprowski/linux-srpol.git v4.10-next-tm2-pd

Best regards
Marek Szyprowski
Samsung R&D Institute Poland


Changelog:

v5:
- rebased onto next-20170125 kernel release
- added two more calls to runtime PM in clock's core:
	1. clk_recalc() should ensure active runtime pm state, because it might
	   read registers (in case of dividers) to calculate the rate
	2. clk_register() also needs to ensure active runtime pm state to read
	   initial rate and status of the clocks
- more fixes in Exynos5433 clocks drivers:
	1. PLL in DISP CMU must be enabled for suspend
	2. guard clocks registration with pm_runtime_get_sync/pm_runtime_put to
	   avoid turning the power domain on and off many times for no good
	   reason (registering each clock will call pm_runtime_get_sync(), then
	   pm_runtime_put, what in turn might disable power domain)
- still waiting for a review...

v4: http://www.spinics.net/lists/arm-kernel/msg550747.html
- Removed patch for Exynos4412 clocks from the patchset. DT bindings for power
  domain for ISP sub-controller needs more discussion. It will be handled
  separately when the runtime PM for clocks feature gets merged.
- Added patch with runtime PM support for Exynos AudioSS clock controller driver
  (needed to enable audio power domain on Exynos5 series).
- Fixes in Exynos5433 driver:
	1. added missing clock for Audio CMU
	2. added support for FSYS CMU
	3. improved support for DISP CMU (thanks to Andrzej Hajda for
	   investigating that).
- Rebased onto v4.10-rc1
- Waiting for a review...

v3: http://www.spinics.net/lists/arm-kernel/msg538122.html
- Removed CLK_RUNTIME_PM flag, core now simply checks if runtime pm is enabled
  for the provided device during clock registration as suggested by Ulf
- Simplified code for exynos4412 isp clock driver registration
- Resolved some other minor issues pointed by Ulf clk core code
- Rebased onto v4.9-rc1 and new version of IOMMU deferred probe patchset

v2: https://www.spinics.net/lists/arm-kernel/msg532798.html
- Simplified clk_pm_runtime_get/put functions, removed workaround for devices
  with disabled runtime pm. Such workaround is no longer needed since commit
  4d23a5e84806b202d9231929c9507ef7cf7a0185 ("PM / Domains: Allow runtime PM
  during system PM phases").
- Added CLK_RUNTIME_PM flag to indicate clocks, for which clock core should
  call runtime pm functions. This solves problem with clocks, for which struct
  device is already registered, but no runtime pm is enabled.
- Extended commit messages according to Ulf suggestions.
- Fixed some style issues pointed by Barlomiej.

v1: http://www.spinics.net/lists/arm-kernel/msg528128.html
- initial version


Patch summary:

Marek Szyprowski (4):
  clk: Add support for runtime PM
  clk: samsung: Add support for runtime PM
  clk: samsung: exynos5433: Add runtime PM support
  clk: samsung: exynos-audss: Use runtime PM

 .../devicetree/bindings/clock/clk-exynos-audss.txt |   6 +
 .../devicetree/bindings/clock/exynos5433-clock.txt |  16 +
 drivers/clk/clk.c                                  | 132 ++++++-
 drivers/clk/samsung/clk-exynos-audss.c             |  62 +--
 drivers/clk/samsung/clk-exynos5433.c               | 422 ++++++++++++++++-----
 drivers/clk/samsung/clk-pll.c                      |   2 +-
 drivers/clk/samsung/clk.c                          |  12 +-
 drivers/clk/samsung/clk.h                          |   7 +
 8 files changed, 527 insertions(+), 132 deletions(-)

-- 
1.9.1
