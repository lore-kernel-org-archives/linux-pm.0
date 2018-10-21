From: Dmitry Osipenko <digetx@gmail.com>
Subject: [RFC PATCH v2 00/17] CPUFREQ OPP's, DVFS and Tegra30 support by tegra20-cpufreq driver
Date: Sun, 21 Oct 2018 23:54:44 +0300
Message-ID: <20181021205501.23943-1-digetx@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>, Rob Herring <robh+dt@kernel.org>, Thierry Reding <thierry.reding@gmail.com>, Jonathan Hunter <jonathanh@nvidia.com>, Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>, Marcel Ziswiler <marcel.ziswiler@toradex.com>
Cc: linux-tegra@vger.kernel.org, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Hello,

This series adds support for CPU frequency/voltage scaling on Tegra20/30,
it adds device tree support that allow to specify clock rate/voltages per
board and to implement thermal throttling. The tegra20-cpufreq driver has
been re-worked to support that all.

Note that this series depends on in-progress clock [0] and regulator [1]
patches.

Changelog:

v2:
    - Implemented DVFS support. Currently only CPU rail changes voltage,
      while CORE/RTC locked to maximum. The CORE can be unlocked once all
      of peripheral drivers will gain support for DVFS. See "TODO" comment
      in the driver. On Tegra20 CPU temperature is lower by 5-6 C during
      idling with DVFS. On Tegra30 CPU temperature is lower by 1-2 C, and
      it drops by 6-7 C if CORE rail scaling is unlocked.

    - Device-tree binding has been reworked to support voltage regulators
      and HW versioning. Now CPU OPP's are specified per HW version and
      include voltage entry. OPP values are taken from downstream kernel
      [2][3]. The "backup" clock has been renamed to "intermediate".

[0] https://lkml.org/lkml/2018/8/30/960
[1] https://lkml.org/lkml/2018/10/5/682
[2] https://nv-tegra.nvidia.com/gitweb/?p=linux-2.6.git;a=blob;f=arch/arm/mach-tegra/tegra2_dvfs.c;hb=l4t/l4t-r16-r2
[3] https://nv-tegra.nvidia.com/gitweb/?p=linux-2.6.git;a=blob;f=arch/arm/mach-tegra/tegra3_dvfs.c;hb=l4t/l4t-r16-r2

Dmitry Osipenko (17):
  OPP: Allow to request stub voltage regulators
  soc/tegra: fuse: Export tegra_get_chip_id()
  dt-bindings: cpufreq: Add binding for NVIDIA Tegra20/30
  cpufreq: tegra20: Support OPP, thermal cooling, DVFS and Tegra30
  ARM: tegra: Create tegra20-cpufreq device on Tegra30
  ARM: dts: tegra20: Add CPU Operating Performance Points
  ARM: dts: tegra30: Add CPU Operating Performance Points
  ARM: dts: tegra20: colibri: Setup voltage regulators for DVFS
  ARM: dts: tegra20: harmony: Setup voltage regulators for DVFS
  ARM: dts: tegra20: paz00: Setup voltage regulators for DVFS
  ARM: dts: tegra20: seaboard: Setup voltage regulators for DVFS
  ARM: dts: tegra20: tamonten: Setup voltage regulators for DVFS
  ARM: dts: tegra20: ventana: Setup voltage regulators for DVFS
  ARM: dts: tegra30: apalis: Setup voltage regulators for DVFS
  ARM: dts: tegra30: beaver: Setup voltage regulators for DVFS
  ARM: dts: tegra30: cardhu: Setup voltage regulators for DVFS
  ARM: dts: tegra30: colibri: Setup voltage regulators for DVFS

 .../cpufreq/nvidia,tegra20-cpufreq.txt        |  96 ++
 arch/arm/boot/dts/tegra20-colibri.dtsi        |  31 +-
 arch/arm/boot/dts/tegra20-harmony.dts         |  31 +-
 arch/arm/boot/dts/tegra20-paz00.dts           |  31 +-
 arch/arm/boot/dts/tegra20-seaboard.dts        |  27 +-
 arch/arm/boot/dts/tegra20-tamonten.dtsi       |  31 +-
 arch/arm/boot/dts/tegra20-ventana.dts         |  31 +-
 arch/arm/boot/dts/tegra20.dtsi                | 277 ++++++
 arch/arm/boot/dts/tegra30-apalis.dtsi         |  19 +-
 arch/arm/boot/dts/tegra30-beaver.dts          |  19 +-
 arch/arm/boot/dts/tegra30-cardhu.dtsi         |  19 +-
 arch/arm/boot/dts/tegra30-colibri.dtsi        |  19 +-
 arch/arm/boot/dts/tegra30.dtsi                | 688 +++++++++++++++
 arch/arm/mach-tegra/tegra.c                   |   4 +
 drivers/cpufreq/Kconfig.arm                   |   2 +
 drivers/cpufreq/cpufreq-dt-platdev.c          |   2 +
 drivers/cpufreq/cpufreq-dt.c                  |   2 +-
 drivers/cpufreq/tegra20-cpufreq.c             | 832 +++++++++++++++---
 drivers/cpufreq/ti-cpufreq.c                  |   3 +-
 drivers/opp/core.c                            |   9 +-
 drivers/soc/tegra/fuse/tegra-apbmisc.c        |   1 +
 include/linux/pm_opp.h                        |   4 +-
 22 files changed, 2006 insertions(+), 172 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/cpufreq/nvidia,tegra20-cpufreq.txt

-- 
2.19.0
