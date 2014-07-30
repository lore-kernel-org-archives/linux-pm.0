From: Thomas Abraham <thomas.ab@samsung.com>
Subject: [PATCH v9 0/6] cpufreq: use generic cpufreq drivers for exynos
 platforms
Date: Wed, 30 Jul 2014 13:37:37 +0530
Message-ID: <1406707663-16656-1-git-send-email-thomas.ab@samsung.com>
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: linux-samsung-soc@vger.kernel.org, mturquette@linaro.org, kgene.kim@samsung.com, t.figa@samsung.com, l.majewski@samsung.com, viresh.kumar@linaro.org, thomas.ab@samsung.com, heiko@sntech.de, cw00.choi@samsung.com
List-Id: linux-pm@vger.kernel.org

Changes since v8:
- Fixes suggested by Tomasz Figa.

This patch series removes the use of Exynos4210 and Exynos5250 specific cpufreq
drivers and enables the use of cpufreq-cpu0 driver for these platforms. This
series also enables cpufreq support for Exynos5420 using arm_big_little cpufreq
driver.

This patch series is dependent on two other patches
1. ARM: dts: add CPU nodes for Exynos4 SoCs
   - https://lkml.org/lkml/2014/7/21/315
2. ARM: dts: smdk5250: Specify MAX77686 pmic interrupt
   - http://www.spinics.net/lists/arm-kernel/msg351134.html
3. clk: exynos4: remove duplicate div_core2 divider clock instantiation
   - http://www.mail-archive.com/linux-samsung-soc@vger.kernel.org/msg34859.html

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
 arch/arm/boot/dts/exynos4210.dtsi               |   14 +-
 arch/arm/boot/dts/exynos5250-arndale.dts        |    4 +
 arch/arm/boot/dts/exynos5250-smdk5250.dts       |    4 +
 arch/arm/boot/dts/exynos5250-snow.dts           |    4 +
 arch/arm/boot/dts/exynos5250.dtsi               |   25 +-
 arch/arm/boot/dts/exynos5420.dtsi               |   38 +++
 arch/arm/mach-exynos/exynos.c                   |   24 +-
 drivers/clk/samsung/Makefile                    |    2 +-
 drivers/clk/samsung/clk-cpu.c                   |  335 +++++++++++++++++++++++
 drivers/clk/samsung/clk-cpu.h                   |   91 ++++++
 drivers/clk/samsung/clk-exynos4.c               |   63 +++--
 drivers/clk/samsung/clk-exynos5250.c            |   44 ++-
 drivers/clk/samsung/clk-exynos5420.c            |   72 ++++-
 drivers/cpufreq/Kconfig.arm                     |   22 --
 drivers/cpufreq/Makefile                        |    2 -
 drivers/cpufreq/exynos4210-cpufreq.c            |  184 -------------
 drivers/cpufreq/exynos5250-cpufreq.c            |  210 --------------
 include/dt-bindings/clock/exynos5250.h          |    1 +
 include/dt-bindings/clock/exynos5420.h          |    2 +
 22 files changed, 690 insertions(+), 463 deletions(-)
 create mode 100644 drivers/clk/samsung/clk-cpu.c
 create mode 100644 drivers/clk/samsung/clk-cpu.h
 delete mode 100644 drivers/cpufreq/exynos4210-cpufreq.c
 delete mode 100644 drivers/cpufreq/exynos5250-cpufreq.c

-- 
1.7.9.5
