From: Xinwei Kong <kong.kongxinwei@hisilicon.com>
Subject: [PATCH RESEND v4 1/2] dt-bindings: Document the hi6220 thermal sensor bindings
Date: Mon, 4 May 2015 10:52:19 +0800
Message-ID: <1430707940-14468-2-git-send-email-kong.kongxinwei@hisilicon.com>
References: <1430707940-14468-1-git-send-email-kong.kongxinwei@hisilicon.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from szxga01-in.huawei.com ([58.251.152.64]:30541 "EHLO
	szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751602AbbEDCzL (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sun, 3 May 2015 22:55:11 -0400
In-Reply-To: <1430707940-14468-1-git-send-email-kong.kongxinwei@hisilicon.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rui.zhuang@intel.com, edubezval@gmail.com, amit.kucheria@linaro.org, punit.agrawal@arm.com, Javi.Merino@arm.com, jorge.ramirez-ortiz@linaro.org, haojian.zhuang@linaro.org, linux-pm@vger.kernel.org
Cc: linuxarm@huawei.com, devicetree@vger.kernel.org, dan.zhao@hisilicon.com, liguozhu@hisilicon.com, mporter@konsulko.com, gongyu@hisilicon.com, guodong.xu@linaro.org, robh@kernel.org, leo.yan@linaro.org, zhenwei.wang@hisilicon.com, zhangfei.gao@linaro.org, z.liuxinliang@huawei.com, xuwei5@hisilicon.com, w.f@huawei.com, yuanzhichang@hisilicon.com, mark.rutland@arm.com

From: kongxinwei <kong.kongxinwei@hisilicon.com>

This adds documentation of device tree bindings for the
thermal sensor controller of hi6220 SoC.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
Signed-off-by: kongxinwei <kong.kongxinwei@hisilicon.com>
---
 .../bindings/thermal/hisilicon-thermal.txt         | 23 ++++++++++++++++++++++
 1 file changed, 23 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/thermal/hisilicon-thermal.txt

diff --git a/Documentation/devicetree/bindings/thermal/hisilicon-thermal.txt b/Documentation/devicetree/bindings/thermal/hisilicon-thermal.txt
new file mode 100644
index 0000000..b2a349f
--- /dev/null
+++ b/Documentation/devicetree/bindings/thermal/hisilicon-thermal.txt
@@ -0,0 +1,23 @@
+* Temperature Sensor on hisilicon SoCs
+
+** Required properties :
+
+- compatible: "hisilicon,tsensor".
+- reg: physical base address of thermal sensor and length of memory mapped
+  region.
+- interrupt: The interrupt number to the cpu. Defines the interrupt used
+  by SOCTHERM.
+- clock-names: Input clock name, should be 'thermal_clk'.
+- clocks: phandles for clock specified in "clock-names" property.
+- #thermal-sensor-cells: Should be 1. See ./thermal.txt for a description.
+
+Example :
+
+	tsensor: tsensor@0,f7030700 {
+		compatible = "hisilicon,tsensor";
+		reg = <0x0 0xf7030700 0x0 0x1000>;
+		interrupts = <0 7 0x4>;
+		clocks = <&clock_sys HI6220_TSENSOR_CLK>;
+		clock-names = "thermal_clk";
+		#thermal-sensor-cells = <1>;
+	}
-- 
1.9.1


