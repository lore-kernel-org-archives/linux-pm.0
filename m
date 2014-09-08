From: Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 7/7 v6] ARM: realview: basic device tree implementation
Date: Mon,  8 Sep 2014 13:38:06 +0200
Message-ID: <1410176286-32533-8-git-send-email-linus.walleij@linaro.org>
References: <1410176286-32533-1-git-send-email-linus.walleij@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-we0-f177.google.com ([74.125.82.177]:51148 "EHLO
	mail-we0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753816AbaIHLii (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 8 Sep 2014 07:38:38 -0400
Received: by mail-we0-f177.google.com with SMTP id u57so1686223wes.36
        for <linux-pm@vger.kernel.org>; Mon, 08 Sep 2014 04:38:35 -0700 (PDT)
In-Reply-To: <1410176286-32533-1-git-send-email-linus.walleij@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, linux-leds@vger.kernel.org, linux-pm@vger.kernel.org
Cc: Arnd Bergmann <arnd@arndb.de>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Marc Zyngier <marc.zyngier@arm.com>, Will Deacon <will.deacon@arm.com>, Rob Herring <robh@kernel.org>, Linus Walleij <linus.walleij@linaro.org>

This implements basic device tree boot support for the RealView
platforms, with a basic device tree for ARM PB1176 as an example.

The implementation is done with a new DT-specific board file
using only pre-existing bindings for the basic IRQ, timer and
serial port drivers. A new compatible type is added to the GIC
for the ARM1176.

This implementation uses the MFD syscon handle from day one to
access the system controller registers, and register the devices
using the SoC bus.

Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Rob Herring <robh@kernel.org>
Acked-by: Jason Cooper <jason@lakedaemon.net>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
ChangeLog v5->v6:
- Rely on the default DT machine as it will pass the l2x0
  untouched, we can let the default population call build
  up the device tree and skipe .init_machine() entirely.
- Get rid of cache associativity from the device tree, we
  added code to calculate this from size and sets.
- Put .l2c_aux_mask and .l2c_aux_val into the DT MACHINE
  entry so we can skip the separate call to l2x0_init().
- Specify cache line size in L2 DT entry.
ChangeLog v4->v5:
- Move the l2x0_init() aux set-ups over to the device tree,
  using one patch from Florian Fainelli and one patch from
  myself to support the needed bits.
- Put "simple-bus" last in binding documentation, examples
  and device tree so we go from most to least specific.
- Use the compatible arm11mp-gic binding for the GIC, and add
  a more specific binding "arm,arm1176jzf-devchip-gic" for the
  variant specifically found on the ARM1176JZF development
  chip. Add IRQCHIP_DECLARE() for both variants.
- Drop the "reboot device" node as we rewrote the driver to
  hog onto the syscon node directly.
- Augment device tree for the new register-bit-leds used with
  the syscon.
ChangeLog v3->v4:
- Switch the LEDs to usa a new syscon-LEDs driver so we can
  use the syscon as a hub for all these registers
- Split out the SoC driver to its own file in drivers/soc
ChangeLog v2->v3:
- Rename uart@0x12345678 to serial@0x12345678 in DTS file
- Drop static remapping for the LEDs, using my new invention
  syscon-leds instead
- Drop the hunk selecting ARM_DMA_MEM_BUFFERABLE for the DT
  version of the RealView platform. We think this is a local
  optimization we can live without.
- Split off the reset driver to a separate syscon-based reset
  driver in drivers/power/reset, add separate device tree
  bindings for this driver.
- To make sure the reset driver is always available for this
  system a few extra select statements are needed in Kconfig
- Split off the SoC bus driver to an easily identifiable chunk
  inside the mach-realview/realview-dt.c file. This *can* be
  spun off as a separate driver under drivers/soc for example
  but we need some separate discussion on this subject.
- Augment the SoC driver to display some system info so it's
  clear why this driver is there.
- Drop surplus string "with device tree" from machine
  description in the DTS file.
- Move the new GIC compatible string in alphabetic order.
ChangeLog v1->v2:
- Adjust timer clock names to be the same as the example in the
  device tree binding.
- Remove all memory fixup code - this should be handled by the
  device tree specification of memory areas or by special MM hacks
  for the RealView PBX.
- Fix the documentation around syscon to specify that it can be in
  any node, need not be the root node.
- Switch device tree license to the BSD license, taken from
  arch/powerpc/boot/dts/p1024rdb_32b.dts
- Add a hunk for the new compatible string to
  Documentation/devicetree/bindings/arm/gic.txt
- Move the clocks out of the SoC node, certainly the xtal is not
  sitting on the SoC...
- Sort the selects in Kconfig alphabetically
- Use IS_ENABLED() for the l2x0 code snippet
- Instead of checking the board variant in the reset routine to
  figure out how to tweak the reset controller, have a compatible
  string for each syscon variant, map it to an enum that provides a
  unique type ID and that way figure out how to handle it in a maybe
  more elegant way.
- Open issue: what do to with the l2x0 stuff?
---
 Documentation/devicetree/bindings/arm/arm-boards |  65 ++++++
 Documentation/devicetree/bindings/arm/gic.txt    |   1 +
 arch/arm/boot/dts/Makefile                       |   1 +
 arch/arm/boot/dts/arm-realview-pb1176.dts        | 246 +++++++++++++++++++++++
 arch/arm/mach-realview/Kconfig                   |  13 ++
 arch/arm/mach-realview/Makefile                  |   1 +
 arch/arm/mach-realview/realview-dt.c             |  32 +++
 drivers/irqchip/irq-gic.c                        |   2 +
 8 files changed, 361 insertions(+)
 create mode 100644 arch/arm/boot/dts/arm-realview-pb1176.dts
 create mode 100644 arch/arm/mach-realview/realview-dt.c

diff --git a/Documentation/devicetree/bindings/arm/arm-boards b/Documentation/devicetree/bindings/arm/arm-boards
index c554ed3d44fb..556c8665fdbf 100644
--- a/Documentation/devicetree/bindings/arm/arm-boards
+++ b/Documentation/devicetree/bindings/arm/arm-boards
@@ -92,3 +92,68 @@ Required nodes:
 - core-module: the root node to the Versatile platforms must have
   a core-module with regs and the compatible strings
   "arm,core-module-versatile", "syscon"
+
+ARM RealView Boards
+-------------------
+The RealView boards cover tailored evaluation boards that are used to explore
+the ARM11 and Cortex A-8 and Cortex A-9 processors.
+
+Required properties (in root node):
+	/* RealView Emulation Baseboard */
+	compatible = "arm,realview-eb";
+	 /* RealView Platform Baseboard for ARM1176JZF-S */
+	compatible = "arm,realview-pb1176";
+	/* RealView Platform Baseboard for ARM11 MPCore */
+	compatible = "arm,realview-pb11mp";
+	/* RealView Platform Baseboard for Cortex A-8 */
+	compatible = "arm,realview-pba8";
+	/* RealView Platform Baseboard Explore for Cortex A-9 */
+	compatible = "arm,realview-pbx";
+
+Required nodes:
+
+- soc: some node of the RealView platforms must be the SoC
+  node that contain the SoC-specific devices, withe the compatible
+  string set to one of these tuples:
+   "arm,realview-eb-soc", "simple-bus"
+   "arm,realview-pb1176-soc", "simple-bus"
+   "arm,realview-pb11mp-soc", "simple-bus"
+   "arm,realview-pba8-soc", "simple-bus"
+   "arm,realview-pbx-soc", "simple-bus"
+
+- syscon: some subnode of the RealView SoC node must be a
+  system controller node pointing to the control registers,
+  with the compatible string set to one of these tuples:
+   "arm,realview-eb-syscon", "syscon"
+   "arm,realview-pb1176-syscon", "syscon"
+   "arm,realview-pb11mp-syscon", "syscon"
+   "arm,realview-pba8-syscon", "syscon"
+   "arm,realview-pbx-syscon", "syscon"
+
+  Required properties for the system controller:
+  - regs: the location and size of the system controller registers,
+    one range of 0x1000 bytes.
+
+Example:
+
+/dts-v1/;
+#include <dt-bindings/interrupt-controller/irq.h>
+#include "skeleton.dtsi"
+
+/ {
+	model = "ARM RealView PB1176 with device tree";
+	compatible = "arm,realview-pb1176";
+
+	soc {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		compatible = "arm,realview-pb1176-soc", "simple-bus";
+		ranges;
+
+		syscon: syscon@10000000 {
+			compatible = "arm,realview-syscon", "syscon";
+			reg = <0x10000000 0x1000>;
+		};
+
+	};
+};
diff --git a/Documentation/devicetree/bindings/arm/gic.txt b/Documentation/devicetree/bindings/arm/gic.txt
index c7d2fa156678..b38608af66db 100644
--- a/Documentation/devicetree/bindings/arm/gic.txt
+++ b/Documentation/devicetree/bindings/arm/gic.txt
@@ -17,6 +17,7 @@ Main node required properties:
 	"arm,cortex-a7-gic"
 	"arm,arm11mp-gic"
 	"brcm,brahma-b15-gic"
+	"arm,arm1176jzf-devchip-gic"
 - interrupt-controller : Identifies the node as an interrupt controller
 - #interrupt-cells : Specifies the number of cells needed to encode an
   interrupt source.  The type shall be a <u32> and the value shall be 3.
diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index b8c5cd3ddeb9..e55d28eed151 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -344,6 +344,7 @@ dtb-$(CONFIG_ARCH_QCOM) += \
 	qcom-apq8084-mtp.dtb \
 	qcom-msm8660-surf.dtb \
 	qcom-msm8960-cdp.dtb
+dtb-$(CONFIG_ARCH_REALVIEW) += arm-realview-pb1176.dtb
 dtb-$(CONFIG_ARCH_ROCKCHIP) += \
 	rk3066a-bqcurie2.dtb \
 	rk3188-radxarock.dtb \
diff --git a/arch/arm/boot/dts/arm-realview-pb1176.dts b/arch/arm/boot/dts/arm-realview-pb1176.dts
new file mode 100644
index 000000000000..e1e730f9a3ce
--- /dev/null
+++ b/arch/arm/boot/dts/arm-realview-pb1176.dts
@@ -0,0 +1,246 @@
+/*
+ * Copyright 2014 Linaro Ltd
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a copy
+ * of this software and associated documentation files (the "Software"), to deal
+ * in the Software without restriction, including without limitation the rights
+ * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
+ * copies of the Software, and to permit persons to whom the Software is
+ * furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
+ * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
+ * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
+ * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
+ * THE SOFTWARE.
+ */
+
+/dts-v1/;
+#include <dt-bindings/interrupt-controller/irq.h>
+#include "skeleton.dtsi"
+
+/ {
+	model = "ARM RealView PB1176";
+	compatible = "arm,realview-pb1176";
+
+	chosen { };
+
+	aliases {
+		serial0 = &pb1176_serial0;
+		serial1 = &pb1176_serial1;
+		serial2 = &pb1176_serial2;
+		serial3 = &pb1176_serial3;
+	};
+
+	memory {
+		/* 128 MiB memory @ 0x0 */
+		reg = <0x00000000 0x08000000>;
+	};
+
+	xtal24mhz: xtal24mhz@24M {
+		#clock-cells = <0>;
+		compatible = "fixed-clock";
+		clock-frequency = <24000000>;
+	};
+
+	timclk: timclk@1M {
+		#clock-cells = <0>;
+		compatible = "fixed-factor-clock";
+		clock-div = <24>;
+		clock-mult = <1>;
+		clocks = <&xtal24mhz>;
+	};
+
+	uartclk: uartclk@24M {
+		#clock-cells = <0>;
+		compatible = "fixed-factor-clock";
+		clock-div = <1>;
+		clock-mult = <1>;
+		clocks = <&xtal24mhz>;
+	};
+
+	/* FIXME: this actually hangs off the PLL clocks */
+	pclk: pclk@0 {
+		#clock-cells = <0>;
+		compatible = "fixed-clock";
+		clock-frequency = <0>;
+	};
+
+	soc {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		compatible = "arm,realview-pb1176-soc", "simple-bus";
+		regmap = <&syscon>;
+		ranges;
+
+		syscon: syscon@10000000 {
+			compatible = "arm,realview-pb1176-syscon", "syscon";
+			reg = <0x10000000 0x1000>;
+
+			led@08.0 {
+				compatible = "register-bit-led";
+				offset = <0x08>;
+				mask = <0x01>;
+				label = "versatile:0";
+				linux,default-trigger = "heartbeat";
+				default-state = "on";
+			};
+			led@08.1 {
+				compatible = "register-bit-led";
+				offset = <0x08>;
+				mask = <0x02>;
+				label = "versatile:1";
+				linux,default-trigger = "mmc0";
+				default-state = "off";
+			};
+			led@08.2 {
+				compatible = "register-bit-led";
+				offset = <0x08>;
+				mask = <0x04>;
+				label = "versatile:2";
+				linux,default-trigger = "cpu0";
+				default-state = "off";
+			};
+			led@08.3 {
+				compatible = "register-bit-led";
+				offset = <0x08>;
+				mask = <0x08>;
+				label = "versatile:3";
+				default-state = "off";
+			};
+			led@08.4 {
+				compatible = "register-bit-led";
+				offset = <0x08>;
+				mask = <0x10>;
+				label = "versatile:4";
+				default-state = "off";
+			};
+			led@08.5 {
+				compatible = "register-bit-led";
+				offset = <0x08>;
+				mask = <0x20>;
+				label = "versatile:5";
+				default-state = "off";
+			};
+			led@08.6 {
+				compatible = "register-bit-led";
+				offset = <0x08>;
+				mask = <0x40>;
+				label = "versatile:6";
+				default-state = "off";
+			};
+			led@08.7 {
+				compatible = "register-bit-led";
+				offset = <0x08>;
+				mask = <0x80>;
+				label = "versatile:7";
+				default-state = "off";
+			};
+		};
+
+		/* Primary DevChip GIC synthesized with the CPU */
+		intc_dc1176: interrupt-controller@10120000 {
+			compatible = "arm,arm1176jzf-devchip-gic", "arm,arm11mp-gic";
+			#interrupt-cells = <3>;
+			#address-cells = <1>;
+			interrupt-controller;
+			reg = <0x10121000 0x1000>,
+			      <0x10120000 0x100>;
+		};
+
+		/* This GIC on the board is cascaded off the DevChip GIC */
+		intc_pb1176: interrupt-controller@10040000 {
+			compatible = "arm,arm1176jzf-devchip-gic", "arm,arm11mp-gic";
+			#interrupt-cells = <3>;
+			#address-cells = <1>;
+			interrupt-controller;
+			reg = <0x10041000 0x1000>,
+			      <0x10040000 0x100>;
+			interrupt-parent = <&intc_dc1176>;
+			interrupts = <0 31 IRQ_TYPE_LEVEL_HIGH>;
+		};
+
+		L2: l2-cache {
+			compatible = "arm,l220-cache";
+			reg = <0x10110000 0x1000>;
+			interrupt-parent = <&intc_dc1176>;
+			interrupts = <0 13 IRQ_TYPE_LEVEL_HIGH>;
+			cache-unified;
+			cache-level = <2>;
+			/*
+			 * Override default cache size, sets and
+			 * associativity as these may be erroneously set
+			 * up by boot loader(s).
+			 */
+			cache-size = <131072>; // 128kB
+			cache-sets = <8>;
+			cache-line-size = <32>;
+		};
+
+		pmu {
+			compatible = "arm,arm1176-pmu";
+			interrupt-parent = <&intc_dc1176>;
+			interrupts = <0 7 IRQ_TYPE_LEVEL_HIGH>;
+		};
+
+		timer01: timer@10104000 {
+			compatible = "arm,sp804", "arm,primecell";
+			reg = <0x10104000 0x1000>;
+			interrupt-parent = <&intc_dc1176>;
+			interrupts = <0 8 IRQ_TYPE_LEVEL_HIGH>, <0 9 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&timclk>, <&timclk>, <&pclk>;
+			clock-names = "timer1", "timer2", "apb_pclk";
+		};
+
+		timer23: timer@10105000 {
+			compatible = "arm,sp804", "arm,primecell";
+			reg = <0x10105000 0x1000>;
+			interrupt-parent = <&intc_dc1176>;
+			interrupts = <0 10 IRQ_TYPE_LEVEL_HIGH>;
+			arm,sp804-has-irq = <1>;
+			clocks = <&timclk>, <&timclk>, <&pclk>;
+			clock-names = "timer1", "timer2", "apb_pclk";
+		};
+
+		pb1176_serial0: serial@1010c000 {
+			compatible = "arm,pl011", "arm,primecell";
+			reg = <0x1010c000 0x1000>;
+			interrupt-parent = <&intc_dc1176>;
+			interrupts = <0 18 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&uartclk>, <&pclk>;
+			clock-names = "uartclk", "apb_pclk";
+		};
+
+		pb1176_serial1: serial@1010d000 {
+			compatible = "arm,pl011", "arm,primecell";
+			reg = <0x1010d000 0x1000>;
+			interrupt-parent = <&intc_dc1176>;
+			interrupts = <0 19 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&uartclk>, <&pclk>;
+			clock-names = "uartclk", "apb_pclk";
+		};
+
+		pb1176_serial2: serial@1010e000 {
+			compatible = "arm,pl011", "arm,primecell";
+			reg = <0x1010e000 0x1000>;
+			interrupt-parent = <&intc_dc1176>;
+			interrupts = <0 20 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&uartclk>, <&pclk>;
+			clock-names = "uartclk", "apb_pclk";
+		};
+
+		pb1176_serial3: serial@1010f000 {
+			compatible = "arm,pl011", "arm,primecell";
+			reg = <0x1010f000 0x1000>;
+			interrupt-parent = <&intc_dc1176>;
+			interrupts = <0 21 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&uartclk>, <&pclk>;
+			clock-names = "uartclk", "apb_pclk";
+		};
+	};
+};
diff --git a/arch/arm/mach-realview/Kconfig b/arch/arm/mach-realview/Kconfig
index 9db2029aa632..565925f37dc5 100644
--- a/arch/arm/mach-realview/Kconfig
+++ b/arch/arm/mach-realview/Kconfig
@@ -1,6 +1,19 @@
 menu "RealView platform type"
 	depends on ARCH_REALVIEW
 
+config REALVIEW_DT
+	bool "Support RealView(R) Device Tree based boot"
+	select ARM_GIC
+	select MFD_SYSCON
+	select POWER_RESET
+	select POWER_RESET_VERSATILE
+	select POWER_SUPPLY
+	select SOC_REALVIEW
+	select USE_OF
+	help
+	  Include support for booting the ARM(R) RealView(R) evaluation
+	  boards using a device tree machine description.
+
 config MACH_REALVIEW_EB
 	bool "Support RealView(R) Emulation Baseboard"
 	select ARM_GIC
diff --git a/arch/arm/mach-realview/Makefile b/arch/arm/mach-realview/Makefile
index 541fa4c109ef..e07fdf7ae8a7 100644
--- a/arch/arm/mach-realview/Makefile
+++ b/arch/arm/mach-realview/Makefile
@@ -3,6 +3,7 @@
 #
 
 obj-y					:= core.o
+obj-$(CONFIG_REALVIEW_DT)		+= realview-dt.o
 obj-$(CONFIG_MACH_REALVIEW_EB)		+= realview_eb.o
 obj-$(CONFIG_MACH_REALVIEW_PB11MP)	+= realview_pb11mp.o
 obj-$(CONFIG_MACH_REALVIEW_PB1176)	+= realview_pb1176.o
diff --git a/arch/arm/mach-realview/realview-dt.c b/arch/arm/mach-realview/realview-dt.c
new file mode 100644
index 000000000000..cc28b89dd48f
--- /dev/null
+++ b/arch/arm/mach-realview/realview-dt.c
@@ -0,0 +1,32 @@
+/*
+ * Copyright (C) 2014 Linaro Ltd.
+ *
+ * Author: Linus Walleij <linus.walleij@linaro.org>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2, as
+ * published by the Free Software Foundation.
+ *
+ */
+#include <linux/of_platform.h>
+#include <asm/mach/arch.h>
+#include <asm/hardware/cache-l2x0.h>
+#include "core.h"
+
+static const char *realview_dt_platform_compat[] __initconst = {
+	"arm,realview-eb",
+	"arm,realview-pb1176",
+	"arm,realview-pb11mp",
+	"arm,realview-pba8",
+	"arm,realview-pbx",
+	NULL,
+};
+
+DT_MACHINE_START(REALVIEW_DT, "ARM RealView Machine (Device Tree Support)")
+#ifdef CONFIG_ZONE_DMA
+	.dma_zone_size	= SZ_256M,
+#endif
+	.dt_compat	= realview_dt_platform_compat,
+	.l2c_aux_val = 0x0,
+	.l2c_aux_mask = ~0x0,
+MACHINE_END
diff --git a/drivers/irqchip/irq-gic.c b/drivers/irqchip/irq-gic.c
index 4b959e606fe8..4e75e3f24a97 100644
--- a/drivers/irqchip/irq-gic.c
+++ b/drivers/irqchip/irq-gic.c
@@ -1022,6 +1022,8 @@ gic_of_init(struct device_node *node, struct device_node *parent)
 	return 0;
 }
 IRQCHIP_DECLARE(gic_400, "arm,gic-400", gic_of_init);
+IRQCHIP_DECLARE(arm11mp_gic, "arm,arm11mp-gic", gic_of_init);
+IRQCHIP_DECLARE(arm1176jzf_dc_gic, "arm,arm1176jzf-devchip-gic", gic_of_init);
 IRQCHIP_DECLARE(cortex_a15_gic, "arm,cortex-a15-gic", gic_of_init);
 IRQCHIP_DECLARE(cortex_a9_gic, "arm,cortex-a9-gic", gic_of_init);
 IRQCHIP_DECLARE(cortex_a7_gic, "arm,cortex-a7-gic", gic_of_init);
-- 
1.9.3

