From: Daniel Mack <daniel@zonque.org>
Subject: [PATCH v4 2/5] dt-bindings: w1: document bindings for ds2760 battery monitor
Date: Fri,  6 Jul 2018 07:35:49 +0200
Message-ID: <20180706053552.11438-3-daniel@zonque.org>
References: <20180706053552.11438-1-daniel@zonque.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180706053552.11438-1-daniel@zonque.org>
Sender: linux-kernel-owner@vger.kernel.org
To: zbr@ioremap.net, robh+dt@kernel.org, mark.rutland@arm.com, szabolcs.gyurko@tlt.hu
Cc: sre@kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, robert.jarzmik@free.fr, Daniel Mack <daniel@zonque.org>
List-Id: linux-pm@vger.kernel.org

This patch adds the devicetree bindings for Maxim's ds2760 battery
monitors.

Signed-off-by: Daniel Mack <daniel@zonque.org>
---
 .../bindings/power/supply/maxim,ds2760.txt    | 26 +++++++++++++++++++
 1 file changed, 26 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/power/supply/maxim,ds2760.txt

diff --git a/Documentation/devicetree/bindings/power/supply/maxim,ds2760.txt b/Documentation/devicetree/bindings/power/supply/maxim,ds2760.txt
new file mode 100644
index 000000000000..55967a0bee11
--- /dev/null
+++ b/Documentation/devicetree/bindings/power/supply/maxim,ds2760.txt
@@ -0,0 +1,26 @@
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
+- maxim,cache-time-ms:	Time im milliseconds to cache the data for. When
+			this time expires, the values are read again from
+			the hardware. Defaults to 1000.
+- rated-capacity-microamp-hours:
+			The rated capacity of the battery, in mAh.
+			If not specified, the value stored in the
+			non-volatile chip memory is used.
-- 
2.17.1
