From: Nicolas Saenz Julienne <nicolas.saenz@prodys.net>
Subject: [PATCH 2/2] dt-bindings: power: add bindings for sbs-charger
Date: Wed, 23 Nov 2016 12:20:44 +0100
Message-ID: <1479900044-19270-3-git-send-email-nicolas.saenz@prodys.net>
References: <1479900044-19270-1-git-send-email-nicolas.saenz@prodys.net>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from host.prodys.net ([89.248.106.65]:38852 "EHLO host.prodys.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S935665AbcKWLVL (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 23 Nov 2016 06:21:11 -0500
In-Reply-To: <1479900044-19270-1-git-send-email-nicolas.saenz@prodys.net>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: sre@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-pm@vger.kernel.org, nicolas.saenz@prodys.net

Adds device tree documentation for SBS charger compilant devices as defined
here: http://sbs-forum.org/specs/sbc110.pdf

Signed-off-by: Nicolas Saenz Julienne <nicolas.saenz@prodys.net>
---
 .../bindings/power/supply/sbs_sbs-charger.txt      | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/power/supply/sbs_sbs-charger.txt

diff --git a/Documentation/devicetree/bindings/power/supply/sbs_sbs-charger.txt b/Documentation/devicetree/bindings/power/supply/sbs_sbs-charger.txt
new file mode 100644
index 0000000..b18ee2a
--- /dev/null
+++ b/Documentation/devicetree/bindings/power/supply/sbs_sbs-charger.txt
@@ -0,0 +1,22 @@
+SBS sbs-charger
+~~~~~~~~~~
+
+Required properties :
+ - compatible : "sbs,sbs-charger"
+
+Optional properties :
+- interrupt-parent: Should be the phandle for the interrupt controller. Use in
+    conjunction with "interrupts".
+- interrupts: Interrupt mapping for GPIO IRQ. Use in conjunction with
+    "interrupt-parent". If an interrupt is not provided the driver will switch
+    automatically to polling.
+
+Example:
+
+	ltc4100@9 {
+		compatible = "sbs,sbs-charger";
+		reg = <0x9>;
+		interrupt-parent = <&gpio6>;
+		interrupts = <7 IRQ_TYPE_LEVEL_LOW>;
+	};
+
-- 
2.7.4

