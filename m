From: Mikko Perttunen <mikko.perttunen@kapsi.fi>
Subject: [PATCH v9 00/17] Tegra124 CL-DVFS / DFLL clocksource + cpufreq
Date: Wed, 13 May 2015 17:58:34 +0300
Message-ID: <1431529131-16710-1-git-send-email-mikko.perttunen@kapsi.fi>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: swarren@wwwdotorg.org, thierry.reding@gmail.com, gnurou@gmail.com, pdeschrijver@nvidia.com, rjw@rjwysocki.net, viresh.kumar@linaro.org
Cc: mturquette@linaro.org, pwalmsley@nvidia.com, vinceh@nvidia.com, pgaikwad@nvidia.com, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org, linux-arm-kernel@lists.infradead.org, tuomas.tynkkynen@iki.fi, Mikko Perttunen <mikko.perttunen@kapsi.fi>
List-Id: linux-pm@vger.kernel.org

v9 of the Tegra124 cpufreq series. Changes:

- Dropped PLLX reordering patch since it is no longer needed
- Removed a couple of unused lines from the DFLL clocksource platform driver
- Made the cpufreq driver tristate and removed .owned = THIS_MODULE (as it's not needed for
  platform devices)
- Made the OPP generation code in the CVB parser ignore OPPs where the frequency has the most
  significant bit set. This can be dropped once Boris Brezillon's patch finds its
  way into the tree.
- Added Acks.

The only patches without Acks are the following:
  ARM: tegra: enable Tegra124 cpufreq driver by default
  ARM: tegra: Add CPU regulator to the Jetson TK1 device tree
  ARM: tegra: Add entries for cpufreq on Tegra124
  cpufreq: tegra: Rename tegra-cpufreq to tegra20-cpufreq
  cpufreq: tegra124: Add device tree bindings

These are very minor (4/5 of them are DT patches and the fifth just renames a driver),
so hopefully we can get this merged.

Mikko Perttunen (2):
  clk: tegra: Introduce ability for SoC-specific reset control callbacks
  ARM: tegra: Add CPU regulator to the Jetson TK1 device tree

Paul Walmsley (1):
  clk: tegra: Add DFLL DVCO reset control for Tegra124

Tuomas Tynkkynen (14):
  clk: tegra: Add binding for the Tegra124 DFLL clocksource
  clk: tegra: Add library for the DFLL clock source (open-loop mode)
  clk: tegra: Add closed loop support for the DFLL
  clk: tegra: Add functions for parsing CVB tables
  clk: tegra: Add Tegra124 DFLL clocksource platform driver
  clk: tegra: Save/restore CCLKG_BURST_POLICY on suspend
  clk: tegra: Add the DFLL as a possible parent of the cclk_g clock
  ARM: tegra: Add the DFLL to Tegra124 device tree
  ARM: tegra: Enable the DFLL on the Jetson TK1
  cpufreq: tegra124: Add device tree bindings
  cpufreq: tegra: Rename tegra-cpufreq to tegra20-cpufreq
  cpufreq: Add cpufreq driver for Tegra124
  ARM: tegra: Add entries for cpufreq on Tegra124
  ARM: tegra: enable Tegra124 cpufreq driver by default

 .../bindings/clock/nvidia,tegra124-dfll.txt        |   79 +
 .../bindings/cpufreq/tegra124-cpufreq.txt          |   44 +
 arch/arm/boot/dts/tegra124-jetson-tk1.dts          |   15 +-
 arch/arm/boot/dts/tegra124.dtsi                    |   34 +
 arch/arm/configs/tegra_defconfig                   |    1 +
 arch/arm/mach-tegra/Kconfig                        |    1 +
 drivers/clk/tegra/Makefile                         |    3 +
 drivers/clk/tegra/clk-dfll.c                       | 1755 ++++++++++++++++++++
 drivers/clk/tegra/clk-dfll.h                       |   54 +
 drivers/clk/tegra/clk-tegra-super-gen4.c           |    4 +-
 drivers/clk/tegra/clk-tegra124-dfll-fcpu.c         |  161 ++
 drivers/clk/tegra/clk-tegra124.c                   |   82 +
 drivers/clk/tegra/clk.c                            |   36 +-
 drivers/clk/tegra/clk.h                            |    3 +
 drivers/clk/tegra/cvb.c                            |  140 ++
 drivers/clk/tegra/cvb.h                            |   67 +
 drivers/cpufreq/Kconfig.arm                        |   13 +-
 drivers/cpufreq/Makefile                           |    3 +-
 drivers/cpufreq/tegra124-cpufreq.c                 |  214 +++
 .../cpufreq/{tegra-cpufreq.c => tegra20-cpufreq.c} |    0
 include/dt-bindings/reset/tegra124-car.h           |   11 +
 21 files changed, 2706 insertions(+), 14 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/clock/nvidia,tegra124-dfll.txt
 create mode 100644 Documentation/devicetree/bindings/cpufreq/tegra124-cpufreq.txt
 create mode 100644 drivers/clk/tegra/clk-dfll.c
 create mode 100644 drivers/clk/tegra/clk-dfll.h
 create mode 100644 drivers/clk/tegra/clk-tegra124-dfll-fcpu.c
 create mode 100644 drivers/clk/tegra/cvb.c
 create mode 100644 drivers/clk/tegra/cvb.h
 create mode 100644 drivers/cpufreq/tegra124-cpufreq.c
 rename drivers/cpufreq/{tegra-cpufreq.c => tegra20-cpufreq.c} (100%)
 create mode 100644 include/dt-bindings/reset/tegra124-car.h

-- 
2.3.0
