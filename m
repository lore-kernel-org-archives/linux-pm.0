From: Xinwei Kong <kong.kongxinwei@hisilicon.com>
Subject: [PATCH v4 1/2] dt-bindings: Document the hi6220 thermal sensor bindings
Date: Fri, 24 Apr 2015 11:51:22 +0800
Message-ID: <1429847483-10552-2-git-send-email-kong.kongxinwei@hisilicon.com>
References: <1429847483-10552-1-git-send-email-kong.kongxinwei@hisilicon.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from szxga02-in.huawei.com ([119.145.14.65]:43039 "EHLO
	szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754227AbbDXD4W (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 23 Apr 2015 23:56:22 -0400
In-Reply-To: <1429847483-10552-1-git-send-email-kong.kongxinwei@hisilicon.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rui.zhuang@intel.com, edubezval@gmail.com
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linuxarm@huawei.com, jorge.ramirez-ortiz@linaro.org, mporter@konsulko.com, robh+dt@kernel.org, bintian.wang@huawei.com, khilman@linaro.org, mturquette@linaro.org, rob.herring@linaro.org, zhangfei.gao@linaro.org, haojian.zhuang@linaro.org, xuwei5@hisilicon.com, yanhaifeng@gmail.com, linux@arm.linux.org.uk, guodong.xu@linaro.org, xuyiping@hisilicon.com, wangbinghui@hisilicon.com, zhenwei.wang@hisilicon.com, victor.lixin@hisilicon.com, puck.chen@hisilicon.com, dan.zhao@hisilicon.com, z.liuxinliang@huawei.com, heyunlei@huawei.com, w.f@huawei.com, liguozhu@hisilicon.com, gongyu@hisilicon.com, wanghuan4@hisilicon.com, yudongbin@hisilicon.com

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


