From: Chanwoo Choi <cw00.choi@samsung.com>
Subject: [PATCH 0/7] PM / devfreq: Add NoCP devfreq-event and support busfreq
 on exyno5422-odroidxu3
Date: Fri, 08 Apr 2016 14:00:39 +0900
Message-ID: <1460091646-28701-1-git-send-email-cw00.choi@samsung.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:33173 "EHLO
	mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757134AbcDHFBB (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 8 Apr 2016 01:01:01 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: myungjoo.ham@samsung.com, kyungmin.park@samsung.com, k.kozlowski@samsung.com, kgene@kernel.org, s.nawrocki@samsung.com, tomasz.figa@gmail.com
Cc: rjw@rjwysocki.net, robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, linux@arm.linux.org.uk, linux.amoon@gmail.com, m.reichl@fivetechno.de, tjakobi@math.uni-bielefeld.de, inki.dae@samsung.com, cw00.choi@samsung.com, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org

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

[1] https://lkml.org/lkml/2016/4/8/14
- [PATCH v8 00/20] PM / devferq: Add generic exynos bus frequency driver and new passive governor

Chanwoo Choi (7):
  PM / devfreq: event: Add new Exynos NoC probe driver
  PM / devfreq: exynos: Add the detailed correlation for Exynos5422 bus
  ARM: dts: Add NoC Probe dt node for Exynos542x SoC
  dt-bindings: clock: Add the clock id for ACLK clock of Exynos542x SoC
  clk: samsung: exynos542x: Add the clock id for ACLK
  ARM: dts: Add bus nodes using VDD_INT for Exynos542x SoC
  ARM: dts: Add support of Bus frequency using VDD_INT for exynos5422-odroidxu3

 .../bindings/devfreq/event/exynos-nocp.txt         |  86 +++++
 .../devicetree/bindings/devfreq/exynos-bus.txt     |  19 +
 arch/arm/boot/dts/exynos5420.dtsi                  | 407 +++++++++++++++++++++
 arch/arm/boot/dts/exynos5422-odroidxu3-common.dtsi |  99 +++++
 drivers/clk/samsung/clk-exynos5420.c               |  85 +++--
 drivers/devfreq/event/Kconfig                      |   8 +
 drivers/devfreq/event/Makefile                     |   2 +
 drivers/devfreq/event/exynos-nocp.c                | 247 +++++++++++++
 drivers/devfreq/event/exynos-nocp.h                |  78 ++++
 include/dt-bindings/clock/exynos5420.h             |  24 +-
 10 files changed, 1024 insertions(+), 31 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/devfreq/event/exynos-nocp.txt
 create mode 100644 drivers/devfreq/event/exynos-nocp.c
 create mode 100644 drivers/devfreq/event/exynos-nocp.h

-- 
1.9.1

