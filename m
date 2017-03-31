From: =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>
Subject: [PATCH V4 1/2] dt-bindings: thermal: add support for Broadcom's Northstar thermal
Date: Fri, 31 Mar 2017 22:11:23 +0200
Message-ID: <20170331201124.656-1-zajec5@gmail.com>
References: <20170331073132.21457-2-zajec5@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-lf0-f68.google.com ([209.85.215.68]:34080 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932960AbdCaULe (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 31 Mar 2017 16:11:34 -0400
In-Reply-To: <20170331073132.21457-2-zajec5@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>
Cc: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Stephen Warren <swarren@wwwdotorg.org>, Lee Jones <lee@kernel.org>, Eric Anholt <eric@anholt.net>, Florian Fainelli <f.fainelli@gmail.com>, Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>, bcm-kernel-feedback-list@broadcom.com, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linux-rpi-kernel@lists.infradead.org, linux-arm-kernel@lists.infradead.org, =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>

From: Rafał Miłecki <rafal@milecki.pl>

This commit documents binding for thermal used in Northstar family SoCs.

Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
---
V3: Add thermal-zones to the example
    Rob: Because of this update, I didn't include Acked-by I got for V2
---
 .../devicetree/bindings/thermal/brcm,ns-thermal    | 26 ++++++++++++++++++++++
 1 file changed, 26 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/thermal/brcm,ns-thermal

diff --git a/Documentation/devicetree/bindings/thermal/brcm,ns-thermal b/Documentation/devicetree/bindings/thermal/brcm,ns-thermal
new file mode 100644
index 000000000000..c561c7349f17
--- /dev/null
+++ b/Documentation/devicetree/bindings/thermal/brcm,ns-thermal
@@ -0,0 +1,26 @@
+* Broadcom Northstar Thermal
+
+This binding describes thermal sensor that is part of Northstar's DMU (Device
+Management Unit).
+
+Required properties:
+- compatible : Must be "brcm,ns-thermal"
+- reg : iomem address range of PVTMON registers
+- #thermal-sensor-cells : Should be <0>
+
+Example:
+
+thermal: thermal@1800c2c0 {
+	compatible = "brcm,ns-thermal";
+	reg = <0x1800c2c0 0x10>;
+	#thermal-sensor-cells = <0>;
+};
+
+thermal-zones {
+	cpu_thermal: cpu-thermal {
+		polling-delay-passive = <0>;
+		polling-delay = <1000>;
+		coefficients = <(-556) 418000>;
+		thermal-sensors = <&thermal>;
+	};
+};
-- 
2.11.0
