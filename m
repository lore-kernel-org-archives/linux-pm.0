From: Dong Aisheng <aisheng.dong@nxp.com>
Subject: [PATCH 1/1] dt-bindings: thermal: imx: update the binding to new method
Date: Thu, 25 Jan 2018 14:37:49 +0800
Message-ID: <1516862269-25543-1-git-send-email-aisheng.dong@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-cys01nam02on0061.outbound.protection.outlook.com ([104.47.37.61]:34526
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751081AbeAYIZB (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 25 Jan 2018 03:25:01 -0500
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org, devicetree@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, linux-imx@nxp.com, Dong Aisheng <aisheng.dong@nxp.com>, Shawn Guo <shawn.guo@linaro.org>, Leonard Crestez <leonard.crestez@nxp.com>, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>

Due to the old method has already been marked as deprecated in binding
doc, so obviously it's better to update the example to new bindings
as well.

Cc: Shawn Guo <shawn.guo@linaro.org>
Cc: Leonard Crestez <leonard.crestez@nxp.com>
Cc: Zhang Rui <rui.zhang@intel.com>
Cc: Eduardo Valentin <edubezval@gmail.com>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
---
 .../devicetree/bindings/thermal/imx-thermal.txt    | 25 ++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/Documentation/devicetree/bindings/thermal/imx-thermal.txt b/Documentation/devicetree/bindings/thermal/imx-thermal.txt
index 28be51a..379eb76 100644
--- a/Documentation/devicetree/bindings/thermal/imx-thermal.txt
+++ b/Documentation/devicetree/bindings/thermal/imx-thermal.txt
@@ -22,7 +22,32 @@ Optional properties:
 - clocks : thermal sensor's clock source.
 
 Example:
+ocotp: ocotp@21bc000 {
+	#address-cells = <1>;
+	#size-cells = <1>;
+	compatible = "fsl,imx6sx-ocotp", "syscon";
+	reg = <0x021bc000 0x4000>;
+	clocks = <&clks IMX6SX_CLK_OCOTP>;
 
+	tempmon_calib: calib@38 {
+		reg = <0x38 4>;
+	};
+
+	tempmon_temp_grade: temp-grade@20 {
+		reg = <0x20 4>;
+	};
+};
+
+tempmon: tempmon {
+	compatible = "fsl,imx6sx-tempmon", "fsl,imx6q-tempmon";
+	interrupts = <GIC_SPI 49 IRQ_TYPE_LEVEL_HIGH>;
+	fsl,tempmon = <&anatop>;
+	nvmem-cells = <&tempmon_calib>, <&tempmon_temp_grade>;
+	nvmem-cell-names = "calib", "temp_grade";
+	clocks = <&clks IMX6SX_CLK_PLL3_USB_OTG>;
+};
+
+Legacy method (Deprecated):
 tempmon {
 	compatible = "fsl,imx6q-tempmon";
 	fsl,tempmon = <&anatop>;
-- 
2.7.4
