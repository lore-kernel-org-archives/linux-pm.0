From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: [PATCH v2 0/7] cpufreq: use generic cpufreq drivers for Exynos4x12
 platform
Date: Thu, 09 Jul 2015 17:43:34 +0200
Message-ID: <1436456621-29839-1-git-send-email-b.zolnierkie@samsung.com>
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Thomas Abraham <thomas.ab@samsung.com>, Sylwester Nawrocki <s.nawrocki@samsung.com>, Michael Turquette <mturquette@baylibre.com>, Kukjin Kim <kgene.kim@samsung.com>, Kukjin Kim <kgene@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, Krzysztof Kozlowski <k.kozlowski@samsung.com>
Cc: Tomasz Figa <tomasz.figa@gmail.com>, Lukasz Majewski <l.majewski@samsung.com>, Heiko Stuebner <heiko@sntech.de>, Chanwoo Choi <cw00.choi@samsung.com>, Kevin Hilman <khilman@linaro.org>, Javier Martinez Canillas <javier@dowhile0.org>, Tobias Jakobi <tjakobi@math.uni-bielefeld.de>, Anand Moon <linux.amoon@gmail.com>, linux-samsung-soc@vger.kernel.org, linux-clk@vger.kernel.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, b.zolnierkie@samsung.com
List-Id: linux-pm@vger.kernel.org

Hi,

This patch series removes the use of Exynos4x12 specific support
from cpufreq-exynos driver and enables the use of cpufreq-dt driver
for this platform.

In order to preserve support for Exynos4x12 'boost' mode cpufreq-dt
driver is made aware of cpufreq 'boost' mode infrastructure.  Once
it is done (+ turbo modes handling is fixed, please see below for
details) the driver starts to use turbo mode frequencies (defined
using opp-v2 bindings) as 'boost' mode frequecies.

Patches #1-2 are needed to fix handling of turbo modes in cpufreq
core and without them cpufreq-dt treats turbo modes as normal modes
(IOW they are used by default as normal modes even if they are defined
in DTS file as turbo modes).  Ideally these patches should be added
into "[PATCH 00/10] OPP: Add code to support operating-points-v2
bindings" patch series before patch #10 ("[PATCH 10/10] cpufreq-dt:
Add support for operating-points-v2 bindings").

This patch series has been tested on Exynos4412 based Odroid-U3 and
Trats2 boards.

Depends on:
- next-20150629 branch of linux-next kernel tree
- "[PATCH v3 0/4] cpufreq: use generic cpufreq drivers for Exynos5250
  platform" (http://lkml.org/lkml/2015/7/1/311)
- "PATCH 00/10] OPP: Add code to support operating-points-v2 bindings"
  (http://www.spinics.net/lists/arm-kernel/msg425517.html)

Changes since v1
(http://thread.gmane.org/gmane.linux.kernel.samsung-soc/44361):
- rebased on top of next-20150629 branch of linux-next kernel tree
- rebased on top of Exynos5250 cpufreq-dt support patch series
- fixed if-statement in exynos4_clk_init() (noticed by Tobias Jakobi)
- ported over opp-v2 bindings (requested by Viresh Kumar)

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics


Bartlomiej Zolnierkiewicz (7):
  opp: add dev_pm_opp_get_turbo_mode_setting() helper
  cpufreq: opp: fix handling of turbo modes
  cpufreq-dt: add turbo modes support
  clk: samsung: exynos4x12: add cpu clock configuration data and
    instantiate cpu clock
  ARM: dts: Exynos4x12: add CPU OPP and regulator supply property
  ARM: Exynos: switch to using generic cpufreq driver for Exynos4x12
  cpufreq: exynos: remove Exynos4x12 specific cpufreq driver support

 arch/arm/boot/dts/exynos4212.dtsi               |  81 ++++++++
 arch/arm/boot/dts/exynos4412-odroid-common.dtsi |   4 +
 arch/arm/boot/dts/exynos4412-origen.dts         |   5 +
 arch/arm/boot/dts/exynos4412-trats2.dts         |   5 +
 arch/arm/boot/dts/exynos4412.dtsi               |  83 +++++++++
 arch/arm/mach-exynos/exynos.c                   |  14 ++
 drivers/base/power/opp.c                        |  31 ++++
 drivers/clk/samsung/clk-exynos4.c               |  50 +++++
 drivers/cpufreq/Kconfig.arm                     |  25 +--
 drivers/cpufreq/Makefile                        |   2 -
 drivers/cpufreq/cpufreq-dt.c                    |   7 +-
 drivers/cpufreq/cpufreq_opp.c                   |   2 +
 drivers/cpufreq/exynos-cpufreq.c                | 234 -----------------------
 drivers/cpufreq/exynos-cpufreq.h                |  72 --------
 drivers/cpufreq/exynos4x12-cpufreq.c            | 236 ------------------------
 include/linux/cpufreq-dt.h                      |   1 +
 include/linux/pm_opp.h                          |   7 +
 17 files changed, 290 insertions(+), 569 deletions(-)
 delete mode 100644 drivers/cpufreq/exynos-cpufreq.c
 delete mode 100644 drivers/cpufreq/exynos-cpufreq.h
 delete mode 100644 drivers/cpufreq/exynos4x12-cpufreq.c

-- 
1.9.1
