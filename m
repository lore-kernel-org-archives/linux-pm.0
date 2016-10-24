From: Marek Szyprowski <m.szyprowski@samsung.com>
Subject: [PATCH v3 0/5] Add runtime PM support for clocks (on Exynos SoC
 example)
Date: Mon, 24 Oct 2016 14:12:05 +0200
Message-ID: <1477311130-6534-1-git-send-email-m.szyprowski@samsung.com>
References: <CGME20161024121224eucas1p1070b72308dc9c8d8d2b10fa5bfeaf5ed@eucas1p1.samsung.com>
Return-path: <linux-clk-owner@vger.kernel.org>
Sender: linux-clk-owner@vger.kernel.org
To: linux-clk@vger.kernel.org, linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Marek Szyprowski <m.szyprowski@samsung.com>, Stephen Boyd <sboyd@codeaurora.org>, Michael Turquette <mturquette@baylibre.com>, Ulf Hansson <ulf.hansson@linaro.org>, Sylwester Nawrocki <s.nawrocki@samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>, Inki Dae <inki.dae@samsung.com>, Krzysztof Kozlowski <krzk@kernel.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
List-Id: linux-pm@vger.kernel.org

Dear All,

This patchset adds runtime PM support to common clock framework. This is an
attempt to implement support for clock controllers, which belongs to a power
domain. This approach works surprisingly well on Exynos 4412 and 5433 SoCs,
what allowed us to solve various freeze/crash issues related to power
management.

The main idea behind this patchset is to keep clock's controller power domain
enabled every time when at least one of its clock is enabled or access to its
registers is being made. Clock controller driver (clock provider) can
supply a struct device pointer, which is the used by clock core for tracking and
managing clock's controller runtime pm state. Each clk_prepare() operation will
first call pm_runtime_get_sync() on the supplied device, while clk_unprepare()
will do pm_runtime_put() at the end.

This runtime PM feature has been tested with Exynos4412 and Exynos5433 clocks
drivers. Both have some clocks, which belongs to respective power domains and
need special handling during power on/off procedures. Till now it wasn't handled
at all, what caused various problems.

Patches for exynos 4412 and 5433 clocks drivers change the way the clock
provider is initialized. Instead of CLK_OF_DECLARE based initialization, a
complete platform device driver infrastructure is being used. This is needed to
let driver to use runtime pm feature and integrate with generic power domains.
The side-effect of this change is a delay in clock provider registeration
during system boot, so early initialized drivers might get EPROBEDEFER error
when requesting their clocks. This is an issue for IOMMU drivers, so
this patchset will be fully functional once the deferred probe for IOMMU
will be merged.

The side-effect of this patchset is the one can finally read
/sys/kernel/debug/clk/clk_summary on all Exynos4412 boards without any freeze.

If one wants to test this patchset (on Exynos4412 Trats2 device with FIMC-IS
driver), I've provided a branch with all needed patches (fixes for Exynos,
FIMC-IS driver and IOMMU deferred probe):
https://git.linaro.org/people/marek.szyprowski/linux-srpol.git v4.9-clocks-pm-v3

Patches are based on vanilla v4.9-rc1 kernel.

Best regards
Marek Szyprowski
Samsung R&D Institute Poland

Changelog:

v3:
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

Marek Szyprowski (5):
  clk: add support for runtime pm
  clock: samsung: add support for runtime pm
  clocks: exynos4x12: add runtime pm support for ISP clocks
  ARM: dts: exynos: add support for ISP power domain to exynos4x12
    clocks device
  clocks: exynos5433: add runtime pm support

 .../devicetree/bindings/clock/exynos4-clock.txt    |  22 ++
 arch/arm/boot/dts/exynos4x12.dtsi                  |   5 +
 drivers/clk/clk.c                                  | 111 +++++-
 drivers/clk/samsung/clk-exynos4.c                  | 211 +++++++----
 drivers/clk/samsung/clk-exynos5433.c               | 390 +++++++++++++++++----
 drivers/clk/samsung/clk-pll.c                      |   2 +-
 drivers/clk/samsung/clk.c                          |  12 +-
 drivers/clk/samsung/clk.h                          |   7 +
 8 files changed, 605 insertions(+), 155 deletions(-)

-- 
1.9.1

