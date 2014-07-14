From: Thomas Abraham <thomas.ab@samsung.com>
Subject: [PATCH v7 0/6] cpufreq: use generic cpufreq drivers for exynos platforms
Date: Mon, 14 Jul 2014 19:08:32 +0530
Message-ID: <1405345118-4269-1-git-send-email-thomas.ab@samsung.com>
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: linux-samsung-soc@vger.kernel.org, mturquette@linaro.org, kgene.kim@samsung.com, t.figa@samsung.com, l.majewski@samsung.com, viresh.kumar@linaro.org, thomas.ab@samsung.com, heiko@sntech.de, cw00.choi@samsung.com
List-Id: linux-pm@vger.kernel.org

Changes since v6:
- Fixes suggested by Amit Daniel <amit.daniel@samsung.com>.

This patch series removes the use of Exynos4210 and Exynos5250 specific cpufreq
drivers and enables the use of cpufreq-cpu0 driver for these platforms. This
series also enabled cpufreq support for Exynos5420 using arm_big_little cpufreq
driver.

Thomas Abraham (6):
  clk: samsung: add infrastructure to register cpu clocks
  clk: samsung: register exynos5420 apll/kpll configuration data
  clk: exynos: use cpu-clock provider type to represent arm clock
  ARM: dts: Exynos: add cpu nodes, opp and cpu clock configuration data
  ARM: Exynos: switch to using generic cpufreq driver for exynos4210/5250
  cpufreq: exynos: remove exynos4210/5250 specific cpufreq driver support

 arch/arm/boot/dts/exynos4210-origen.dts         |    6 +
 arch/arm/boot/dts/exynos4210-trats.dts          |    6 +
 arch/arm/boot/dts/exynos4210-universal_c210.dts |    6 +
 arch/arm/boot/dts/exynos4210.dtsi               |   27 ++
 arch/arm/boot/dts/exynos5250-arndale.dts        |    6 +
 arch/arm/boot/dts/exynos5250-cros-common.dtsi   |    6 +
 arch/arm/boot/dts/exynos5250-smdk5250.dts       |    6 +
 arch/arm/boot/dts/exynos5250.dtsi               |   23 +
 arch/arm/boot/dts/exynos5420-smdk5420.dts       |    6 +
 arch/arm/boot/dts/exynos5420.dtsi               |   32 ++
 arch/arm/mach-exynos/exynos.c                   |   15 +-
 drivers/clk/samsung/Makefile                    |    2 +-
 drivers/clk/samsung/clk-cpu.c                   |  576 +++++++++++++++++++++++
 drivers/clk/samsung/clk-exynos4.c               |   25 +-
 drivers/clk/samsung/clk-exynos5250.c            |   16 +-
 drivers/clk/samsung/clk-exynos5420.c            |   60 ++-
 drivers/clk/samsung/clk.h                       |    5 +
 drivers/cpufreq/Kconfig.arm                     |   22 -
 drivers/cpufreq/Makefile                        |    2 -
 drivers/cpufreq/exynos4210-cpufreq.c            |  184 --------
 drivers/cpufreq/exynos5250-cpufreq.c            |  210 ---------
 include/dt-bindings/clock/exynos5250.h          |    1 +
 include/dt-bindings/clock/exynos5420.h          |    2 +
 23 files changed, 802 insertions(+), 442 deletions(-)
 create mode 100644 drivers/clk/samsung/clk-cpu.c
 delete mode 100644 drivers/cpufreq/exynos4210-cpufreq.c
 delete mode 100644 drivers/cpufreq/exynos5250-cpufreq.c

-- 
1.7.9.5
