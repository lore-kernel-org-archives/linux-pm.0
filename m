From: Marek Szyprowski <m.szyprowski@samsung.com>
Subject: [PATCH 0/5] Add runtime PM support for clocks (on Exynos SoC example)
Date: Thu, 01 Sep 2016 15:45:46 +0200
Message-ID: <1472737551-15272-1-git-send-email-m.szyprowski@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-clk@vger.kernel.org, linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@codeaurora.org>, Krzysztof Kozlowski <k.kozlowski@samsung.com>, Inki Dae <inki.dae@samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>, Sylwester Nawrocki <s.nawrocki@samsung.com>, Marek Szyprowski <m.szyprowski@samsung.com>
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
https://git.linaro.org/people/marek.szyprowski/linux-srpol.git v4.8-clocks-pm

Patches are based on vanilla v4.8-rc4 kernel.

Best regards
Marek Szyprowski
Samsung R&D Institute Poland

Marek Szyprowski (5):
  clk: add support for runtime pm
  clock: samsung: add support for runtime pm
  clocks: exynos4x12: add runtime pm support for ISP clocks
  ARM: dts: exynos: add support for ISP power domain to exynos4x12
    clocks device
  clocks: exynos5433: add runtime pm support

 .../devicetree/bindings/clock/exynos4-clock.txt    |  22 +
 arch/arm/boot/dts/exynos4x12.dtsi                  |   5 +
 drivers/clk/clk.c                                  |  84 +++-
 drivers/clk/samsung/clk-exynos4.c                  | 228 +++++++---
 drivers/clk/samsung/clk-exynos5433.c               | 462 ++++++++++++++++-----
 drivers/clk/samsung/clk-pll.c                      |   2 +-
 drivers/clk/samsung/clk.c                          |  12 +-
 drivers/clk/samsung/clk.h                          |   1 +
 8 files changed, 641 insertions(+), 175 deletions(-)

-- 
1.9.1
