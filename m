From: Daniel Mack <daniel@zonque.org>
Subject: [PATCH v3 1/4] dt-bindings: w1: document generic onewire and DS2760 bindings
Date: Fri, 29 Jun 2018 19:31:34 +0200
Message-ID: <20180629173137.12690-2-daniel@zonque.org>
References: <20180629173137.12690-1-daniel@zonque.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180629173137.12690-1-daniel@zonque.org>
Sender: linux-kernel-owner@vger.kernel.org
To: zbr@ioremap.net, robh+dt@kernel.org, mark.rutland@arm.com, szabolcs.gyurko@tlt.hu
Cc: sre@kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, robert.jarzmik@free.fr, Daniel Mack <daniel@zonque.org>
List-Id: linux-pm@vger.kernel.org

This patch add a generic w1 bindings document that merely describes how
slave deviceses are grouped under master nodes. It also adds a specific
binding for the ds2760 battery monitor.

Signed-off-by: Daniel Mack <daniel@zonque.org>
---
 .../bindings/power/supply/maxim,ds2760.txt    | 29 +++++++++++++++++++
 .../devicetree/bindings/w1/w1-gpio.txt        |  6 ++++
 Documentation/devicetree/bindings/w1/w1.txt   | 18 ++++++++++++
 3 files changed, 53 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/power/supply/maxim,ds2760.txt
 create mode 100644 Documentation/devicetree/bindings/w1/w1.txt

diff --git a/Documentation/devicetree/bindings/power/supply/maxim,ds2760.txt b/Documentation/devicetree/bindings/power/supply/maxim,ds2760.txt
new file mode 100644
index 000000000000..a39d1ada48f2
--- /dev/null
+++ b/Documentation/devicetree/bindings/power/supply/maxim,ds2760.txt
@@ -0,0 +1,29 @@
+Devicetree bindings for Maxim DS2760
+====================================
+
+The ds2760 is a w1 slave device and must hence have its sub-node in DT
+under a w1 bus master node.
+
+The device exposes a power supply, so the details described in
+Documentation/devicetree/bindings/power/supply/power_supply.txt apply.
+
+Required properties:
+- compatible: must be "maxim,ds2760"
+
+Optional properties:
+- power-supplies:	Refers to one or more power supplies connected to
+			this battery.
+- maxim,pmod-enabled:	This boolean property enables the DS2760 to enter
+			sleep mode when the DQ line goes low for greater
+			than 2 seconds and leave sleep Mode when the DQ
+			line goes high.
+- maxim,cache-time:	Time im milliseconds to cache the data for. When
+			this time expires, the values are read again from
+			the hardware. Defaults to 1000.
+- maxim,rated-capacity:	The rated capacity of the battery, in mAh.
+			If not specified, the value stored in the
+			non-volatile chip memory is used.
+- maxim,current-accumulator:
+			The current accumulator value in mAh.
+			If not specified, the value stored in the
+			non-volatile chip memory is used.
diff --git a/Documentation/devicetree/bindings/w1/w1-gpio.txt b/Documentation/devicetree/bindings/w1/w1-gpio.txt
index 6e09c35d9f1a..6694317bcbed 100644
--- a/Documentation/devicetree/bindings/w1/w1-gpio.txt
+++ b/Documentation/devicetree/bindings/w1/w1-gpio.txt
@@ -13,10 +13,16 @@ Optional properties:
  - linux,open-drain: if specified, the data pin is considered in
 		     open-drain mode.
 
+Also refer to the generic w1.txt document.
+
 Examples:
 
 	onewire@0 {
 		compatible = "w1-gpio";
 		gpios = <&gpio 126 0>, <&gpio 105 0>;
+
+		battery {
+			compatible = "maxim,ds2760";
+		};
 	};
 
diff --git a/Documentation/devicetree/bindings/w1/w1.txt b/Documentation/devicetree/bindings/w1/w1.txt
new file mode 100644
index 000000000000..6ac103f972a0
--- /dev/null
+++ b/Documentation/devicetree/bindings/w1/w1.txt
@@ -0,0 +1,18 @@
+Generic devicetree bindings for onewire (w1) busses
+===================================================
+
+Onewire busses are described through nodes of their master bus controller.
+Slave devices are listed as sub-nodes of such master devices. For now, one
+one slave is allowed per bus master.
+
+
+Example:
+
+	onewire {
+		compatible = "w1-gpio";
+		gpios = <&gpio 0 GPIO_ACTIVE_HIGH>;
+
+		battery {
+			compatible = "maxim,ds2760";
+		};
+	};
-- 
2.17.1
