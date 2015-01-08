From: Mikko Perttunen <mikko.perttunen-/1wQRMveznE@public.gmane.org>
Subject: [PATCH v7 00/16] Tegra124 CL-DVFS / DFLL clocksource + cpufreq
Date: Thu,  8 Jan 2015 15:22:03 +0200
Message-ID: <1420723339-30735-1-git-send-email-mikko.perttunen@kapsi.fi>
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org, thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, gnurou-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, pdeschrijver-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org, rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org, viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org
Cc: mturquette-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, pwalmsley-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org, vinceh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org, pgaikwad-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, tuomas.tynkkynen-X3B1VOXEql0@public.gmane.org, Mikko Perttunen <mikko.perttunen-/1wQRMveznE@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

Hi again! This is v7 of the Tegra124 cpufreq series. Only change since
v6 is that it's rebased on top of -next and format-patch was called with
-C and -M.

The series is available in a git repository at
  git://github.com/cyndis/linux.git cldvfs-v7

Tested by me on Jetson-TK1 (rev. D).

Original cover letter:

This series implements the DFLL/CL-DVFS clock source for the fast CPU
cluster on Tegra124, and a cpufreq driver that uses the DFLL for
clocking the CPU. Most of this is based on Paul Walmsley's public patch
set from December 2013, which is available at
http://comments.gmane.org/gmane.linux.ports.tegra/15273

The DFLL clock hardware is a voltage-controlled oscillator plus
control logic that compares the generated output clock with a
51 MHz reference clock, and can make decisions to either lower
or raise the DFLL voltage to keep the output rate close to the
software-requested rate. The voltage changes are done by
communicating with an off-chip PMIC via either I2C or PWM.
As the DFLL oscillator is powered via the CPU rail, using
the DFLL as the CPU clocksource also gives us dynamic CPU
voltage scaling.

This series has been tested on the Jetson TK1 (Rev C). Porting this to
the Venice2 should be simple, though do note that it does not have
active cooling.

Thanks,
Tuomas

Mikko Perttunen (1):
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

 .../bindings/clock/nvidia,tegra124-dfll.txt        |   69 +
 .../bindings/cpufreq/tegra124-cpufreq.txt          |   44 +
 arch/arm/boot/dts/tegra124-jetson-tk1.dts          |   14 +-
 arch/arm/boot/dts/tegra124.dtsi                    |   31 +
 arch/arm/configs/tegra_defconfig                   |    1 +
 arch/arm/mach-tegra/Kconfig                        |    1 +
 drivers/clk/tegra/Makefile                         |    3 +
 drivers/clk/tegra/clk-dfll.c                       | 1750 ++++++++++++++++++++
 drivers/clk/tegra/clk-dfll.h                       |   55 +
 drivers/clk/tegra/clk-tegra-super-gen4.c           |    4 +-
 drivers/clk/tegra/clk-tegra124-dfll-fcpu.c         |  165 ++
 drivers/clk/tegra/clk-tegra124.c                   |   61 +
 drivers/clk/tegra/clk.h                            |    3 +
 drivers/clk/tegra/cvb.c                            |  133 ++
 drivers/clk/tegra/cvb.h                            |   67 +
 drivers/cpufreq/Kconfig.arm                        |   13 +-
 drivers/cpufreq/Makefile                           |    3 +-
 drivers/cpufreq/tegra124-cpufreq.c                 |  217 +++
 .../cpufreq/{tegra-cpufreq.c => tegra20-cpufreq.c} |    0
 19 files changed, 2628 insertions(+), 6 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/clock/nvidia,tegra124-dfll.txt
 create mode 100644 Documentation/devicetree/bindings/cpufreq/tegra124-cpufreq.txt
 create mode 100644 drivers/clk/tegra/clk-dfll.c
 create mode 100644 drivers/clk/tegra/clk-dfll.h
 create mode 100644 drivers/clk/tegra/clk-tegra124-dfll-fcpu.c
 create mode 100644 drivers/clk/tegra/cvb.c
 create mode 100644 drivers/clk/tegra/cvb.h
 create mode 100644 drivers/cpufreq/tegra124-cpufreq.c
 rename drivers/cpufreq/{tegra-cpufreq.c => tegra20-cpufreq.c} (100%)

-- 
2.2.1
