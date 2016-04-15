From: Chanwoo Choi <cw00.choi@samsung.com>
Subject: [PATCH v2 0/8] PM / devfreq: Add NoCP devfreq-event and support
 busfreq on exyno5422-odroidxu3
Date: Fri, 15 Apr 2016 15:32:47 +0900
Message-ID: <1460701975-24178-1-git-send-email-cw00.choi@samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: myungjoo.ham@samsung.com, kyungmin.park@samsung.com, k.kozlowski@samsung.com, tomasz.figa@gmail.com, s.nawrocki@samsung.com, kgene@kernel.org
Cc: robh@kernel.org, rjw@rjwysocki.net, robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, linux@arm.linux.org.uk, linux.amoon@gmail.com, m.reichl@fivetechno.de, tjakobi@math.uni-bielefeld.de, inki.dae@samsung.com, cw00.choi@samsung.com, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

This patchset support the AMBA bus frequency scaling on Exynos5422-based
Odroid-XU3 board. But, this series only support the bus frequency scaling
for INT (Internal) block using VDD_INT power line.

Also, to support the bus frequency scaling for Exynos542x SoC,
Exynos542x SoC has the specific 'NoC (Network on Chip) Probe' device
to measure the transfered data traffic on NoC (Network on Chip)
instead of PPMU (Platform Performance Monitoring Unit). NoC Probe device
provide the utilization for INT block of Exynos542x SoC.

The generic exynos-bus frequency driver uses the 'NoC Probe' devfreq-event
device (drivers/devfreq/event/exynos-nocp.c) without any modification.
Just add the phandle of 'NoC Probe' dt node to bus dt node.

Depend on:
This patchset depends on patch[1] which support the generic exynos-bus
frequency driver.
[1] http://www.spinics.net/lists/arm-kernel/msg495976.html
- [PATCH v9 00/20] PM / devferq: Add generic exynos bus frequency driver and new passive governor


Changse from v1:
(https://lkml.org/lkml/2016/4/8/28)
- Simplify the documentation of exynos-nocp.txt
- Check the return value of regmap function
- Modify Device Tree node name using general device name
 : nocp_memX_X@ nocp_memX_X -> nocp_memX_X@ nocp
- Fix wrong node name about nocp device tree node
- Drop the CLK_SET_RATE_PARENT flag
- Reorder bus device tree node alpabetically
- Add the tested-by tag from Anand Moon and Markus Reichl
- Add the reviewed-by tag to patch5/7 from Exynos SoC Maintainer
- Add patch2 to modify the devfreq_event_get_edev_by_phandle()
  to get the instance of devfreq-event device by using the phandle

Chanwoo Choi (8):
  PM / devfreq: event: Add new Exynos NoC probe driver
  PM / devfreq: event: Find the instance of devfreq-event device by using phandle
  PM / devfreq: exynos: Add the detailed correlation for Exynos5422 bus
  ARM: dts: Add NoC Probe dt node for Exynos542x SoC
  dt-bindings: clock: Add the clock id for ACLK clock of Exynos542x SoC
  clk: samsung: exynos542x: Add the clock id for ACLK
  ARM: dts: Add bus nodes using VDD_INT for Exynos542x SoC
  ARM: dts: Add support of Bus frequency using VDD_INT for exynos5422-odroidxu3

 .../bindings/devfreq/event/exynos-nocp.txt         |  26 ++
 .../devicetree/bindings/devfreq/exynos-bus.txt     |  19 +
 arch/arm/boot/dts/exynos5420.dtsi                  | 407 +++++++++++++++++++++
 arch/arm/boot/dts/exynos5422-odroidxu3-common.dtsi |  99 +++++
 drivers/clk/samsung/clk-exynos5420.c               |  77 ++--
 drivers/devfreq/devfreq-event.c                    |   5 +
 drivers/devfreq/event/Kconfig                      |   8 +
 drivers/devfreq/event/Makefile                     |   2 +
 drivers/devfreq/event/exynos-nocp.c                | 304 +++++++++++++++
 drivers/devfreq/event/exynos-nocp.h                |  78 ++++
 include/dt-bindings/clock/exynos5420.h             |  24 +-
 11 files changed, 1018 insertions(+), 31 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/devfreq/event/exynos-nocp.txt
 create mode 100644 drivers/devfreq/event/exynos-nocp.c
 create mode 100644 drivers/devfreq/event/exynos-nocp.h

-- 
1.9.1
