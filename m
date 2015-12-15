From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: [PATCH v6 0/7] cpufreq: add generic cpufreq driver support for
 Exynos542x/5800 platforms
Date: Tue, 15 Dec 2015 18:33:14 +0100
Message-ID: <1450200801-24539-1-git-send-email-b.zolnierkie@samsung.com>
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Thomas Abraham <thomas.ab@samsung.com>, Sylwester Nawrocki <s.nawrocki@samsung.com>, Mike Turquette <mturquette@baylibre.com>, Kukjin Kim <kgene.kim@samsung.com>, Kukjin Kim <kgene@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, Krzysztof Kozlowski <k.kozlowski@samsung.com>, Ben Gamari <ben@smart-cactus.org>
Cc: Tomasz Figa <tomasz.figa@gmail.com>, Lukasz Majewski <l.majewski@samsung.com>, Heiko Stuebner <heiko@sntech.de>, Chanwoo Choi <cw00.choi@samsung.com>, Kevin Hilman <khilman@linaro.org>, Javier Martinez Canillas <javier@osg.samsung.com>, Tobias Jakobi <tjakobi@math.uni-bielefeld.de>, Anand Moon <linux.amoon@gmail.com>, linux-samsung-soc@vger.kernel.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, b.zolnierkie@samsung.com
List-Id: linux-pm@vger.kernel.org

Hi,

This patch series adds generic cpufreq-dt driver support for
Exynos542x/5800 (using the new CPU clock type which allows it).

It has been tested on Exynos5422 based ODROID-XU3 Lite board.

Depends on:
- next-20151211 branch of linux-next kernel tree
- "[PATCH] ARM: dts: Make CPU configuration more readable for
  exynos542x/5800" patch (https://lkml.org/lkml/2015/12/11/107)

Changes since v5:
- rebased over next-20151211 branch (something is broken in
  newer branches, namely next-2015121[45])
- rebased on top of "ARM: dts: Make CPU configuration more
  readable for exynos542x/5800" patch
- renamed cpu0_opp_table to cluster_a15_opp_table and
  cpu1_opp_table to cluster_a7_opp_table
- added Reviewed-by from Krzysztof

Changes since v4:
- renamed oppXX@hz to opp@hz
- put Odroid changes in exynos5422-odroidxu3-common.dtsi
- override CPU OPP properties for Exynos5422/5800 instead of
  duplicating them
- merged "ARM: dts: Exynos5422: fix OPP tables" patch with
  "ARM: dts: Exynos5420: add CPU OPP properties" one
- added missing Thomas' SoB line to "ARM: dts: Exynos5420:
  add CPU OPP properties" patch
- updated authorship of "ARM: Exynos: use generic cpufreq
  driver for Exynos5420" and "ARM: Exynos: use generic
  cpufreq driver for Exynos5422/5800" patches
- updated Javier's and Mike's e-mail adresses
- removed non-working e-mail address of Sachin Kamat

Changes since v3:
- switched to using cpufreq-dt driver
- updated patch descriptions to cover Exynos5422 support
- added Acked-by from Sylwester to clock driver patches

Changes since v2:
- ported over next-20151124 branch
- integrated missing CLK_RECALC_NEW_RATES flags fix to patch #3
  (from Anand Moon)
- added regulator supply properties for ODROID-XU3 Lite and
  ODROID-XU4 in patch #2
- ported CPU OPPs to operating-points-v2 (from Ben Gamari)
- added "ARM: dts: Exynos5422: fix OPP tables" patch (from Ben
  Gamari)
- added "cpufreq: arm-big-little: accept operating-points-v2
  nodes" patch (from Ben Gamari)
- renamed OPP nodes as opp@<opp-hz>

Changes since v1:
- added CPU cluster regulator supply properties to
  exynos5420-arndale-octa.dts, exynos5420-peach-pit.dts,
  exynos5420-smdk5420.dts and exynos5800-peach-pi.dts

Changes over Thomas' original v12 code:
- split Exynos5420 and Exynos5800 support
- moved E5420_[EGL,KFC]_DIV0() macros to clk-exynos5420.c
- disabled cpufreq if big.LITTLE switcher support is enabled
- enhanced arm_big_little[_dt] driver with CPU cluster regulator
  support
- fixed CPU clock configuration data for Exynos5800
- fixed CPU operating points setup for Exynos5800
- added CPU cluster regulator supplies for ODROID-XU3 board

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics


Bartlomiej Zolnierkiewicz (5):
  ARM: dts: Exynos542x/5800: add cluster regulator supply properties
  ARM: Exynos: use generic cpufreq driver for Exynos5420
  clk: samsung: exynos5422/5800: fix cpu clock configuration data
  ARM: dts: Exynos5800: fix CPU OPP
  ARM: Exynos: use generic cpufreq driver for Exynos5422/5800

Thomas Abraham (2):
  clk: samsung: exynos5420: add cpu clock configuration data and
    instantiate cpu clock
  ARM: dts: Exynos542x/5800: add CPU OPP properties

 arch/arm/boot/dts/exynos5420-arndale-octa.dts      |   8 ++
 arch/arm/boot/dts/exynos5420-cpus.dtsi             |  10 ++
 arch/arm/boot/dts/exynos5420-peach-pit.dts         |   8 ++
 arch/arm/boot/dts/exynos5420-smdk5420.dts          |   8 ++
 arch/arm/boot/dts/exynos5420.dtsi                  | 110 +++++++++++++++++++++
 arch/arm/boot/dts/exynos5422-cpus.dtsi             |  10 ++
 arch/arm/boot/dts/exynos5422-odroidxu3-common.dtsi |   8 ++
 arch/arm/boot/dts/exynos5800-peach-pi.dts          |   8 ++
 arch/arm/boot/dts/exynos5800.dtsi                  | 108 ++++++++++++++++++++
 arch/arm/mach-exynos/exynos.c                      |   4 +
 drivers/clk/samsung/clk-exynos5420.c               |  88 ++++++++++++++++-
 include/dt-bindings/clock/exynos5420.h             |   2 +
 12 files changed, 370 insertions(+), 2 deletions(-)

-- 
1.9.1
