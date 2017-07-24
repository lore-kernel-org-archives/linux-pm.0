From: Mikko Perttunen <mperttunen@nvidia.com>
Subject: [PATCH v2 1/5] arm64: tegra: Add BPMP thermal sensor to Tegra186
Date: Mon, 24 Jul 2017 19:29:14 +0300
Message-ID: <20170724162918.21050-1-mperttunen@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
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

This adds the thermal sensor device provided by the BPMP, and the
relevant thermal sensors to the Tegra186 device tree.

Signed-off-by: Mikko Perttunen <mperttunen@nvidia.com>
---
v2:
- added trips and cooling-maps nodes
 arch/arm64/boot/dts/nvidia/tegra186.dtsi | 103 +++++++++++++++++++++++++++++++
 1 file changed, 103 insertions(+)

diff --git a/arch/arm64/boot/dts/nvidia/tegra186.dtsi b/arch/arm64/boot/dts/nvidia/tegra186.dtsi
index 0b0552c9f7dd..6adcf25e13d1 100644
--- a/arch/arm64/boot/dts/nvidia/tegra186.dtsi
+++ b/arch/arm64/boot/dts/nvidia/tegra186.dtsi
@@ -4,6 +4,7 @@
 #include <dt-bindings/mailbox/tegra186-hsp.h>
 #include <dt-bindings/power/tegra186-powergate.h>
 #include <dt-bindings/reset/tegra186-reset.h>
+#include <dt-bindings/thermal/tegra186-bpmp-thermal.h>
 
 / {
 	compatible = "nvidia,tegra186";
@@ -451,6 +452,108 @@
 			#size-cells = <0>;
 			status = "disabled";
 		};
+
+		bpmp_thermal: thermal {
+			compatible = "nvidia,tegra186-bpmp-thermal";
+			#thermal-sensor-cells = <1>;
+		};
+	};
+
+	thermal-zones {
+		a57 {
+			polling-delay = <0>;
+			polling-delay-passive = <1000>;
+
+			thermal-sensors =
+				<&bpmp_thermal TEGRA186_BPMP_THERMAL_ZONE_CPU>;
+
+			trips {
+				critical {
+					temperature = <101000>;
+					hysteresis = <0>;
+					type = "critical";
+				};
+			};
+
+			cooling-maps {
+			};
+		};
+
+		denver {
+			polling-delay = <0>;
+			polling-delay-passive = <1000>;
+
+			thermal-sensors =
+				<&bpmp_thermal TEGRA186_BPMP_THERMAL_ZONE_AUX>;
+
+			trips {
+				critical {
+					temperature = <101000>;
+					hysteresis = <0>;
+					type = "critical";
+				};
+			};
+
+			cooling-maps {
+			};
+		};
+
+		gpu {
+			polling-delay = <0>;
+			polling-delay-passive = <1000>;
+
+			thermal-sensors =
+				<&bpmp_thermal TEGRA186_BPMP_THERMAL_ZONE_GPU>;
+
+			trips {
+				critical {
+					temperature = <101000>;
+					hysteresis = <0>;
+					type = "critical";
+				};
+			};
+
+			cooling-maps {
+			};
+		};
+
+		pll {
+			polling-delay = <0>;
+			polling-delay-passive = <1000>;
+
+			thermal-sensors =
+				<&bpmp_thermal TEGRA186_BPMP_THERMAL_ZONE_PLLX>;
+
+			trips {
+				critical {
+					temperature = <101000>;
+					hysteresis = <0>;
+					type = "critical";
+				};
+			};
+
+			cooling-maps {
+			};
+		};
+
+		always_on {
+			polling-delay = <0>;
+			polling-delay-passive = <1000>;
+
+			thermal-sensors =
+				<&bpmp_thermal TEGRA186_BPMP_THERMAL_ZONE_AO>;
+
+			trips {
+				critical {
+					temperature = <101000>;
+					hysteresis = <0>;
+					type = "critical";
+				};
+			};
+
+			cooling-maps {
+			};
+		};
 	};
 
 	timer {
-- 
2.13.3
