From: Dawei Chien <dawei.chien@mediatek.com>
Subject: [PATCH v2 2/2] arm64: dts: mt8173: Add thermal zone node for mt8173.
Date: Wed, 7 Oct 2015 20:22:41 +0800
Message-ID: <1444220561-26139-3-git-send-email-dawei.chien@mediatek.com>
References: <1444220561-26139-1-git-send-email-dawei.chien@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1444220561-26139-1-git-send-email-dawei.chien@mediatek.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Matthias Brugger <matthias.bgg@gmail.com>, Daniel Kurtz <djkurtz@chromium.org>, Sascha Hauer <s.hauer@pengutronix.de>, Daniel Lezcano <daniel.lezcano@linaro.org>, Dawei Chien <dawei.chien@mediatek.com>, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, linux-mediatek@lists.infradead.org, srv_heupstream@mediatek.com, Sascha Hauer <kernel@pengutronix.de>
List-Id: linux-pm@vger.kernel.org

From: "Dawei.Chien" <dawei.chien@mediatek.com>

Add thermal zone node to mt8173.dtsi.

Signed-off-by: Dawei.Chien <dawei.chien@mediatek.com>
---
This patch is base on
https://patchwork.kernel.org/patch/7249821/
https://patchwork.kernel.org/patch/7249861/
https://patchwork.kernel.org/patch/7249891/
---
 arch/arm64/boot/dts/mediatek/mt8173.dtsi |   44 ++++++++++++++++++++++++++++++
 1 file changed, 44 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8173.dtsi b/arch/arm64/boot/dts/mediatek/mt8173.dtsi
index 3b18f37..01a7c46c 100644
--- a/arch/arm64/boot/dts/mediatek/mt8173.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8173.dtsi
@@ -16,6 +16,7 @@
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 #include <dt-bindings/power/mt8173-power.h>
 #include <dt-bindings/reset-controller/mt8173-resets.h>
+#include <dt-bindings/thermal/mt8173.h>
 #include "mt8173-pinfunc.h"
 
 / {
@@ -116,6 +117,49 @@
 		clock-output-names = "clk32k";
 	};
 
+	thermal-zones {
+		cpu_thermal: cpu_thermal {
+			polling-delay-passive = <1000>; /* milliseconds */
+			polling-delay = <1000>; /* milliseconds */
+
+			thermal-sensors = <&thermal MT8173_THERMAL_ZONE_CA57>;
+			sustainable-power = <1500>;
+
+			trips {
+				threshold: trip-point@0 {
+					temperature = <68000>;
+					hysteresis = <2000>;
+					type = "passive";
+				};
+
+				target: trip-point@1 {
+					temperature = <85000>;
+					hysteresis = <2000>;
+					type = "passive";
+				};
+
+				cpu_crit: cpu_crit@0 {
+					temperature = <115000>;
+					hysteresis = <2000>;
+					type = "critical";
+				};
+			};
+
+			cooling-maps {
+				map@0 {
+					trip = <&target>;
+					cooling-device = <&cpu0 0 0>;
+					contribution = <1024>;
+				};
+				map@1 {
+					trip = <&target>;
+					cooling-device = <&cpu2 0 0>;
+					contribution = <2048>;
+				};
+			};
+		};
+	};
+
 	timer {
 		compatible = "arm,armv8-timer";
 		interrupt-parent = <&gic>;
-- 
1.7.9.5
