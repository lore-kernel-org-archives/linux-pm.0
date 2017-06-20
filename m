From: Tao Wang <kevin.wangtao@hisilicon.com>
Subject: [PATCH 1/3] dt-bindings: Document the hi3660 thermal sensor bindings
Date: Tue, 20 Jun 2017 11:40:33 +0800
Message-ID: <1497930035-60894-1-git-send-email-kevin.wangtao@hisilicon.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: rui.zhang@intel.com, edubezval@gmail.com, robh+dt@kernel.org, mark.rutland@arm.com, xuwei5@hisilicon.com, catalin.marinas@arm.com, will.deacon@arm.com
Cc: linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, sunzhaosheng@hisilicon.com, leo.yan@linaro.org, Tao Wang <kevin.wangtao@hisilicon.com>
List-Id: linux-pm@vger.kernel.org

This adds documentation of device tree bindings for the
thermal sensor controller of hi3660 SoC.

Signed-off-by: Tao Wang <kevin.wangtao@hisilicon.com>
---
 .../devicetree/bindings/thermal/hi3660-thermal.txt |   17 +++++++++++++++++
 1 file changed, 17 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/thermal/hi3660-thermal.txt

diff --git a/Documentation/devicetree/bindings/thermal/hi3660-thermal.txt b/Documentation/devicetree/bindings/thermal/hi3660-thermal.txt
new file mode 100644
index 0000000..c034670
--- /dev/null
+++ b/Documentation/devicetree/bindings/thermal/hi3660-thermal.txt
@@ -0,0 +1,17 @@
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
+		status = "ok";
+	 };
-- 
1.7.9.5
