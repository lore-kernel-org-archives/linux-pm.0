From: Icenowy Zheng <icenowy-h8G6r0blFSE@public.gmane.org>
Subject: [PATCH 08/10] ARM: sun8i: h3: add operating-points-v2
 table for CPU
Date: Sun, 23 Jul 2017 18:27:47 +0800
Message-ID: <20170723102749.17323-9-icenowy@aosc.io>
References: <20170723102749.17323-1-icenowy@aosc.io>
Reply-To: icenowy-h8G6r0blFSE@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sunxi+bncBDS6XAN6ZADRBBPV2HFQKGQEZCQ6CJQ-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
In-Reply-To: <20170723102749.17323-1-icenowy-h8G6r0blFSE@public.gmane.org>
List-Post: <https://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <https://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <https://groups.google.com/group/linux-sunxi
List-Subscribe: <https://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <https://groups.google.com/group/linux-sunxi/subscribe>
To: Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-clk-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, Icenowy Zheng <icenowy-h8G6r0blFSE@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

The CPU on Allwinner H3 can do dynamic frequency scaling.

Add a DVFS table based on the one tweaked by Armbian developers, which
are proven to work stably on BSP kernels.

Frequencies higher than 1008MHz are temporarily dropped in the table, as
they may lead to over voltage on boards without proper regulator
settings or over temperature on boards with proper regulator settings.
They will be added back once regulator settings are ready and thermal
sensor driver is merged.

In order to satisfy all different regulators (SY8106A which is 50mV per
level, SY8113B which have two states: 1.1V and 1.3V, and some board with
non-tweakable regulators), all the OPPs are defined with a range which has
the target value as the minimum allowed value, and 1.3V (the highest
VDD-CPUX voltage suggested by the datasheet) as the maximum allowed value.
It's proven to work well with a board with SY8113B.

Signed-off-by: Icenowy Zheng <icenowy-h8G6r0blFSE@public.gmane.org>
---
 arch/arm/boot/dts/sun8i-h3.dtsi | 38 +++++++++++++++++++++++++++++++++++++-
 1 file changed, 37 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/sun8i-h3.dtsi b/arch/arm/boot/dts/sun8i-h3.dtsi
index b36f9f423c39..a0cee17fe44b 100644
--- a/arch/arm/boot/dts/sun8i-h3.dtsi
+++ b/arch/arm/boot/dts/sun8i-h3.dtsi
@@ -43,32 +43,68 @@
 #include "sunxi-h3-h5.dtsi"
 
 / {
+	cpu0_opp_table: opp_table0 {
+		compatible = "operating-points-v2";
+		opp-shared;
+
+		opp@480000000 {
+			opp-hz = /bits/ 64 <480000000>;
+			opp-microvolt = <980000 980000 1300000>;
+			clock-latency-ns = <244144>; /* 8 32k periods */
+		};
+
+		opp@648000000 {
+			opp-hz = /bits/ 64 <816000000>;
+			opp-microvolt = <1020000 1020000 1300000>;
+			clock-latency-ns = <244144>; /* 8 32k periods */
+		};
+
+		opp@912000000 {
+			opp-hz = /bits/ 64 <960000000>;
+			opp-microvolt = <1080000 1080000 1300000>;
+			clock-latency-ns = <244144>; /* 8 32k periods */
+		};
+
+		opp@1008000000 {
+			opp-hz = /bits/ 64 <1008000000>;
+			opp-microvolt = <1140000 1140000 1300000>;
+			clock-latency-ns = <244144>; /* 8 32k periods */
+		};
+	};
+
 	cpus {
 		#address-cells = <1>;
 		#size-cells = <0>;
 
-		cpu@0 {
+		cpu0: cpu@0 {
 			compatible = "arm,cortex-a7";
 			device_type = "cpu";
 			reg = <0>;
+			clocks = <&ccu CLK_CPUX>;
+			clock-names = "cpu";
+			operating-points-v2 = <&cpu0_opp_table>;
+			#cooling-cells = <0x2>;
 		};
 
 		cpu@1 {
 			compatible = "arm,cortex-a7";
 			device_type = "cpu";
 			reg = <1>;
+			operating-points-v2 = <&cpu0_opp_table>;
 		};
 
 		cpu@2 {
 			compatible = "arm,cortex-a7";
 			device_type = "cpu";
 			reg = <2>;
+			operating-points-v2 = <&cpu0_opp_table>;
 		};
 
 		cpu@3 {
 			compatible = "arm,cortex-a7";
 			device_type = "cpu";
 			reg = <3>;
+			operating-points-v2 = <&cpu0_opp_table>;
 		};
 	};
 
-- 
2.13.0
