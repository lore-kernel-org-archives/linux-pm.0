From: Chanwoo Choi <cw00.choi@samsung.com>
Subject: [RFC PATCHv2 0/8] devfreq: Add generic exynos memory-bus frequency
 driver
Date: Wed, 31 Dec 2014 14:19:44 +0900
Message-ID: <1420003192-5576-1-git-send-email-cw00.choi@samsung.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:23020 "EHLO
	mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750760AbaLaFT5 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 31 Dec 2014 00:19:57 -0500
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: myungjoo.ham@samsung.com
Cc: kgene.kim@samsung.com, kyungmin.park@samsung.com, rafael.j.wysocki@intel.com, mark.rutland@arm.com, a.kesavan@samsung.com, tomasz.figa@gmail.com, k.kozlowski@samsung.com, b.zolnierkie@samsung.com, cw00.choi@samsung.com, inki.dae@samsung.com, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org

This patch-set adds the generic exynos bus frequency driver for memory bus
with DEVFREQ framework. The Samsung Exynos SoCs have the common architecture
for memory bus between DRAM memory and MMC/sub IP in SoC. This driver can
support the memory bus frequency driver for Exynos SoCs.

Each memory bus block has a clock for memory bus speed and frequency
table which is changed according to the utilization of memory bus on runtime.
And then each memory bus group has the one more memory bus blocks and
OPP table (including frequency and voltage), regulator, devfreq-event
devices.

There are a little difference about the number of memory bus because each Exynos
SoC have the different sub-IP and different memory bus speed. In spite of this
difference among Exynos SoCs, we can support almost Exynos SoC by adding
unique data of memory bus to devicetree file.

This patch-set has the dependency on following patch-set[1]:
[1] [PATCHv6 0/9] devfreq: Add devfreq-event class to provide raw data for devfreq device
- https://lkml.org/lkml/2014/12/28/139

Changes from v1:
- This patchset is rebased on v3.19-rc2.
- Fix bug after wake-up from suspend state. If devfreq device fail to get event,
  exynos-busfreq retry to set the event for starting.
- Add memory bus group of Exynos4x12/Exynos4210
- Add divider clock id for Exynos4 memory bus frequency
- Support memory bus frequency driver on Exynos4412-based TRATS2 board

Chanwoo Choi (8):
  devfreq: exynos: Add generic exynos memory bus frequency driver
  devfreq: exynos: Add documentation for generic exynos memory bus frequency driver
  ARM: dts: Add memory bus node for Exynos3250
  clk: samsung: exynos4: Add divider clock id for memory bus frequency
  ARM: dts: Add memory bus node for Exynos4x12
  ARM: dts: Add memory bus node for Exynos4210
  ARM: dts: Add memory bus node for Exynos3250-based Rinato board
  ARM: dts: Add memory bus node for Exynos4412-based TRATS2 board

 .../devicetree/bindings/devfreq/exynos-busfreq.txt | 184 +++++++
 arch/arm/boot/dts/exynos3250-rinato.dts            |  12 +
 arch/arm/boot/dts/exynos3250.dtsi                  | 125 +++++
 arch/arm/boot/dts/exynos4210.dtsi                  |  93 ++++
 arch/arm/boot/dts/exynos4412-trats2.dts            |  12 +
 arch/arm/boot/dts/exynos4x12.dtsi                  | 121 +++++
 drivers/clk/samsung/clk-exynos4.c                  |  10 +-
 drivers/devfreq/Kconfig                            |  15 +
 drivers/devfreq/Makefile                           |   1 +
 drivers/devfreq/exynos-busfreq.c                   | 588 +++++++++++++++++++++
 include/dt-bindings/clock/exynos4.h                |   7 +-
 11 files changed, 1162 insertions(+), 6 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/devfreq/exynos-busfreq.txt
 create mode 100644 drivers/devfreq/exynos-busfreq.c

-- 
1.8.5.5

