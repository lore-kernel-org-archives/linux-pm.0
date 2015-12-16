From: Dawei Chien <dawei.chien@mediatek.com>
Subject: [PATCH v6 2/3] arm64: dts: mt8173: Add thermal zone node.
Date: Wed, 16 Dec 2015 21:29:15 +0800
Message-ID: <1450272556-29770-3-git-send-email-dawei.chien@mediatek.com>
References: <1450272556-29770-1-git-send-email-dawei.chien@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1450272556-29770-1-git-send-email-dawei.chien@mediatek.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Matthias Brugger <matthias.bgg@gmail.com>, Daniel Kurtz <djkurtz@chromium.org>, Sascha Hauer <s.hauer@pengutronix.de>, Daniel Lezcano <daniel.lezcano@linaro.org>, Dawei Chien <dawei.chien@mediatek.com>, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, linux-mediatek@lists.infradead.org, srv_heupstream@mediatek.com, Sascha Hauer <kernel@pengutronix.de>, Punit Agrawal <punit.agrawal@arm.com>
List-Id: linux-pm@vger.kernel.org

This adds thermal zone node to Mediatek MT8173 dtsi file.

Signed-off-by: Dawei Chien <dawei.chien@mediatek.com>
---
This patch is base on patchset:
https://lkml.org/lkml/2015/11/30/239
---
 arch/arm64/boot/dts/mediatek/mt8173.dtsi |   43 ++++++++++++++++++++++++++++++
 1 file changed, 43 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8173.dtsi b/arch/arm64/boot/dts/mediatek/mt8173.dtsi
index fda805d..c962d94 100644
--- a/arch/arm64/boot/dts/mediatek/mt8173.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8173.dtsi
@@ -188,6 +188,49 @@
 		clock-output-names = "cpum_ck";
 	};
 
+	thermal-zones {
+		cpu_thermal: cpu_thermal {
+			polling-delay-passive = <1000>; /* milliseconds */
+			polling-delay = <1000>; /* milliseconds */
+
+			thermal-sensors = <&thermal>;
+			sustainable-power = <1500>; /* milliwatts */
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
