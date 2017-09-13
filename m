From: =?UTF-8?q?Niklas=20S=C3=B6derlund?=
        <niklas.soderlund+renesas-1zkq55x86MTxsAP9Fp7wbw@public.gmane.org>
Subject: [PATCH 2/2] arm64: dts: r8a7796: add thermal cooling management
Date: Wed, 13 Sep 2017 12:59:09 +0200
Message-ID: <20170913105909.13230-3-niklas.soderlund+renesas@ragnatech.se>
References: <20170913105909.13230-1-niklas.soderlund+renesas@ragnatech.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170913105909.13230-1-niklas.soderlund+renesas-1zkq55x86MTxsAP9Fp7wbw@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Simon Horman <horms-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org>, Magnus Damm <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: linux-renesas-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, =?UTF-8?q?Niklas=20S=C3=B6derlund?= <niklas.soderlund+renesas-1zkq55x86MTxsAP9Fp7wbw@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

Add nodes and properties for thermal cooling management support.

Signed-off-by: Niklas Söderlund <niklas.soderlund+renesas-1zkq55x86MTxsAP9Fp7wbw@public.gmane.org>
---
 arch/arm64/boot/dts/renesas/r8a7796.dtsi | 38 ++++++++++++++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r8a7796.dtsi b/arch/arm64/boot/dts/renesas/r8a7796.dtsi
index 2905a3b953aab145..0b805dc30925e9be 100644
--- a/arch/arm64/boot/dts/renesas/r8a7796.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a7796.dtsi
@@ -53,6 +53,7 @@
 				<&cluster0_opp_tb3>, <&cluster0_opp_tb4>,
 				<&cluster0_opp_tb5>, <&cluster0_opp_tb6>,
 				<&cluster0_opp_tb7>;
+			#cooling-cells = <2>;
 		};
 
 		a57_1: cpu@1 {
@@ -67,6 +68,7 @@
 				<&cluster0_opp_tb3>, <&cluster0_opp_tb4>,
 				<&cluster0_opp_tb5>, <&cluster0_opp_tb6>,
 				<&cluster0_opp_tb7>;
+			#cooling-cells = <2>;
 		};
 
 		a53_0: cpu@100 {
@@ -2116,12 +2118,24 @@
 				thermal-sensors = <&tsc 0>;
 
 				trips {
+					sensor1_passive: sensor1-passive {
+						temperature = <95000>;
+						hysteresis = <2000>;
+						type = "passive";
+					};
 					sensor1_crit: sensor1-crit {
 						temperature = <120000>;
 						hysteresis = <2000>;
 						type = "critical";
 					};
 				};
+
+				cooling-maps {
+					map0 {
+						trip = <&sensor1_passive>;
+						cooling-device = <&a57_0 5 5>;
+					};
+				};
 			};
 
 			sensor_thermal2: sensor-thermal2 {
@@ -2130,12 +2144,24 @@
 				thermal-sensors = <&tsc 1>;
 
 				trips {
+					sensor2_passive: sensor2-passive {
+						temperature = <95000>;
+						hysteresis = <2000>;
+						type = "passive";
+					};
 					sensor2_crit: sensor2-crit {
 						temperature = <120000>;
 						hysteresis = <2000>;
 						type = "critical";
 					};
 				};
+
+				cooling-maps {
+					map0 {
+						trip = <&sensor2_passive>;
+						cooling-device = <&a57_0 5 5>;
+					};
+				};
 			};
 
 			sensor_thermal3: sensor-thermal3 {
@@ -2144,12 +2170,24 @@
 				thermal-sensors = <&tsc 2>;
 
 				trips {
+					sensor3_passive: sensor3-passive {
+						temperature = <95000>;
+						hysteresis = <2000>;
+						type = "passive";
+					};
 					sensor3_crit: sensor3-crit {
 						temperature = <120000>;
 						hysteresis = <2000>;
 						type = "critical";
 					};
 				};
+
+				cooling-maps {
+					map0 {
+						trip = <&sensor3_passive>;
+						cooling-device = <&a57_0 5 5>;
+					};
+				};
 			};
 		};
 
-- 
2.14.1

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
