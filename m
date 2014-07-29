From: Thomas Abraham <thomas.ab@samsung.com>
Subject: [PATCH v8 0/6] cpufreq: use generic cpufreq drivers for exynos
 platforms
Date: Tue, 29 Jul 2014 10:58:25 +0530
Message-ID: <1406611711-25112-1-git-send-email-thomas.ab@samsung.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:18476 "EHLO
	mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751114AbaG2Fbq (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 29 Jul 2014 01:31:46 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: linux-samsung-soc@vger.kernel.org, mturquette@linaro.org, kgene.kim@samsung.com, t.figa@samsung.com, l.majewski@samsung.com, viresh.kumar@linaro.org, thomas.ab@samsung.com, heiko@sntech.de, cw00.choi@samsung.com

Changes since v7:
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

Since there are significant changes since v7, the Tested-by and Acked-by tags
for all the patches in this series have been dropped.

Thomas Abraham (6):
  clk: samsung: add infrastructure to register cpu clocks
  clk: samsung: add cpu clock configuration data and instantiate cpu clock
  ARM: dts: Exynos: add CPU OPP and regulator supply property
  ARM: Exynos: switch to using generic cpufreq driver for Exynos4210/5250/5420
  cpufreq: exynos: remove exynos4210/5250 specific cpufreq driver support
  clk: samsung: remove unused clock aliases and update clock flags

 arch/arm/boot/dts/exynos4210-origen.dts         |    6 +
 arch/arm/boot/dts/exynos4210-trats.dts          |    6 +
 arch/arm/boot/dts/exynos4210-universal_c210.dts |    6 +
 arch/arm/boot/dts/exynos4210.dtsi               |   12 +
 arch/arm/boot/dts/exynos5250-arndale.dts        |    6 +
 arch/arm/boot/dts/exynos5250-cros-common.dtsi   |    6 +
 arch/arm/boot/dts/exynos5250-smdk5250.dts       |    6 +
 arch/arm/boot/dts/exynos5250.dtsi               |   23 ++
 arch/arm/boot/dts/exynos5420-smdk5420.dts       |    6 +
 arch/arm/boot/dts/exynos5420.dtsi               |   38 +++
 arch/arm/mach-exynos/exynos.c                   |   24 +-
 drivers/clk/samsung/Makefile                    |    2 +-
 drivers/clk/samsung/clk-cpu.c                   |  335 +++++++++++++++++++++++
 drivers/clk/samsung/clk-cpu.h                   |   91 ++++++
 drivers/clk/samsung/clk-exynos4.c               |   59 ++--
 drivers/clk/samsung/clk-exynos5250.c            |   44 ++-
 drivers/clk/samsung/clk-exynos5420.c            |   72 ++++-
 drivers/cpufreq/Kconfig.arm                     |   22 --
 drivers/cpufreq/Makefile                        |    2 -
 drivers/cpufreq/exynos4210-cpufreq.c            |  184 -------------
 drivers/cpufreq/exynos5250-cpufreq.c            |  210 --------------
 include/dt-bindings/clock/exynos5250.h          |    1 +
 include/dt-bindings/clock/exynos5420.h          |    2 +
 23 files changed, 707 insertions(+), 456 deletions(-)
 create mode 100644 drivers/clk/samsung/clk-cpu.c
 create mode 100644 drivers/clk/samsung/clk-cpu.h
 delete mode 100644 drivers/cpufreq/exynos4210-cpufreq.c
 delete mode 100644 drivers/cpufreq/exynos5250-cpufreq.c


