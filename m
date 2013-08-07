From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH 0/6] Tegra: Use cpufreq-cpu0 driver
Date: Wed,  7 Aug 2013 20:16:42 +0530
Message-ID: <cover.1375886595.git.viresh.kumar@linaro.org>
Return-path: <cpufreq-owner@vger.kernel.org>
Sender: cpufreq-owner@vger.kernel.org
To: rjw@sisk.pl, swarren@nvidia.com
Cc: linaro-kernel@lists.linaro.org, patches@linaro.org, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, mturquette@linaro.org, linux-arm-kernel@lists.infradead.org, Viresh Kumar <viresh.kumar@linaro.org>
List-Id: linux-pm@vger.kernel.org

Hi Stephen,

This is the first attempt to get rid of tegra-cpufreq driver. This patchset
tries to add supporting infrastructure for tegra to use cpufreq-cpu0 driver.

I don't have hardware to test it and so is compiled tested only.. Few bits may
be missing as I couldn't think of all aspects and so may need your help getting
them fixed.

Once this is tested by you, I would like to take it through my ARM cpufreq tree
if nobody else has a problem with it.

Thanks

--
Viresh.

Viresh Kumar (6):
  clk: Tegra: Add CPU0 clock driver
  ARM: Tegra: Add CPU's OPPs for using cpufreq-cpu0 driver
  ARM: Tegra: Enable OPP library
  ARM: Tegra: defconfig: select cpufreq-cpu0 driver
  ARM: Tegra: start using cpufreq-cpu0 driver
  cpufreq: Tegra: Remove tegra-cpufreq driver

 arch/arm/boot/dts/tegra114.dtsi  |  12 ++
 arch/arm/boot/dts/tegra20.dtsi   |  12 ++
 arch/arm/boot/dts/tegra30.dtsi   |  12 ++
 arch/arm/configs/tegra_defconfig |   1 +
 arch/arm/mach-tegra/Kconfig      |   2 +
 arch/arm/mach-tegra/tegra.c      |   2 +
 drivers/clk/tegra/Makefile       |   1 +
 drivers/clk/tegra/clk-cpu.c      | 164 ++++++++++++++++++++++
 drivers/clk/tegra/clk-tegra30.c  |   4 +
 drivers/cpufreq/Kconfig.arm      |   8 --
 drivers/cpufreq/Makefile         |   1 -
 drivers/cpufreq/tegra-cpufreq.c  | 291 ---------------------------------------
 include/linux/clk/tegra.h        |   1 +
 13 files changed, 211 insertions(+), 300 deletions(-)
 create mode 100644 drivers/clk/tegra/clk-cpu.c
 delete mode 100644 drivers/cpufreq/tegra-cpufreq.c

-- 
1.7.12.rc2.18.g61b472e

