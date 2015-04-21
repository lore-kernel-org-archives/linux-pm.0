From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: [PATCH v2 0/8] cpufreq: add generic cpufreq driver support for
 Exynos5250/5800 platforms
Date: Tue, 21 Apr 2015 17:48:57 +0200
Message-ID: <1429631345-16409-1-git-send-email-b.zolnierkie@samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Thomas Abraham <thomas.ab@samsung.com>, Sylwester Nawrocki <s.nawrocki@samsung.com>, Mike Turquette <mturquette@linaro.org>, Kukjin Kim <kgene.kim@samsung.com>, Kukjin Kim <kgene@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>
Cc: Tomasz Figa <tomasz.figa@gmail.com>, Lukasz Majewski <l.majewski@samsung.com>, Heiko Stuebner <heiko@sntech.de>, Chanwoo Choi <cw00.choi@samsung.com>, Kevin Hilman <khilman@linaro.org>, Javier Martinez Canillas <javier.martinez@collabora.co.uk>, linux-samsung-soc@vger.kernel.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, b.zolnierkie@samsung.com
List-Id: linux-pm@vger.kernel.org

Hi,

This patch series adds generic arm_big_little_dt cpufreq driver
support for Exynos5420/5800 (using the new CPU clock type which
allows it).  It also:
- enhances arm_big_little[_dt] driver with CPU cluster regulator
  support
- fixes CPU clock configuration data and CPU operating points
  setup for Exynos5800
- adds CPU cluster regulator supplies for ODROID-XU3 board

This patch series has been tested on Exynos5800 based ODROID-XU3
board.

Depends on:
- next-20150330 branch of linux-next kernel tree
- "[PATCH 0/6] cpufreq: use generic cpufreq drivers for Exynos4210
  platform" [1]
- "[PATCH 0/6] cpufreq: use generic cpufreq drivers for Exynos4x12
  platform" [2]
- "[PATCH] cpufreq: exynos: remove dead ->need_apll_change method" [3]
- "[PATCH 0/4] cpufreq: use generic cpufreq drivers for Exynos5250
  platform" [4]

[1] http://www.kernelhub.org/?msg=721136&p=2
[2] http://marc.info/?l=linux-pm&m=142868881101873&w=2
[3] https://lkml.org/lkml/2015/3/27/574
[4] https://lkml.org/lkml/2015/4/13/611

Changes over Thomas' original v12 code:
- split Exynos5420 and Exynos5800 support
- moved E5420_[EGL,KFC]_DIV0() macros to clk-exynos5420.c
- disabled cpufreq if big.LITTLE switcher support is enabled
- enhanced arm_big_little[_dt] driver with CPU cluster regulator
  support
- fixed CPU clock configuration data for Exynos5800
- fixed CPU operating points setup for Exynos5800
- added CPU cluster regulator supplies for ODROID-XU3 board

Changes since v1:
- added CPU cluster regulator supply properties to
  exynos5420-arndale-octa.dts, exynos5420-peach-pit.dts,
  exynos5420-smdk5420.dts and exynos5800-peach-pi.dts

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics


Bartlomiej Zolnierkiewicz (4):
  cpufreq: arm_big_little: add cluster regulator support
  ARM: dts: Exynos5420/5800: add cluster regulator supply properties
  clk: samsung: exynos5800: fix cpu clock configuration data
  ARM: dts: Exynos5800: fix CPU OPP

Thomas Abraham (4):
  clk: samsung: exynos5420: add cpu clock configuration data and
    instantiate cpu clock
  ARM: dts: Exynos5420: add CPU OPP and regulator supply property
  ARM: Exynos: use generic cpufreq driver for Exynos5420
  ARM: Exynos: use generic cpufreq driver for Exynos5800

 .../bindings/cpufreq/arm_big_little_dt.txt         |    4 +
 arch/arm/boot/dts/exynos5420-arndale-octa.dts      |    8 +
 arch/arm/boot/dts/exynos5420-peach-pit.dts         |    8 +
 arch/arm/boot/dts/exynos5420-smdk5420.dts          |    8 +
 arch/arm/boot/dts/exynos5420.dtsi                  |   38 +++++
 arch/arm/boot/dts/exynos5422-odroidxu3.dts         |    8 +
 arch/arm/boot/dts/exynos5800-peach-pi.dts          |    8 +
 arch/arm/boot/dts/exynos5800.dtsi                  |   39 +++++
 arch/arm/mach-exynos/exynos.c                      |    8 +
 drivers/clk/samsung/clk-exynos5420.c               |   88 ++++++++++-
 drivers/cpufreq/arm_big_little.c                   |  153 +++++++++++++++++---
 include/dt-bindings/clock/exynos5420.h             |    2 +
 12 files changed, 352 insertions(+), 20 deletions(-)

-- 
1.7.9.5
