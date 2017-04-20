From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH V4 6/7] ARM: uniphier: Use - instead of @ for DT OPP entries
Date: Thu, 20 Apr 2017 11:14:17 +0530
Message-ID: <7e6663fcf7b7c8707e78216326fe622ceb64f196.1492666725.git.viresh.kumar@linaro.org>
References: <cover.1492666725.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <cover.1492666725.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1492666725.git.viresh.kumar@linaro.org>
References: <cover.1492666725.git.viresh.kumar@linaro.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: arm@kernel.org, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: Rob Herring <robh@kernel.org>, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, Viresh Kumar <viresh.kumar@linaro.org>, Rafael Wysocki <rjw@rjwysocki.net>, linux-kernel@vger.kernel.org, Krzysztof Kozlowski <krzk@kernel.org>, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
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
index dbc5e5333163..22ef2842be3a 100644
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
index e9e031d63c1a..acaaa2187843 100644
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
index da881f5b6ed4..0f2bee028ab0 100644
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
index a6b3a70dae83..19f782408d54 100644
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
