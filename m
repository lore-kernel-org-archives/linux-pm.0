From: Dave Gerlach <d-gerlach@ti.com>
Subject: [PATCH v3 2/4] dt-bindings: Add TI SCI PM Domains
Date: Wed, 4 Jan 2017 14:55:34 -0600
Message-ID: <20170104205536.15963-3-d-gerlach@ti.com>
References: <20170104205536.15963-1-d-gerlach@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170104205536.15963-1-d-gerlach@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Kevin Hilman <khilman@kernel.org>, Rob Herring <robh+dt@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, Nishanth Menon <nm@ti.com>, Dave Gerlach <d-gerlach@ti.com>, Keerthy <j-keerthy@ti.com>, Russell King <rmk+kernel@armlinux.org.uk>, Tero Kristo <t-kristo@ti.com>, Sudeep Holla <sudeep.holla@arm.com>, Santosh Shilimkar <ssantosh@kernel.org>, Lokesh Vutla <lokeshvutla@ti.com>
List-Id: linux-pm@vger.kernel.org

Add a generic power domain implementation, TI SCI PM Domains, that
will hook into the genpd framework and allow the TI SCI protocol to
control device power states.

Also, provide macros representing each device index as understood
by TI SCI to be used in the device node power-domain references.
These are identifiers for the K2G devices managed by the PMMC.

Signed-off-by: Nishanth Menon <nm@ti.com>
Signed-off-by: Dave Gerlach <d-gerlach@ti.com>
---
v2->v3:
	Update k2g_pds node docs to show it should be a child of pmmc node.
	In early versions a phandle was used to point to pmmc and docs still
	incorrectly showed this.

 .../devicetree/bindings/soc/ti/sci-pm-domain.txt   | 59 ++++++++++++++
 MAINTAINERS                                        |  2 +
 include/dt-bindings/genpd/k2g.h                    | 90 ++++++++++++++++++++++
 3 files changed, 151 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/soc/ti/sci-pm-domain.txt
 create mode 100644 include/dt-bindings/genpd/k2g.h

diff --git a/Documentation/devicetree/bindings/soc/ti/sci-pm-domain.txt b/Documentation/devicetree/bindings/soc/ti/sci-pm-domain.txt
new file mode 100644
index 000000000000..4c9064e512cb
--- /dev/null
+++ b/Documentation/devicetree/bindings/soc/ti/sci-pm-domain.txt
@@ -0,0 +1,59 @@
+Texas Instruments TI-SCI Generic Power Domain
+---------------------------------------------
+
+Some TI SoCs contain a system controller (like the PMMC, etc...) that is
+responsible for controlling the state of the IPs that are present.
+Communication between the host processor running an OS and the system
+controller happens through a protocol known as TI-SCI [1]. This pm domain
+implementation plugs into the generic pm domain framework and makes use of
+the TI SCI protocol power on and off each device when needed.
+
+[1] Documentation/devicetree/bindings/arm/keystone/ti,sci.txt
+
+PM Domain Node
+==============
+The PM domain node represents the global PM domain managed by the PMMC,
+which in this case is the single implementation as documented by the generic
+PM domain bindings in Documentation/devicetree/bindings/power/power_domain.txt.
+Because this relies on the TI SCI protocol to communicate with the PMMC it
+must be a child of the pmmc node.
+
+Required Properties:
+--------------------
+- compatible: should be "ti,sci-pm-domain"
+- #power-domain-cells: Must be 0.
+
+Example (K2G):
+-------------
+	pmmc: pmmc {
+		compatible = "ti,k2g-sci";
+		...
+
+		k2g_pds: k2g_pds {
+			compatible = "ti,sci-pm-domain";
+			#power-domain-cells = <0>;
+		};
+	};
+
+PM Domain Consumers
+===================
+Hardware blocks that require SCI control over their state must provide
+a reference to the sci-pm-domain they are part of and a unique device
+specific ID that identifies the device.
+
+Required Properties:
+--------------------
+- power-domains: phandle pointing to the corresponding PM domain node.
+- ti,sci-id: index representing the device id to be passed oevr SCI to
+	     be used for device control.
+
+See dt-bindings/genpd/k2g.h for the list of valid identifiers for k2g.
+
+Example (K2G):
+--------------------
+	uart0: serial@02530c00 {
+		compatible = "ns16550a";
+		...
+		power-domains = <&k2g_pds>;
+		ti,sci-id = <K2G_DEV_UART0>;
+	};
diff --git a/MAINTAINERS b/MAINTAINERS
index cfff2c9e3d94..7e68af170dae 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -12144,6 +12144,8 @@ S:	Maintained
 F:	Documentation/devicetree/bindings/arm/keystone/ti,sci.txt
 F:	drivers/firmware/ti_sci*
 F:	include/linux/soc/ti/ti_sci_protocol.h
+F:	Documentation/devicetree/bindings/soc/ti/sci-pm-domain.txt
+F:	include/dt-bindings/genpd/k2g.h
 
 THANKO'S RAREMONO AM/FM/SW RADIO RECEIVER USB DRIVER
 M:	Hans Verkuil <hverkuil@xs4all.nl>
diff --git a/include/dt-bindings/genpd/k2g.h b/include/dt-bindings/genpd/k2g.h
new file mode 100644
index 000000000000..91ad827e0ca1
--- /dev/null
+++ b/include/dt-bindings/genpd/k2g.h
@@ -0,0 +1,90 @@
+/*
+ * TI K2G SoC Device definitions
+ *
+ * Copyright (C) 2015-2016 Texas Instruments Incorporated - http://www.ti.com/
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+
+#ifndef _DT_BINDINGS_GENPD_K2G_H
+#define _DT_BINDINGS_GENPD_K2G_H
+
+/* Documented in http://processors.wiki.ti.com/index.php/TISCI */
+
+#define K2G_DEV_PMMC0			0x0000
+#define K2G_DEV_MLB0			0x0001
+#define K2G_DEV_DSS0			0x0002
+#define K2G_DEV_MCBSP0			0x0003
+#define K2G_DEV_MCASP0			0x0004
+#define K2G_DEV_MCASP1			0x0005
+#define K2G_DEV_MCASP2			0x0006
+#define K2G_DEV_DCAN0			0x0008
+#define K2G_DEV_DCAN1			0x0009
+#define K2G_DEV_EMIF0			0x000a
+#define K2G_DEV_MMCHS0			0x000b
+#define K2G_DEV_MMCHS1			0x000c
+#define K2G_DEV_GPMC0			0x000d
+#define K2G_DEV_ELM0			0x000e
+#define K2G_DEV_SPI0			0x0010
+#define K2G_DEV_SPI1			0x0011
+#define K2G_DEV_SPI2			0x0012
+#define K2G_DEV_SPI3			0x0013
+#define K2G_DEV_ICSS0			0x0014
+#define K2G_DEV_ICSS1			0x0015
+#define K2G_DEV_USB0			0x0016
+#define K2G_DEV_USB1			0x0017
+#define K2G_DEV_NSS0			0x0018
+#define K2G_DEV_PCIE0			0x0019
+#define K2G_DEV_GPIO0			0x001b
+#define K2G_DEV_GPIO1			0x001c
+#define K2G_DEV_TIMER64_0		0x001d
+#define K2G_DEV_TIMER64_1		0x001e
+#define K2G_DEV_TIMER64_2		0x001f
+#define K2G_DEV_TIMER64_3		0x0020
+#define K2G_DEV_TIMER64_4		0x0021
+#define K2G_DEV_TIMER64_5		0x0022
+#define K2G_DEV_TIMER64_6		0x0023
+#define K2G_DEV_MSGMGR0			0x0025
+#define K2G_DEV_BOOTCFG0		0x0026
+#define K2G_DEV_ARM_BOOTROM0		0x0027
+#define K2G_DEV_DSP_BOOTROM0		0x0029
+#define K2G_DEV_DEBUGSS0		0x002b
+#define K2G_DEV_UART0			0x002c
+#define K2G_DEV_UART1			0x002d
+#define K2G_DEV_UART2			0x002e
+#define K2G_DEV_EHRPWM0			0x002f
+#define K2G_DEV_EHRPWM1			0x0030
+#define K2G_DEV_EHRPWM2			0x0031
+#define K2G_DEV_EHRPWM3			0x0032
+#define K2G_DEV_EHRPWM4			0x0033
+#define K2G_DEV_EHRPWM5			0x0034
+#define K2G_DEV_EQEP0			0x0035
+#define K2G_DEV_EQEP1			0x0036
+#define K2G_DEV_EQEP2			0x0037
+#define K2G_DEV_ECAP0			0x0038
+#define K2G_DEV_ECAP1			0x0039
+#define K2G_DEV_I2C0			0x003a
+#define K2G_DEV_I2C1			0x003b
+#define K2G_DEV_I2C2			0x003c
+#define K2G_DEV_EDMA0			0x003f
+#define K2G_DEV_SEMAPHORE0		0x0040
+#define K2G_DEV_INTC0			0x0041
+#define K2G_DEV_GIC0			0x0042
+#define K2G_DEV_QSPI0			0x0043
+#define K2G_DEV_ARM_64B_COUNTER0	0x0044
+#define K2G_DEV_TETRIS0			0x0045
+#define K2G_DEV_CGEM0			0x0046
+#define K2G_DEV_MSMC0			0x0047
+#define K2G_DEV_CBASS0			0x0049
+#define K2G_DEV_BOARD0			0x004c
+#define K2G_DEV_EDMA1			0x004f
+
+#endif
-- 
2.11.0
