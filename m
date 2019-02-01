From: Lukasz Luba <l.luba@partner.samsung.com>
Subject: [PATCH v4 0/8] Exynos5 Dynamic Memory Controller driver
Date: Fri,  1 Feb 2019 17:46:44 +0100
Message-ID: <1549039612-28905-1-git-send-email-l.luba@partner.samsung.com>
References: <CGME20190201164717eucas1p2ddf83cd5b7a5f53fdb866eeb8e991c71@eucas1p2.samsung.com>
Content-Type: text/plain; charset="utf-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org
Cc: b.zolnierkie@samsung.com, krzk@kernel.org, kgene@kernel.org, cw00.choi@samsung.com, kyungmin.park@samsung.com, m.szyprowski@samsung.com, s.nawrocki@samsung.com, myungjoo.ham@samsung.com, Lukasz Luba <l.luba@partner.samsung.com>
List-Id: linux-pm@vger.kernel.org

Hi all,

This is v4 of the patch set which adds support of Dynamic Memory Controller
for Exynos5422 SoC.
The driver supports Dynamic Voltage and Frequency Scalling
for the DMC and DRAM. It also provides needed timings for different
speed operations of the DRAM memory.
The patch set is based on tag: v5.0-rc4

changes:
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

Lukasz Luba (8):
  clk: samsung: add needed IDs for DMC clocks in Exynos5420
  clk: samsung: add new clocks for DMC for Exynos5422 SoC
  clk: samsung: add BPLL rate table for Exynos 5422 SoC
  drivers: devfreq: add DMC driver for Exynos5422
  dt-bindings: devfreq: add Exynos5422 DMC device description
  DT: arm: exynos: add DMC device for exynos5422
  drivers: devfreq: events: add Exynos PPMU new events
  ARM: exynos_defconfig: enable DMC driver

 .../devicetree/bindings/devfreq/exynos5422-dmc.txt |  106 ++
 MAINTAINERS                                        |    8 +
 arch/arm/boot/dts/exynos5420.dtsi                  |   78 ++
 arch/arm/boot/dts/exynos5422-odroid-core.dtsi      |   22 +
 arch/arm/configs/exynos_defconfig                  |    1 +
 drivers/clk/samsung/clk-exynos5420.c               |   59 +-
 drivers/devfreq/Kconfig                            |   13 +
 drivers/devfreq/Makefile                           |    1 +
 drivers/devfreq/event/exynos-ppmu.c                |    6 +
 drivers/devfreq/exynos5422-dmc.c                   | 1274 ++++++++++++++++++++
 include/dt-bindings/clock/exynos5420.h             |   16 +-
 11 files changed, 1578 insertions(+), 6 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/devfreq/exynos5422-dmc.txt
 create mode 100644 drivers/devfreq/exynos5422-dmc.c

-- 
2.7.4
