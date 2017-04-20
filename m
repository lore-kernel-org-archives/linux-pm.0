From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH V5 6/7] ARM: uniphier: Use - instead of @ for DT OPP entries
Date: Thu, 20 Apr 2017 16:25:10 +0530
Message-ID: <1faba32eeaa493cc5463488af32eaea0dc2f7a94.1492685450.git.viresh.kumar@linaro.org>
References: <cover.1492685450.git.viresh.kumar@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1492685450.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1492685450.git.viresh.kumar@linaro.org>
References: <cover.1492685450.git.viresh.kumar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: arm@kernel.org, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: linaro-kernel@lists.linaro.org, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, Rafael Wysocki <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>, Krzysztof Kozlowski <krzk@kernel.org>, Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Compiling the DT file with W=1, DTC warns like follows:

Warning (unit_address_vs_reg): Node /opp_table0/opp@1000000000 has a
unit name, but no reg property

Fix this by replacing '@' with '-' as the OPP nodes will never have a
"reg" property.

Reported-by: Krzysztof Kozlowski <krzk@kernel.org>
Reported-by: Masahiro Yamada <yamada.masahiro@socionext.com>
Suggested-by: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
Acked-by: Masahiro Yamada <yamada.masahiro@socionext.com>
Acked-by: Rob Herring <robh@kernel.org>
---
 arch/arm/boot/dts/uniphier-pro5.dtsi             | 32 ++++++++++++------------
 arch/arm/boot/dts/uniphier-pxs2.dtsi             | 16 ++++++------
 arch/arm64/boot/dts/socionext/uniphier-ld11.dtsi | 14 +++++------
 arch/arm64/boot/dts/socionext/uniphier-ld20.dtsi | 32 ++++++++++++------------
 4 files changed, 47 insertions(+), 47 deletions(-)

diff --git a/arch/arm/boot/dts/uniphier-pro5.dtsi b/arch/arm/boot/dts/uniphier-pro5.dtsi
index df07b555cbed..81605e3a5e0a 100644
--- a/arch/arm/boot/dts/uniphier-pro5.dtsi
+++ b/arch/arm/boot/dts/uniphier-pro5.dtsi
@@ -77,67 +77,67 @@
 		compatible = "operating-points-v2";
 		opp-shared;
 
-		opp@100000000 {
+		opp-100000000 {
 			opp-hz = /bits/ 64 <100000000>;
 			clock-latency-ns = <300>;
 		};
-		opp@116667000 {
+		opp-116667000 {
 			opp-hz = /bits/ 64 <116667000>;
 			clock-latency-ns = <300>;
 		};
-		opp@150000000 {
+		opp-150000000 {
 			opp-hz = /bits/ 64 <150000000>;
 			clock-latency-ns = <300>;
 		};
-		opp@175000000 {
+		opp-175000000 {
 			opp-hz = /bits/ 64 <175000000>;
 			clock-latency-ns = <300>;
 		};
-		opp@200000000 {
+		opp-200000000 {
 			opp-hz = /bits/ 64 <200000000>;
 			clock-latency-ns = <300>;
 		};
-		opp@233334000 {
+		opp-233334000 {
 			opp-hz = /bits/ 64 <233334000>;
 			clock-latency-ns = <300>;
 		};
-		opp@300000000 {
+		opp-300000000 {
 			opp-hz = /bits/ 64 <300000000>;
 			clock-latency-ns = <300>;
 		};
-		opp@350000000 {
+		opp-350000000 {
 			opp-hz = /bits/ 64 <350000000>;
 			clock-latency-ns = <300>;
 		};
-		opp@400000000 {
+		opp-400000000 {
 			opp-hz = /bits/ 64 <400000000>;
 			clock-latency-ns = <300>;
 		};
-		opp@466667000 {
+		opp-466667000 {
 			opp-hz = /bits/ 64 <466667000>;
 			clock-latency-ns = <300>;
 		};
-		opp@600000000 {
+		opp-600000000 {
 			opp-hz = /bits/ 64 <600000000>;
 			clock-latency-ns = <300>;
 		};
-		opp@700000000 {
+		opp-700000000 {
 			opp-hz = /bits/ 64 <700000000>;
 			clock-latency-ns = <300>;
 		};
-		opp@800000000 {
+		opp-800000000 {
 			opp-hz = /bits/ 64 <800000000>;
 			clock-latency-ns = <300>;
 		};
-		opp@933334000 {
+		opp-933334000 {
 			opp-hz = /bits/ 64 <933334000>;
 			clock-latency-ns = <300>;
 		};
-		opp@1200000000 {
+		opp-1200000000 {
 			opp-hz = /bits/ 64 <1200000000>;
 			clock-latency-ns = <300>;
 		};
-		opp@1400000000 {
+		opp-1400000000 {
 			opp-hz = /bits/ 64 <1400000000>;
 			clock-latency-ns = <300>;
 		};
diff --git a/arch/arm/boot/dts/uniphier-pxs2.dtsi b/arch/arm/boot/dts/uniphier-pxs2.dtsi
index 58c3e2f35706..bc5a1afedee8 100644
--- a/arch/arm/boot/dts/uniphier-pxs2.dtsi
+++ b/arch/arm/boot/dts/uniphier-pxs2.dtsi
@@ -97,35 +97,35 @@
 		compatible = "operating-points-v2";
 		opp-shared;
 
-		opp@100000000 {
+		opp-100000000 {
 			opp-hz = /bits/ 64 <100000000>;
 			clock-latency-ns = <300>;
 		};
-		opp@150000000 {
+		opp-150000000 {
 			opp-hz = /bits/ 64 <150000000>;
 			clock-latency-ns = <300>;
 		};
-		opp@200000000 {
+		opp-200000000 {
 			opp-hz = /bits/ 64 <200000000>;
 			clock-latency-ns = <300>;
 		};
-		opp@300000000 {
+		opp-300000000 {
 			opp-hz = /bits/ 64 <300000000>;
 			clock-latency-ns = <300>;
 		};
-		opp@400000000 {
+		opp-400000000 {
 			opp-hz = /bits/ 64 <400000000>;
 			clock-latency-ns = <300>;
 		};
-		opp@600000000 {
+		opp-600000000 {
 			opp-hz = /bits/ 64 <600000000>;
 			clock-latency-ns = <300>;
 		};
-		opp@800000000 {
+		opp-800000000 {
 			opp-hz = /bits/ 64 <800000000>;
 			clock-latency-ns = <300>;
 		};
-		opp@1200000000 {
+		opp-1200000000 {
 			opp-hz = /bits/ 64 <1200000000>;
 			clock-latency-ns = <300>;
 		};
diff --git a/arch/arm64/boot/dts/socionext/uniphier-ld11.dtsi b/arch/arm64/boot/dts/socionext/uniphier-ld11.dtsi
index 151c043b4835..4beb67b4535c 100644
--- a/arch/arm64/boot/dts/socionext/uniphier-ld11.dtsi
+++ b/arch/arm64/boot/dts/socionext/uniphier-ld11.dtsi
@@ -89,31 +89,31 @@
 		compatible = "operating-points-v2";
 		opp-shared;
 
-		opp@245000000 {
+		opp-245000000 {
 			opp-hz = /bits/ 64 <245000000>;
 			clock-latency-ns = <300>;
 		};
-		opp@250000000 {
+		opp-250000000 {
 			opp-hz = /bits/ 64 <250000000>;
 			clock-latency-ns = <300>;
 		};
-		opp@490000000 {
+		opp-490000000 {
 			opp-hz = /bits/ 64 <490000000>;
 			clock-latency-ns = <300>;
 		};
-		opp@500000000 {
+		opp-500000000 {
 			opp-hz = /bits/ 64 <500000000>;
 			clock-latency-ns = <300>;
 		};
-		opp@653334000 {
+		opp-653334000 {
 			opp-hz = /bits/ 64 <653334000>;
 			clock-latency-ns = <300>;
 		};
-		opp@666667000 {
+		opp-666667000 {
 			opp-hz = /bits/ 64 <666667000>;
 			clock-latency-ns = <300>;
 		};
-		opp@980000000 {
+		opp-980000000 {
 			opp-hz = /bits/ 64 <980000000>;
 			clock-latency-ns = <300>;
 		};
diff --git a/arch/arm64/boot/dts/socionext/uniphier-ld20.dtsi b/arch/arm64/boot/dts/socionext/uniphier-ld20.dtsi
index 6193f11acb78..adde6a10de20 100644
--- a/arch/arm64/boot/dts/socionext/uniphier-ld20.dtsi
+++ b/arch/arm64/boot/dts/socionext/uniphier-ld20.dtsi
@@ -116,35 +116,35 @@
 		compatible = "operating-points-v2";
 		opp-shared;
 
-		opp@250000000 {
+		opp-250000000 {
 			opp-hz = /bits/ 64 <250000000>;
 			clock-latency-ns = <300>;
 		};
-		opp@275000000 {
+		opp-275000000 {
 			opp-hz = /bits/ 64 <275000000>;
 			clock-latency-ns = <300>;
 		};
-		opp@500000000 {
+		opp-500000000 {
 			opp-hz = /bits/ 64 <500000000>;
 			clock-latency-ns = <300>;
 		};
-		opp@550000000 {
+		opp-550000000 {
 			opp-hz = /bits/ 64 <550000000>;
 			clock-latency-ns = <300>;
 		};
-		opp@666667000 {
+		opp-666667000 {
 			opp-hz = /bits/ 64 <666667000>;
 			clock-latency-ns = <300>;
 		};
-		opp@733334000 {
+		opp-733334000 {
 			opp-hz = /bits/ 64 <733334000>;
 			clock-latency-ns = <300>;
 		};
-		opp@1000000000 {
+		opp-1000000000 {
 			opp-hz = /bits/ 64 <1000000000>;
 			clock-latency-ns = <300>;
 		};
-		opp@1100000000 {
+		opp-1100000000 {
 			opp-hz = /bits/ 64 <1100000000>;
 			clock-latency-ns = <300>;
 		};
@@ -154,35 +154,35 @@
 		compatible = "operating-points-v2";
 		opp-shared;
 
-		opp@250000000 {
+		opp-250000000 {
 			opp-hz = /bits/ 64 <250000000>;
 			clock-latency-ns = <300>;
 		};
-		opp@275000000 {
+		opp-275000000 {
 			opp-hz = /bits/ 64 <275000000>;
 			clock-latency-ns = <300>;
 		};
-		opp@500000000 {
+		opp-500000000 {
 			opp-hz = /bits/ 64 <500000000>;
 			clock-latency-ns = <300>;
 		};
-		opp@550000000 {
+		opp-550000000 {
 			opp-hz = /bits/ 64 <550000000>;
 			clock-latency-ns = <300>;
 		};
-		opp@666667000 {
+		opp-666667000 {
 			opp-hz = /bits/ 64 <666667000>;
 			clock-latency-ns = <300>;
 		};
-		opp@733334000 {
+		opp-733334000 {
 			opp-hz = /bits/ 64 <733334000>;
 			clock-latency-ns = <300>;
 		};
-		opp@1000000000 {
+		opp-1000000000 {
 			opp-hz = /bits/ 64 <1000000000>;
 			clock-latency-ns = <300>;
 		};
-		opp@1100000000 {
+		opp-1100000000 {
 			opp-hz = /bits/ 64 <1100000000>;
 			clock-latency-ns = <300>;
 		};
-- 
2.12.0.432.g71c3a4f4ba37
