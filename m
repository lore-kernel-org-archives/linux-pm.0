From: Mikko Perttunen <mperttunen@nvidia.com>
Subject: [PATCH v2 1/4] of: Add bindings for nvidia,tegra124-soctherm
Date: Tue, 5 Aug 2014 15:18:54 +0300
Message-ID: <1407241137-32232-2-git-send-email-mperttunen@nvidia.com>
References: <1407241137-32232-1-git-send-email-mperttunen@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1407241137-32232-1-git-send-email-mperttunen@nvidia.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: rui.zhang@intel.com, edubezval@gmail.com, swarren@wwwdotorg.org, thierry.reding@gmail.com
Cc: linux-tegra@vger.kernel.org, Mikko Perttunen <mperttunen@nvidia.com>, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

This adds binding documentation and headers for the Tegra124
SOCTHERM device tree node.

Signed-off-by: Mikko Perttunen <mperttunen@nvidia.com>
---
 .../devicetree/bindings/thermal/tegra-soctherm.txt | 35 ++++++++++++++++++++++
 include/dt-bindings/thermal/tegra124-soctherm.h    | 13 ++++++++
 2 files changed, 48 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/thermal/tegra-soctherm.txt
 create mode 100644 include/dt-bindings/thermal/tegra124-soctherm.h

diff --git a/Documentation/devicetree/bindings/thermal/tegra-soctherm.txt b/Documentation/devicetree/bindings/thermal/tegra-soctherm.txt
new file mode 100644
index 0000000..3505c8f
--- /dev/null
+++ b/Documentation/devicetree/bindings/thermal/tegra-soctherm.txt
@@ -0,0 +1,35 @@
+Tegra124 SOCTHERM thermal management system
+
+Required properties :
+- compatible : "nvidia,tegra124-soctherm".
+- reg : Should contain 1 entry:
+  - SOCTHERM register set
+- interrupts : Defines the interrupt used by SOCTHERM
+- clocks : Must contain an entry for each entry in clock-names.
+  See ../clocks/clock-bindings.txt for details.
+- clock-names : Must include the following entries:
+  - tsensor
+  - soctherm
+- resets : Must contain an entry for each entry in reset-names.
+  See ../reset/reset.txt for details.
+- reset-names : Must include the following entries:
+  - soctherm
+- #thermal-sensor-cells : Should be 1. See ./thermal.txt for a description
+    of this property. See <dt-bindings/thermal/tegra124-soctherm.h> for a
+    list of valid values.
+
+
+Example :
+
+	soctherm@0,700e2000 {
+		compatible = "nvidia,tegra124-soctherm";
+		reg = <0x0 0x700e2000 0x0 0x1000>;
+		interrupts = <GIC_SPI 48 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&tegra_car TEGRA124_CLK_TSENSOR>,
+			<&tegra_car TEGRA124_CLK_SOC_THERM>;
+		clock-names = "tsensor", "soctherm";
+		resets = <&tegra_car 78>;
+		reset-names = "soctherm";
+
+		#thermal-sensor-cells = <1>;
+	};
diff --git a/include/dt-bindings/thermal/tegra124-soctherm.h b/include/dt-bindings/thermal/tegra124-soctherm.h
new file mode 100644
index 0000000..85aaf66
--- /dev/null
+++ b/include/dt-bindings/thermal/tegra124-soctherm.h
@@ -0,0 +1,13 @@
+/*
+ * This header provides constants for binding nvidia,tegra124-soctherm.
+ */
+
+#ifndef _DT_BINDINGS_THERMAL_TEGRA124_SOCTHERM_H
+#define _DT_BINDINGS_THERMAL_TEGRA124_SOCTHERM_H
+
+#define TEGRA124_SOCTHERM_SENSOR_CPU 0
+#define TEGRA124_SOCTHERM_SENSOR_MEM 1
+#define TEGRA124_SOCTHERM_SENSOR_GPU 2
+#define TEGRA124_SOCTHERM_SENSOR_PLLX 3
+
+#endif
-- 
1.8.1.5
