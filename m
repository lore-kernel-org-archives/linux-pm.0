From: Dawei Chien <dawei.chien@mediatek.com>
Subject: [RESEND][PATCH 2/3] arm64: dts: mt8173: Add thermal zone node.
Date: Tue, 15 Mar 2016 16:10:36 +0800
Message-ID: <1458029437-12846-3-git-send-email-dawei.chien@mediatek.com>
References: <1458029437-12846-1-git-send-email-dawei.chien@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailgw02.mediatek.com ([210.61.82.184]:21434 "EHLO
	mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S934259AbcCOIPO (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 15 Mar 2016 04:15:14 -0400
In-Reply-To: <1458029437-12846-1-git-send-email-dawei.chien@mediatek.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Matthias Brugger <matthias.bgg@gmail.com>
Cc: Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Daniel Kurtz <djkurtz@chromium.org>, Sascha Hauer <s.hauer@pengutronix.de>, Daniel Lezcano <daniel.lezcano@linaro.org>, Dawei Chien <dawei.chien@mediatek.com>, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, linux-mediatek@lists.infradead.org, srv_heupstream@mediatek.com, Sascha Hauer <kernel@pengutronix.de>, Punit Agrawal <punit.agrawal@arm.com>

This adds thermal zone node to Mediatek MT8173 dtsi file.

Signed-off-by: Dawei Chien <dawei.chien@mediatek.com>
---
This patch is base on patchset:
https://lkml.org/lkml/2015/11/30/239
---
 arch/arm64/boot/dts/mediatek/mt8173.dtsi |   43 ++++++++++++++++++++++++++++++
 1 file changed, 43 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8173.dtsi b/arch/arm64/boot/dts/mediatek/mt8173.dtsi
index 47151e8..f9c44cc 100644
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

