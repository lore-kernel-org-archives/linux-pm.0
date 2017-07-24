From: Mikko Perttunen <mperttunen@nvidia.com>
Subject: [PATCH v2 2/5] dt-bindings: Add bindings for nvidia,
 tegra186-bpmp-thermal
Date: Mon, 24 Jul 2017 19:29:15 +0300
Message-ID: <20170724162918.21050-2-mperttunen@nvidia.com>
References: <20170724162918.21050-1-mperttunen@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20170724162918.21050-1-mperttunen@nvidia.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: rui.zhang@intel.com, edubezval@gmail.com, thierry.reding@gmail.com, jonathanh@nvidia.com
Cc: linux-tegra@vger.kernel.org, Mikko Perttunen <mperttunen@nvidia.com>, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

In Tegra186, the BPMP (Boot and Power Management Processor) implements
an interface that is used to read system temperatures, including CPU
cluster and GPU temperatures. This binding describes the thermal sensor
that is exposed by BPMP.

Signed-off-by: Mikko Perttunen <mperttunen@nvidia.com>
Acked-by: Rob Herring <robh@kernel.org>
---
 .../thermal/nvidia,tegra186-bpmp-thermal.txt       | 32 ++++++++++++++++++++++
 .../dt-bindings/thermal/tegra186-bpmp-thermal.h    | 14 ++++++++++
 2 files changed, 46 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/thermal/nvidia,tegra186-bpmp-thermal.txt
 create mode 100644 include/dt-bindings/thermal/tegra186-bpmp-thermal.h

diff --git a/Documentation/devicetree/bindings/thermal/nvidia,tegra186-bpmp-thermal.txt b/Documentation/devicetree/bindings/thermal/nvidia,tegra186-bpmp-thermal.txt
new file mode 100644
index 000000000000..276387dd6815
--- /dev/null
+++ b/Documentation/devicetree/bindings/thermal/nvidia,tegra186-bpmp-thermal.txt
@@ -0,0 +1,32 @@
+NVIDIA Tegra186 BPMP thermal sensor
+
+In Tegra186, the BPMP (Boot and Power Management Processor) implements an
+interface that is used to read system temperatures, including CPU cluster
+and GPU temperatures. This binding describes the thermal sensor that is
+exposed by BPMP.
+
+The BPMP thermal node must be located directly inside the main BPMP node. See
+../firmware/nvidia,tegra186-bpmp.txt for details of the BPMP binding.
+
+This node represents a thermal sensor. See thermal.txt for details of the
+core thermal binding.
+
+Required properties:
+- compatible:
+    Array of strings.
+    One of:
+    - "nvidia,tegra186-bpmp-thermal".
+- #thermal-sensor-cells: Cell for sensor index.
+    Single-cell integer.
+    Must be <1>.
+
+Example:
+
+bpmp {
+	...
+
+	bpmp_thermal: thermal {
+		compatible = "nvidia,tegra186-bpmp-thermal";
+		#thermal-sensor-cells = <1>;
+	};
+};
diff --git a/include/dt-bindings/thermal/tegra186-bpmp-thermal.h b/include/dt-bindings/thermal/tegra186-bpmp-thermal.h
new file mode 100644
index 000000000000..a96b8fa31aab
--- /dev/null
+++ b/include/dt-bindings/thermal/tegra186-bpmp-thermal.h
@@ -0,0 +1,14 @@
+/*
+ * This header provides constants for binding nvidia,tegra186-bpmp-thermal.
+ */
+
+#ifndef _DT_BINDINGS_THERMAL_TEGRA186_BPMP_THERMAL_H
+#define _DT_BINDINGS_THERMAL_TEGRA186_BPMP_THERMAL_H
+
+#define TEGRA186_BPMP_THERMAL_ZONE_CPU 2
+#define TEGRA186_BPMP_THERMAL_ZONE_GPU 3
+#define TEGRA186_BPMP_THERMAL_ZONE_AUX 4
+#define TEGRA186_BPMP_THERMAL_ZONE_PLLX 5
+#define TEGRA186_BPMP_THERMAL_ZONE_AO 6
+
+#endif
-- 
2.13.3
