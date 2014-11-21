From: Thomas Abraham <thomas.ab@samsung.com>
Subject: [PATCH v12 0/6] cpufreq: use generic cpufreq drivers for exynos
 platforms
Date: Fri, 21 Nov 2014 19:01:16 +0530
Message-ID: <1416576682-5255-1-git-send-email-thomas.ab@samsung.com>
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, s.nawrocki@samsung.com
Cc: linux-samsung-soc@vger.kernel.org, mturquette@linaro.org, kgene.kim@samsung.com, tomasz.figa@gmail.com, l.majewski@samsung.com, viresh.kumar@linaro.org, thomas.ab@samsung.com, heiko@sntech.de, cw00.choi@samsung.com, khilman@linaro.org
List-Id: linux-pm@vger.kernel.org

Changes since v11:
- Rebased on top of git://linuxtv.org/snawrocki/samsung.git for-v3.19-exynos-clk

This patch series removes the use of Exynos4210 and Exynos5250 specific cpufreq
drivers and enables the use of cpufreq-dt driver for these platforms. This
series also enables cpufreq support for Exynos5420 using arm_big_little cpufreq
driver.

This series is based on the following branch.
git://linuxtv.org/snawrocki/samsung.git for-v3.19-exynos-clk

This series depends on the following patch which can be picked from
git://git.kernel.org/pub/scm/linux/kernel/git/arm/arm-soc.git samsung/dt
e540920cf21c (ARM: dts: add CPU nodes for Exynos4 SoCs).

This patch series has been tested on Exynos4210/5250/5420 based boards.
Tomasz Figa had plans to take this in the Samsung clock tree for v3.19
(http://www.spinics.net/lists/linux-samsung-soc/msg37933.html).
Sylwester, could you consider to merge this in your tree?

Thomas Abraham (6):
  clk: samsung: add infrastructure to register cpu clocks
  clk: samsung: add cpu clock configuration data and instantiate cpu clock
  ARM: dts: Exynos: add CPU OPP and regulator supply property
  ARM: Exynos: switch to using generic cpufreq driver for Exynos4210/5250/5420
  cpufreq: exynos: remove exynos4210/5250 specific cpufreq driver support
  clk: samsung: remove unused clock aliases and update clock flags

 arch/arm/boot/dts/exynos4210-origen.dts         |    4 +
 arch/arm/boot/dts/exynos4210-trats.dts          |    4 +
 arch/arm/boot/dts/exynos4210-universal_c210.dts |    4 +
 arch/arm/boot/dts/exynos4210.dtsi               |   14 ++-
 arch/arm/boot/dts/exynos5250-arndale.dts        |    4 +
 arch/arm/boot/dts/exynos5250-smdk5250.dts       |    4 +
 arch/arm/boot/dts/exynos5250-snow.dts           |    4 +
 arch/arm/boot/dts/exynos5250.dtsi               |   25 +++-
 arch/arm/boot/dts/exynos5420.dtsi               |   38 ++++
 arch/arm/mach-exynos/exynos.c                   |   26 +++-
 drivers/clk/samsung/Makefile                    |    2 +-
 drivers/clk/samsung/clk-exynos4.c               |   63 +++++---
 drivers/clk/samsung/clk-exynos5250.c            |   44 ++++-
 drivers/clk/samsung/clk-exynos5420.c            |   72 +++++++-
 drivers/cpufreq/Kconfig.arm                     |   22 ---
 drivers/cpufreq/Makefile                        |    2 -
 drivers/cpufreq/exynos4210-cpufreq.c            |  184 --------------------
 drivers/cpufreq/exynos5250-cpufreq.c            |  210 -----------------------
 include/dt-bindings/clock/exynos5250.h          |    1 +
 include/dt-bindings/clock/exynos5420.h          |    2 +
 20 files changed, 266 insertions(+), 463 deletions(-)
 delete mode 100644 drivers/cpufreq/exynos4210-cpufreq.c
 delete mode 100644 drivers/cpufreq/exynos5250-cpufreq.c
