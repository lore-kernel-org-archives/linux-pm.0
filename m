From: Daniel Mack <daniel@zonque.org>
Subject: [PATCH v4 1/5] dt-bindings: w1: document generic onewire bindings
Date: Fri,  6 Jul 2018 07:35:48 +0200
Message-ID: <20180706053552.11438-2-daniel@zonque.org>
References: <20180706053552.11438-1-daniel@zonque.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180706053552.11438-1-daniel@zonque.org>
Sender: linux-kernel-owner@vger.kernel.org
To: zbr@ioremap.net, robh+dt@kernel.org, mark.rutland@arm.com, szabolcs.gyurko@tlt.hu
Cc: sre@kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, robert.jarzmik@free.fr, Daniel Mack <daniel@zonque.org>
List-Id: linux-pm@vger.kernel.org

This patch adds a generic w1 bindings document that describes how w1
slave deviceses are grouped under master nodes. It also augments the
existing w1-gpio.txt document a bit.

Signed-off-by: Daniel Mack <daniel@zonque.org>
---
 .../devicetree/bindings/w1/w1-gpio.txt        | 11 +++++---
 Documentation/devicetree/bindings/w1/w1.txt   | 25 +++++++++++++++++++
 2 files changed, 33 insertions(+), 3 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/w1/w1.txt

diff --git a/Documentation/devicetree/bindings/w1/w1-gpio.txt b/Documentation/devicetree/bindings/w1/w1-gpio.txt
index 6e09c35d9f1a..3d6554eac240 100644
--- a/Documentation/devicetree/bindings/w1/w1-gpio.txt
+++ b/Documentation/devicetree/bindings/w1/w1-gpio.txt
@@ -13,10 +13,15 @@ Optional properties:
  - linux,open-drain: if specified, the data pin is considered in
 		     open-drain mode.
 
+Also refer to the generic w1.txt document.
+
 Examples:
 
-	onewire@0 {
+	onewire {
 		compatible = "w1-gpio";
-		gpios = <&gpio 126 0>, <&gpio 105 0>;
-	};
+		gpios = <&gpio 0 GPIO_ACTIVE_HIGH>;
 
+		battery {
+			// ...
+		};
+	};
diff --git a/Documentation/devicetree/bindings/w1/w1.txt b/Documentation/devicetree/bindings/w1/w1.txt
new file mode 100644
index 000000000000..05f26b27d898
--- /dev/null
+++ b/Documentation/devicetree/bindings/w1/w1.txt
@@ -0,0 +1,25 @@
+Generic devicetree bindings for onewire (w1) busses
+===================================================
+
+Onewire busses are described through nodes of their master bus controller.
+Slave devices are listed as sub-nodes of such master devices. For now, only
+one slave is allowed per bus master.
+
+
+Example:
+
+	charger: charger {
+		compatible = "gpio-charger";
+		charger-type = "mains";
+		gpios = <&gpio 1 GPIO_ACTIVE_LOW>;
+	};
+
+	onewire {
+		compatible = "w1-gpio";
+		gpios = <&gpio 100 0>, <&gpio 101 0>;
+
+		battery {
+			compatible = "maxim,ds2760";
+			power-supplies = <&charger>;
+		};
+	};
-- 
2.17.1
