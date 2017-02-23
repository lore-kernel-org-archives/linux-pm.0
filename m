From: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Subject: [PATCH 2/2] dt-bindings: power/supply: Add support for xmega16d4-battery
Date: Thu, 23 Feb 2017 18:38:12 +0100
Message-ID: <20170223173812.10740-2-enric.balletbo@collabora.com>
References: <20170223173812.10740-1-enric.balletbo@collabora.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170223173812.10740-1-enric.balletbo@collabora.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Add the documentation for binding of Toby Churchill SBS battery monitor
driver. The device is connected via SPI and is able to report different
battery characteristics.

Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
---
 .../devicetree/bindings/power/supply/xmega16d4-battery.txt   | 12 ++++++++++++
 1 file changed, 12 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/power/supply/xmega16d4-battery.txt

diff --git a/Documentation/devicetree/bindings/power/supply/xmega16d4-battery.txt b/Documentation/devicetree/bindings/power/supply/xmega16d4-battery.txt
new file mode 100644
index 0000000..c76db67
--- /dev/null
+++ b/Documentation/devicetree/bindings/power/supply/xmega16d4-battery.txt
@@ -0,0 +1,12 @@
+Binding for the Toby Churchill SBS battery monitor
+
+Required properties :
+ - compatible : "tcl,xmega16d4-battery"
+
+Example:
+
+	battery: smart-battery@0 {
+		compatible = "tcl,xmega16d4-battery";
+		reg = <0>;
+		spi-max-frequency = <100000>;
+	};
-- 
2.9.3
