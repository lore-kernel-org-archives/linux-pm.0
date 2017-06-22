From: Tao Wang <kevin.wangtao@hisilicon.com>
Subject: [Patch v2 1/3] dt-bindings: Document the hi3660 thermal sensor bindings
Date: Thu, 22 Jun 2017 11:42:01 +0800
Message-ID: <1498102923-68481-1-git-send-email-kevin.wangtao@hisilicon.com>
References: <1497930035-60894-3-git-send-email-kevin.wangtao@hisilicon.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from szxga02-in.huawei.com ([45.249.212.188]:8809 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752062AbdFVDq1 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 21 Jun 2017 23:46:27 -0400
In-Reply-To: <1497930035-60894-3-git-send-email-kevin.wangtao@hisilicon.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rui.zhang@intel.com, edubezval@gmail.com, robh+dt@kernel.org, mark.rutland@arm.com, xuwei5@hisilicon.com, catalin.marinas@arm.com, will.deacon@arm.com
Cc: linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, sunzhaosheng@hisilicon.com, leo.yan@linaro.org, Tao Wang <kevin.wangtao@hisilicon.com>

This adds documentation of device tree bindings for the
thermal sensor controller of hi3660 SoC.

Signed-off-by: Tao Wang <kevin.wangtao@hisilicon.com>
---
Changes in v2:
- remove redundant property

 .../devicetree/bindings/thermal/hi3660-thermal.txt |   16 ++++++++++++++++
 1 file changed, 16 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/thermal/hi3660-thermal.txt

diff --git a/Documentation/devicetree/bindings/thermal/hi3660-thermal.txt b/Documentation/devicetree/bindings/thermal/hi3660-thermal.txt
new file mode 100644
index 0000000..f3dddcf
--- /dev/null
+++ b/Documentation/devicetree/bindings/thermal/hi3660-thermal.txt
@@ -0,0 +1,16 @@
+* Temperature Sensor on hisilicon hi3660 SoC
+
+** Required properties :
+
+- compatible: "hisilicon,thermal-hi3660".
+- reg: physical base address of thermal sensor and length of memory mapped
+  region.
+- #thermal-sensor-cells: Should be 1. See ./thermal.txt for a description.
+
+Example :
+
+	tsensor: tsensor {
+		compatible = "hisilicon,thermal-hi3660";
+		reg = <0x0 0xfff30000 0x0 0x1000>;
+		#thermal-sensor-cells = <1>;
+	 };
-- 
1.7.9.5
