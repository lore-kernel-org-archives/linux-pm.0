From: Sascha Hauer <s.hauer@pengutronix.de>
Subject: [PATCH 1/3] dt-bindings: thermal: Add binding document for Mediatek thermal controller
Date: Tue, 21 Jul 2015 09:59:24 +0200
Message-ID: <1437465566-16299-2-git-send-email-s.hauer@pengutronix.de>
References: <1437465566-16299-1-git-send-email-s.hauer@pengutronix.de>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:46984 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751842AbbGUH7b (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 21 Jul 2015 03:59:31 -0400
In-Reply-To: <1437465566-16299-1-git-send-email-s.hauer@pengutronix.de>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>
Cc: linux-kernel@vger.kernel.org, kernel@pengutronix.de, linux-mediatek@lists.infradead.org, linux-arm-kernel@lists.infradead.org, Matthias Brugger <matthias.bgg@gmail.com>, Sascha Hauer <s.hauer@pengutronix.de>

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 .../bindings/thermal/mediatek-thermal.txt          | 38 ++++++++++++++++++++++
 1 file changed, 38 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/thermal/mediatek-thermal.txt

diff --git a/Documentation/devicetree/bindings/thermal/mediatek-thermal.txt b/Documentation/devicetree/bindings/thermal/mediatek-thermal.txt
new file mode 100644
index 0000000..d90e4dc
--- /dev/null
+++ b/Documentation/devicetree/bindings/thermal/mediatek-thermal.txt
@@ -0,0 +1,38 @@
+* Mediatek Thermal
+
+This describes the device tree binding for the Mediatek thermal controller
+which measures the on-SoC temperatures. This device does not have its own ADC,
+instead it directly controls the AUXADC via AHB bus accesses. For this reason
+this device needs phandles to the AUXADC. Also it controls a mux in the
+apmixedsys register space via AHB bus accesses, so a phandle to the APMIXEDSYS
+is also needed.
+
+Required properties:
+- compatible: "mediatek,mt8173-thermal"
+- reg: Address range of the thermal controller
+- interrupts: IRQ for the thermal controller
+- clocks, clock-names: Clocks needed for the thermal controller. required
+                       clocks are:
+		"therm":	Main clock needed for register access
+		"auxadc":	The AUXADC clock
+- resets, reset-names: Reference to the reset controller controlling the thermal
+                       controller. Required reset-names:
+		"therm":	The main reset line
+- auxadc: A phandle to the AUXADC which the thermal controller uses
+- apmixedsys: A phandle to the APMIXEDSYS controller.
+- #thermal-sensor-cells : Should be 1. See ./thermal.txt for a description
+
+Example:
+
+	thermal: thermal@1100b000 {
+		#thermal-sensor-cells = <1>;
+		compatible = "mediatek,mt8173-thermal";
+		reg = <0 0x1100b000 0 0x1000>;
+		interrupts = <0 70 IRQ_TYPE_LEVEL_LOW>;
+		clocks = <&pericfg CLK_PERI_THERM>, <&pericfg CLK_PERI_AUXADC>;
+		clock-names = "therm", "auxadc";
+		resets = <&pericfg MT8173_PERI_THERM_SW_RST>;
+		reset-names = "therm";
+		auxadc = <&auxadc>;
+		apmixedsys = <&apmixedsys>;
+	};
-- 
2.1.4

