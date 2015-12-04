From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: [PATCH v3 07/10] ARM: dts: Exynos5800: fix CPU OPP
Date: Fri, 04 Dec 2015 18:30:32 +0100
Message-ID: <1449250235-9613-8-git-send-email-b.zolnierkie@samsung.com>
References: <1449250235-9613-1-git-send-email-b.zolnierkie@samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <1449250235-9613-1-git-send-email-b.zolnierkie@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Thomas Abraham <thomas.ab@samsung.com>, Sylwester Nawrocki <s.nawrocki@samsung.com>, Mike Turquette <mturquette@linaro.org>, Kukjin Kim <kgene.kim@samsung.com>, Kukjin Kim <kgene@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, Krzysztof Kozlowski <k.kozlowski@samsung.com>, Ben Gamari <ben@smart-cactus.org>
Cc: Tomasz Figa <tomasz.figa@gmail.com>, Lukasz Majewski <l.majewski@samsung.com>, Heiko Stuebner <heiko@sntech.de>, Chanwoo Choi <cw00.choi@samsung.com>, Kevin Hilman <khilman@linaro.org>, Javier Martinez Canillas <javier@osg.samsung.com>, Tobias Jakobi <tjakobi@math.uni-bielefeld.de>, Anand Moon <linux.amoon@gmail.com>, linux-samsung-soc@vger.kernel.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, b.zolnierkie@samsung.com, Doug Anderson <dianders@chromium.org>, Andreas Faerber <afaerber@suse.de>, Sachin Kamat <sachin.kamat@linaro.org>
List-Id: linux-pm@vger.kernel.org

Fix CPU operating points for Exynos5800 (it uses different
voltages than Exynos5420 and supports additional frequencies).
However don't use 2000MHz & 1900MHz OPPs (for A15 cores) and
1400MHz OPP (for A7 cores) until there is a separate DTS for
ODROID-XU3 Lite board (which doesn't support these higher
OPPs).

Based on Hardkernel's kernel for ODROID-XU3 board.

Changes by Ben Gamari:
- Port to operating-points-v2

Cc: Kukjin Kim <kgene.kim@samsung.com>
Cc: Doug Anderson <dianders@chromium.org>
Cc: Javier Martinez Canillas <javier@osg.samsung.com>
Cc: Andreas Faerber <afaerber@suse.de>
Cc: Sachin Kamat <sachin.kamat@linaro.org>
Cc: Thomas Abraham <thomas.ab@samsung.com>
Signed-off-by: Ben Gamari <ben@smart-cactus.org>
Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
---
 arch/arm/boot/dts/exynos5800.dtsi | 165 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 165 insertions(+)

diff --git a/arch/arm/boot/dts/exynos5800.dtsi b/arch/arm/boot/dts/exynos5800.dtsi
index c0bb356..e417218 100644
--- a/arch/arm/boot/dts/exynos5800.dtsi
+++ b/arch/arm/boot/dts/exynos5800.dtsi
@@ -17,8 +17,173 @@
 
 / {
 	compatible = "samsung,exynos5800", "samsung,exynos5";
+
+	cpu0_opp_table: opp_table0 {
+		compatible = "operating-points-v2";
+		opp-shared;
+		opp00@1800000000 {
+			opp-hz = /bits/ 64 <1800000000>;
+			opp-microvolt = <1250000>;
+			clock-latency-ns = <140000>;
+		};
+		opp01@1700000000 {
+			opp-hz = /bits/ 64 <1700000000>;
+			opp-microvolt = <1250000>;
+			clock-latency-ns = <140000>;
+		};
+		opp02@1600000000 {
+			opp-hz = /bits/ 64 <1600000000>;
+			opp-microvolt = <1250000>;
+			clock-latency-ns = <140000>;
+		};
+		opp03@1500000000 {
+			opp-hz = /bits/ 64 <1500000000>;
+			opp-microvolt = <1100000>;
+			clock-latency-ns = <140000>;
+		};
+		opp04@1400000000 {
+			opp-hz = /bits/ 64 <1400000000>;
+			opp-microvolt = <1100000>;
+			clock-latency-ns = <140000>;
+		};
+		opp05@1300000000 {
+			opp-hz = /bits/ 64 <1300000000>;
+			opp-microvolt = <1100000>;
+			clock-latency-ns = <140000>;
+		};
+		opp06@1200000000 {
+			opp-hz = /bits/ 64 <1200000000>;
+			opp-microvolt = <1000000>;
+			clock-latency-ns = <140000>;
+		};
+		opp07@1100000000 {
+			opp-hz = /bits/ 64 <1100000000>;
+			opp-microvolt = <1000000>;
+			clock-latency-ns = <140000>;
+		};
+		opp08@1000000000 {
+			opp-hz = /bits/ 64 <1000000000>;
+			opp-microvolt = <1000000>;
+			clock-latency-ns = <140000>;
+		};
+		opp09@900000000 {
+			opp-hz = /bits/ 64 <900000000>;
+			opp-microvolt = <1000000>;
+			clock-latency-ns = <140000>;
+		};
+		opp10@800000000 {
+			opp-hz = /bits/ 64 <800000000>;
+			opp-microvolt = <900000>;
+			clock-latency-ns = <140000>;
+		};
+		opp11@700000000 {
+			opp-hz = /bits/ 64 <700000000>;
+			opp-microvolt = <900000>;
+			clock-latency-ns = <140000>;
+		};
+		opp12@600000000 {
+			opp-hz = /bits/ 64 <600000000>;
+			opp-microvolt = <900000>;
+			clock-latency-ns = <140000>;
+		};
+		opp13@500000000 {
+			opp-hz = /bits/ 64 <500000000>;
+			opp-microvolt = <900000>;
+			clock-latency-ns = <140000>;
+		};
+		opp14@400000000 {
+			opp-hz = /bits/ 64 <400000000>;
+			opp-microvolt = <900000>;
+			clock-latency-ns = <140000>;
+		};
+		opp15@300000000 {
+			opp-hz = /bits/ 64 <300000000>;
+			opp-microvolt = <900000>;
+			clock-latency-ns = <140000>;
+		};
+		opp16@200000000 {
+			opp-hz = /bits/ 64 <200000000>;
+			opp-microvolt = <900000>;
+			clock-latency-ns = <140000>;
+		};
+	};
+
+	cpu1_opp_table: opp_table1 {
+		compatible = "operating-points-v2";
+		opp-shared;
+		opp00@1300000000 {
+			opp-hz = /bits/ 64 <1300000000>;
+			opp-microvolt = <1250000>;
+			clock-latency-ns = <140000>;
+		};
+		opp01@1200000000 {
+			opp-hz = /bits/ 64 <1200000000>;
+			opp-microvolt = <1250000>;
+			clock-latency-ns = <140000>;
+		};
+		opp02@1100000000 {
+			opp-hz = /bits/ 64 <1100000000>;
+			opp-microvolt = <1250000>;
+			clock-latency-ns = <140000>;
+		};
+		opp03@1000000000 {
+			opp-hz = /bits/ 64 <1000000000>;
+			opp-microvolt = <1100000>;
+			clock-latency-ns = <140000>;
+		};
+		opp04@900000000 {
+			opp-hz = /bits/ 64 <900000000>;
+			opp-microvolt = <1100000>;
+			clock-latency-ns = <140000>;
+		};
+		opp05@800000000 {
+			opp-hz = /bits/ 64 <800000000>;
+			opp-microvolt = <1100000>;
+			clock-latency-ns = <140000>;
+		};
+		opp06@700000000 {
+			opp-hz = /bits/ 64 <700000000>;
+			opp-microvolt = <1000000>;
+			clock-latency-ns = <140000>;
+		};
+		opp07@600000000 {
+			opp-hz = /bits/ 64 <600000000>;
+			opp-microvolt = <1000000>;
+			clock-latency-ns = <140000>;
+		};
+		opp08@500000000 {
+			opp-hz = /bits/ 64 <500000000>;
+			opp-microvolt = <1000000>;
+			clock-latency-ns = <140000>;
+		};
+		opp09@400000000 {
+			opp-hz = /bits/ 64 <400000000>;
+			opp-microvolt = <1000000>;
+			clock-latency-ns = <140000>;
+		};
+		opp10@300000000 {
+			opp-hz = /bits/ 64 <300000000>;
+			opp-microvolt = <900000>;
+			clock-latency-ns = <140000>;
+		};
+		opp11@200000000 {
+			opp-hz = /bits/ 64 <200000000>;
+			opp-microvolt = <900000>;
+			clock-latency-ns = <140000>;
+		};
+	};
 };
 
+&cpu0 { operating-points-v2 = <&cpu0_opp_table>; };
+&cpu1 { operating-points-v2 = <&cpu0_opp_table>; };
+&cpu2 { operating-points-v2 = <&cpu0_opp_table>; };
+&cpu3 { operating-points-v2 = <&cpu0_opp_table>; };
+
+&cpu4 { operating-points-v2 = <&cpu1_opp_table>; };
+&cpu5 { operating-points-v2 = <&cpu1_opp_table>; };
+&cpu6 { operating-points-v2 = <&cpu1_opp_table>; };
+&cpu7 { operating-points-v2 = <&cpu1_opp_table>; };
+
 &clock {
 	compatible = "samsung,exynos5800-clock";
 };
-- 
1.9.1
