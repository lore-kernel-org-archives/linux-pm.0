From: Lukasz Luba <l.luba@partner.samsung.com>
Subject: [PATCH v6 0/10] Exynos5 Dynamic Memory Controller driver
Date: Fri, 19 Apr 2019 16:19:18 +0200
Message-ID: <1555683568-20882-1-git-send-email-l.luba@partner.samsung.com>
References: <CGME20190419141938eucas1p16ee6cdf897184df33cf67b55c5f3c449@eucas1p1.samsung.com>
Content-Type: text/plain; charset="utf-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org
Cc: b.zolnierkie@samsung.com, krzk@kernel.org, kgene@kernel.org, cw00.choi@samsung.com, kyungmin.park@samsung.com, m.szyprowski@samsung.com, s.nawrocki@samsung.com, myungjoo.ham@samsung.com, keescook@chromium.org, tony@atomide.com, jroedel@suse.de, treding@nvidia.com, digetx@gmail.com, willy.mh.wolff.ml@gmail.com, Lukasz Luba <l.luba@partner.samsung.com>
List-Id: linux-pm@vger.kernel.org

Hi all,

This is v6 of the patch set which adds support of Dynamic Memory Controller
for Exynos5422 SoC.
The driver supports Dynamic Voltage and Frequency Scalling
for the DMC and DRAM. It also provides needed timings for different
speed operations of the DRAM memory.

The patch set depends on changes to Exynos PPMU posted on LKLM as:
[PATCH v3 0/4] Exynos Performance Monitoring Counters enhancements

changes:
v6:
- driver code has been converted to use generic code which parses DT memory
  definition in drivers/memory/of_memory.c
- extended of_memory by LPDDR3 support (there was LPDDR2 made by TI)
- extended jedec_lpddr.h by the needed structures for LPDDR3 (AC timings)
- driver file moved to proper directory, where other memory controllers
  live, which is in this case drivers/memory/samsung/
- driver code now uses regmap_{read|write} to access registers for pausing
  and changing timings set, as suggested by Chanwoo
- DT contains simple definition of memory device, similar to LPDDR2 made by TI
- driver code generates the needed timings for registered OPPs, based on
  memory description in DT
- patch 1 contains Rob's ACK,
- simplified memory bandwidth calculation
- added debug information files with timings, raw counters and statistics
- updated dt-bindings files accordingly
- based on v5.1-rc5 (+ PPMU patches)
v5:
- removed unneeded wrapper functions i.e. for regulator_set_voltage
- removed unused defines
- removed direct access to clock register base and used CCF for
  pause and timing set usage
- switched to OPP comming from DT according to Chanowoo's comments
- switched to timings comming from DT, added parsing function
- extended dt-binding with description of OPPs and timings
- according to Rob Herring comment, moved dt-binding file before driver code
  in the patch set.
- rebased on top of v5.0
v4:
- removed unneeded DPLL and G3D clocks IDs
- changed names of parent clocks for mout_mx_mspll_ccore_phy_p
  and added one more parent: mout_sclk_epll
- removed 933Mhz and 138MHz from the BPLL ratio table
v3:
- in DTS align to proper indent the clocks and clock-names entries
v2:
- changed file name exynos5-dmc.c -> exynos5422-dmc.c
  and related entries in other files
- changed dt-binding file name
- changed config entry to CONFIG_ARM_EXYNOS5422_DMC_DEVFREQ
- removed sysfs and print info messages (print only one line)
- removed function exynos5_read_chip_info and compact code
- changed dt-binding patch and move it up in the patch set
- new entries in MAINTAINERS are added with the driver c code
- clean-up in DTS file: renamed nodes to 'ppmu' and 'memory-controller',
  entries moved to suggested location (before nocp nodes or after),
  moved according to alfabetical order, compacted clocks names with right indent.

Regards,
Lukasz Luba

Lukasz Luba (10):
  clk: samsung: add needed IDs for DMC clocks in Exynos5420
  clk: samsung: add new clocks for DMC for Exynos5422 SoC
  clk: samsung: add BPLL rate table for Exynos 5422 SoC
  Documentation: dt: device tree bindings for LPDDR3 memories
  drivers: memory: extend of_memory by LPDDR3 support
  dt-bindings: memory-controllers: add Exynos5422 DMC device description
  drivers: memory: add DMC driver for Exynos5422
  drivers: devfreq: events: add Exynos PPMU new events
  ARM: dts: exynos: add DMC device for exynos5422
  ARM: exynos_defconfig: enable DMC driver

 .../devicetree/bindings/lpddr3/lpddr3-timings.txt  |   57 +
 .../devicetree/bindings/lpddr3/lpddr3.txt          |   93 +
 .../bindings/memory-controllers/exynos5422-dmc.txt |   73 +
 MAINTAINERS                                        |    8 +
 arch/arm/boot/dts/exynos5420.dtsi                  |  120 ++
 arch/arm/boot/dts/exynos5422-odroid-core.dtsi      |  120 ++
 arch/arm/configs/exynos_defconfig                  |    1 +
 drivers/clk/samsung/clk-exynos5420.c               |   59 +-
 drivers/devfreq/event/exynos-ppmu.c                |    6 +
 drivers/memory/of_memory.c                         |  125 ++
 drivers/memory/of_memory.h                         |   20 +-
 drivers/memory/samsung/Kconfig                     |   17 +
 drivers/memory/samsung/Makefile                    |    1 +
 drivers/memory/samsung/exynos5422-dmc.c            | 1793 ++++++++++++++++++++
 include/dt-bindings/clock/exynos5420.h             |   18 +-
 include/memory/jedec_ddr.h                         |   62 +
 16 files changed, 2566 insertions(+), 7 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/lpddr3/lpddr3-timings.txt
 create mode 100644 Documentation/devicetree/bindings/lpddr3/lpddr3.txt
 create mode 100644 Documentation/devicetree/bindings/memory-controllers/exynos5422-dmc.txt
 create mode 100644 drivers/memory/samsung/exynos5422-dmc.c

-- 
2.7.4
