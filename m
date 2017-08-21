From: Marek Szyprowski <m.szyprowski@samsung.com>
Subject: [PATCH v9 0/5] Add runtime PM support for clocks (on Exynos SoC
 example)
Date: Mon, 21 Aug 2017 10:04:58 +0200
Message-ID: <1503302703-13801-1-git-send-email-m.szyprowski@samsung.com>
References: <CGME20170821080538eucas1p1e273ef22920493ee406ef546bcc230e5@eucas1p1.samsung.com>
Return-path: <linux-clk-owner@vger.kernel.org>
Sender: linux-clk-owner@vger.kernel.org
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
This was an issue for IOMMU drivers, but IOMMU deferred probe support has been
finally merged to v4.13-rc1 and now it is handled correctly.

Patches are based and tested on v4.13-rc5, but applies fine also on v4.13-rc1.

Best regards
Marek Szyprowski
Samsung R&D Institute Poland


Changelog:

v9:
- moved pm_runtime_get() call from clk_register() to __clk_core_init() as
  requested by Michael Turquette
- added remaining 'Reviewed-by' tags

v8: https://www.spinics.net/lists/arm-kernel/msg599494.html
- fixed minor issues pointed by Krzysztof Kozlowski and added his 'Reviewed-by'
  tags
- added 'Reviewed-by' and 'Tested-by' tags from Chanwoo Choi
- moved trivial changes in Exynos AudioSS driver to separate patch
- added pm_runtime_get_noresume/pm_runtime_put_sync calls also to exynos-audss
  driver (like it is already done for exynos5433 clocks driver)
- still waiting for any comments from clk maintainers

v7: https://www.spinics.net/lists/arm-kernel/msg598408.html
- rebased onto v4.13-rc3
- still waiting for any comments from clk maintainers

v6: https://patches.linaro.org/cover/95713/
- addressed comments from Ulf Hanson and added his 'Reviewed-by' tags
- simplified exynos 5433 clock driver code a bit
- fixes issues pointed by kbuild test robot

v5: https://www.spinics.net/lists/linux-samsung-soc/msg57718.html
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

Marek Szyprowski (5):
  clk: Add support for runtime PM
  clk: samsung: Add support for runtime PM
  clk: samsung: exynos5433: Add support for runtime PM
  clk: samsung: exynos-audss: Use local variable for controller's device
  clk: samsung: exynos-audss: Add support for runtime PM

 .../devicetree/bindings/clock/clk-exynos-audss.txt |   6 +
 .../devicetree/bindings/clock/exynos5433-clock.txt |  16 +
 drivers/clk/clk.c                                  | 126 ++++++-
 drivers/clk/samsung/clk-exynos-audss.c             |  76 ++--
 drivers/clk/samsung/clk-exynos5433.c               | 409 ++++++++++++++++-----
 drivers/clk/samsung/clk-pll.c                      |   2 +-
 drivers/clk/samsung/clk.c                          |  12 +-
 drivers/clk/samsung/clk.h                          |   7 +
 8 files changed, 519 insertions(+), 135 deletions(-)

-- 
1.9.1
