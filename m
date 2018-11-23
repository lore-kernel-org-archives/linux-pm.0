From: Thierry Reding <thierry.reding@gmail.com>
Subject: [PATCH 2/3] arm64: tegra: Add thermal zones on Tegra194
Date: Fri, 23 Nov 2018 13:18:38 +0100
Message-ID: <20181123121839.18573-2-thierry.reding@gmail.com>
References: <20181123121839.18573-1-thierry.reding@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181123121839.18573-1-thierry.reding@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>
Cc: Jon Hunter <jonathanh@nvidia.com>, Mikko Perttunen <mperttunen@nvidia.com>, Rob Herring <robh+dt@kernel.org>, linux-tegra@vger.kernel.org, devicetree@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

From: Thierry Reding <treding@nvidia.com>

The NVIDIA Tegra194 SoC defines six thermal zones. Define all of them in
device tree.

Signed-off-by: Thierry Reding <treding@nvidia.com>
---
 arch/arm64/boot/dts/nvidia/tegra194.dtsi | 39 ++++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/arch/arm64/boot/dts/nvidia/tegra194.dtsi b/arch/arm64/boot/dts/nvidia/tegra194.dtsi
index cbba7395a286..39169f6b6166 100644
--- a/arch/arm64/boot/dts/nvidia/tegra194.dtsi
+++ b/arch/arm64/boot/dts/nvidia/tegra194.dtsi
@@ -5,6 +5,7 @@
 #include <dt-bindings/mailbox/tegra186-hsp.h>
 #include <dt-bindings/reset/tegra194-reset.h>
 #include <dt-bindings/power/tegra194-powergate.h>
+#include <dt-bindings/thermal/tegra194-bpmp-thermal.h>
 
 / {
 	compatible = "nvidia,tegra194";
@@ -938,6 +939,44 @@
 		mbox-names = "rx", "tx";
 	};
 
+	thermal-zones {
+		cpu {
+			thermal-sensors = <&{/bpmp/thermal}
+					   TEGRA194_BPMP_THERMAL_ZONE_CPU>;
+			status = "disabled";
+		};
+
+		gpu {
+			thermal-sensors = <&{/bpmp/thermal}
+					   TEGRA194_BPMP_THERMAL_ZONE_GPU>;
+			status = "disabled";
+		};
+
+		aux {
+			thermal-sensors = <&{/bpmp/thermal}
+					   TEGRA194_BPMP_THERMAL_ZONE_AUX>;
+			status = "disabled";
+		};
+
+		pllx {
+			thermal-sensors = <&{/bpmp/thermal}
+					   TEGRA194_BPMP_THERMAL_ZONE_PLLX>;
+			status = "disabled";
+		};
+
+		ao {
+			thermal-sensors = <&{/bpmp/thermal}
+					   TEGRA194_BPMP_THERMAL_ZONE_AO>;
+			status = "disabled";
+		};
+
+		tj {
+			thermal-sensors = <&{/bpmp/thermal}
+					   TEGRA194_BPMP_THERMAL_ZONE_TJ_MAX>;
+			status = "disabled";
+		};
+	};
+
 	timer {
 		compatible = "arm,armv8-timer";
 		interrupts = <GIC_PPI 13
-- 
2.19.1
