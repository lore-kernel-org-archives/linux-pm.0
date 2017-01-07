From: Baoyou Xie <baoyou.xie@linaro.org>
Subject: [PATCH v1 1/3] dt: bindings: add thermal device driver for zx2967
Date: Sat,  7 Jan 2017 13:38:06 +0800
Message-ID: <1483767488-19778-1-git-send-email-baoyou.xie@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f169.google.com ([209.85.192.169]:35042 "EHLO
        mail-pf0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S940295AbdAGFii (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 7 Jan 2017 00:38:38 -0500
Received: by mail-pf0-f169.google.com with SMTP id f144so8416003pfa.2
        for <linux-pm@vger.kernel.org>; Fri, 06 Jan 2017 21:38:37 -0800 (PST)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rui.zhang@intel.com, edubezval@gmail.com, robh+dt@kernel.org, mark.rutland@arm.com, jun.nie@linaro.org, gregkh@linuxfoundation.org, davem@davemloft.net, geert+renesas@glider.be, akpm@linux-foundation.org, mchehab@kernel.org, linux@roeck-us.net
Cc: linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, shawnguo@kernel.org, baoyou.xie@linaro.org, xie.baoyou@zte.com.cn, chen.chaokai@zte.com.cn, wang.qiang01@zte.com.cn

This patch adds dt-binding documentation for zx2967 family thermal sensor.

Signed-off-by: Baoyou Xie <baoyou.xie@linaro.org>
---
 .../devicetree/bindings/thermal/zx2967-thermal.txt | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/thermal/zx2967-thermal.txt

diff --git a/Documentation/devicetree/bindings/thermal/zx2967-thermal.txt b/Documentation/devicetree/bindings/thermal/zx2967-thermal.txt
new file mode 100644
index 0000000..2633964
--- /dev/null
+++ b/Documentation/devicetree/bindings/thermal/zx2967-thermal.txt
@@ -0,0 +1,22 @@
+* ZTE zx2967 family Thermal
+
+Required Properties:
+- compatible: should be one of the following.
+    * zte,zx2967-thermal
+    * zte,zx296718-thermal
+- reg: physical base address of the controller and length of memory mapped
+    region.
+- clocks : Pairs of phandle and specifier referencing the controller's clocks.
+- clock-names: "tempsensor_gate" for the topcrm clock.
+	       "tempsensor_pclk" for the apb clock.
+- #thermal-sensor-cells: must be 0.
+
+Example:
+
+	tempsensor: tempsensor@148a000 {
+		compatible = "zte,zx2967-thermal";
+		reg = <0x0148a000 0x20>;
+		clocks = <&topcrm TEMPSENSOR_GATE>, <&audiocrm AUDIO_TS_PCLK>;
+		clock-names = "tempsensor_gate", "tempsensor_pclk";
+		#thermal-sensor-cells = <0>;
+	};
-- 
2.7.4

