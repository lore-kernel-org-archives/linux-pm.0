From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH V5 3/7] ARM: exynos: Use - instead of @ for DT OPP entries
Date: Thu, 20 Apr 2017 16:25:07 +0530
Message-ID: <8fd1dcd1bfa2011411dceab82bcd1587fe913cd1.1492685450.git.viresh.kumar@linaro.org>
References: <cover.1492685450.git.viresh.kumar@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1492685450.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1492685450.git.viresh.kumar@linaro.org>
References: <cover.1492685450.git.viresh.kumar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: arm@kernel.org, Chanwoo Choi <cw00.choi@samsung.com>, MyungJoo Ham <myungjoo.ham@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, Kukjin Kim <kgene@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>, Javier Martinez Canillas <javier@osg.samsung.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>
Cc: linaro-kernel@lists.linaro.org, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, Rafael Wysocki <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>, Masahiro Yamada <yamada.masahiro@socionext.com>, Rob Herring <robh@kernel.org>, linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
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
Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>
Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>
Acked-by: Rob Herring <robh@kernel.org>
---
 .../devicetree/bindings/devfreq/exynos-bus.txt     | 46 +++++++--------
 arch/arm/boot/dts/exynos3250.dtsi                  | 46 +++++++--------
 arch/arm/boot/dts/exynos4210.dtsi                  | 32 +++++------
 arch/arm/boot/dts/exynos4412-prime.dtsi            |  4 +-
 arch/arm/boot/dts/exynos4412.dtsi                  | 66 +++++++++++-----------
 arch/arm/boot/dts/exynos5420.dtsi                  | 40 ++++++-------
 arch/arm/boot/dts/exynos5800.dtsi                  | 56 +++++++++---------
 arch/arm64/boot/dts/exynos/exynos5433-bus.dtsi     | 48 ++++++++--------
 arch/arm64/boot/dts/exynos/exynos5433.dtsi         | 50 ++++++++--------
 9 files changed, 194 insertions(+), 194 deletions(-)

diff --git a/Documentation/devicetree/bindings/devfreq/exynos-bus.txt b/Documentation/devicetree/bindings/devfreq/exynos-bus.txt
index d085ef90d27c..f8e946471a58 100644
--- a/Documentation/devicetree/bindings/devfreq/exynos-bus.txt
+++ b/Documentation/devicetree/bindings/devfreq/exynos-bus.txt
@@ -202,23 +202,23 @@ is able to support the bus frequency for all Exynos SoCs.
 		compatible = "operating-points-v2";
 		opp-shared;
 
-		opp@50000000 {
+		opp-50000000 {
 			opp-hz = /bits/ 64 <50000000>;
 			opp-microvolt = <800000>;
 		};
-		opp@100000000 {
+		opp-100000000 {
 			opp-hz = /bits/ 64 <100000000>;
 			opp-microvolt = <800000>;
 		};
-		opp@134000000 {
+		opp-134000000 {
 			opp-hz = /bits/ 64 <134000000>;
 			opp-microvolt = <800000>;
 		};
-		opp@200000000 {
+		opp-200000000 {
 			opp-hz = /bits/ 64 <200000000>;
 			opp-microvolt = <825000>;
 		};
-		opp@400000000 {
+		opp-400000000 {
 			opp-hz = /bits/ 64 <400000000>;
 			opp-microvolt = <875000>;
 		};
@@ -292,23 +292,23 @@ is able to support the bus frequency for all Exynos SoCs.
 		compatible = "operating-points-v2";
 		opp-shared;
 
-		opp@50000000 {
+		opp-50000000 {
 			opp-hz = /bits/ 64 <50000000>;
 			opp-microvolt = <900000>;
 		};
-		opp@80000000 {
+		opp-80000000 {
 			opp-hz = /bits/ 64 <80000000>;
 			opp-microvolt = <900000>;
 		};
-		opp@100000000 {
+		opp-100000000 {
 			opp-hz = /bits/ 64 <100000000>;
 			opp-microvolt = <1000000>;
 		};
-		opp@134000000 {
+		opp-134000000 {
 			opp-hz = /bits/ 64 <134000000>;
 			opp-microvolt = <1000000>;
 		};
-		opp@200000000 {
+		opp-200000000 {
 			opp-hz = /bits/ 64 <200000000>;
 			opp-microvolt = <1000000>;
 		};
@@ -318,19 +318,19 @@ is able to support the bus frequency for all Exynos SoCs.
 		compatible = "operating-points-v2";
 		opp-shared;
 
-		opp@50000000 {
+		opp-50000000 {
 			opp-hz = /bits/ 64 <50000000>;
 		};
-		opp@80000000 {
+		opp-80000000 {
 			opp-hz = /bits/ 64 <80000000>;
 		};
-		opp@100000000 {
+		opp-100000000 {
 			opp-hz = /bits/ 64 <100000000>;
 		};
-		opp@200000000 {
+		opp-200000000 {
 			opp-hz = /bits/ 64 <200000000>;
 		};
-		opp@400000000 {
+		opp-400000000 {
 			opp-hz = /bits/ 64 <400000000>;
 		};
 	};
@@ -339,19 +339,19 @@ is able to support the bus frequency for all Exynos SoCs.
 		compatible = "operating-points-v2";
 		opp-shared;
 
-		opp@50000000 {
+		opp-50000000 {
 			opp-hz = /bits/ 64 <50000000>;
 		};
-		opp@80000000 {
+		opp-80000000 {
 			opp-hz = /bits/ 64 <80000000>;
 		};
-		opp@100000000 {
+		opp-100000000 {
 			opp-hz = /bits/ 64 <100000000>;
 		};
-		opp@200000000 {
+		opp-200000000 {
 			opp-hz = /bits/ 64 <200000000>;
 		};
-		opp@300000000 {
+		opp-300000000 {
 			opp-hz = /bits/ 64 <300000000>;
 		};
 	};
@@ -360,13 +360,13 @@ is able to support the bus frequency for all Exynos SoCs.
 		compatible = "operating-points-v2";
 		opp-shared;
 
-		opp@50000000 {
+		opp-50000000 {
 			opp-hz = /bits/ 64 <50000000>;
 		};
-		opp@80000000 {
+		opp-80000000 {
 			opp-hz = /bits/ 64 <80000000>;
 		};
-		opp@100000000 {
+		opp-100000000 {
 			opp-hz = /bits/ 64 <100000000>;
 		};
 	};
diff --git a/arch/arm/boot/dts/exynos3250.dtsi b/arch/arm/boot/dts/exynos3250.dtsi
index 9c28ef4508e0..590ee442d0ae 100644
--- a/arch/arm/boot/dts/exynos3250.dtsi
+++ b/arch/arm/boot/dts/exynos3250.dtsi
@@ -745,23 +745,23 @@
 			compatible = "operating-points-v2";
 			opp-shared;
 
-			opp@50000000 {
+			opp-50000000 {
 				opp-hz = /bits/ 64 <50000000>;
 				opp-microvolt = <800000>;
 			};
-			opp@100000000 {
+			opp-100000000 {
 				opp-hz = /bits/ 64 <100000000>;
 				opp-microvolt = <800000>;
 			};
-			opp@134000000 {
+			opp-134000000 {
 				opp-hz = /bits/ 64 <134000000>;
 				opp-microvolt = <800000>;
 			};
-			opp@200000000 {
+			opp-200000000 {
 				opp-hz = /bits/ 64 <200000000>;
 				opp-microvolt = <825000>;
 			};
-			opp@400000000 {
+			opp-400000000 {
 				opp-hz = /bits/ 64 <400000000>;
 				opp-microvolt = <875000>;
 			};
@@ -835,23 +835,23 @@
 			compatible = "operating-points-v2";
 			opp-shared;
 
-			opp@50000000 {
+			opp-50000000 {
 				opp-hz = /bits/ 64 <50000000>;
 				opp-microvolt = <900000>;
 			};
-			opp@80000000 {
+			opp-80000000 {
 				opp-hz = /bits/ 64 <80000000>;
 				opp-microvolt = <900000>;
 			};
-			opp@100000000 {
+			opp-100000000 {
 				opp-hz = /bits/ 64 <100000000>;
 				opp-microvolt = <1000000>;
 			};
-			opp@134000000 {
+			opp-134000000 {
 				opp-hz = /bits/ 64 <134000000>;
 				opp-microvolt = <1000000>;
 			};
-			opp@200000000 {
+			opp-200000000 {
 				opp-hz = /bits/ 64 <200000000>;
 				opp-microvolt = <1000000>;
 			};
@@ -861,19 +861,19 @@
 			compatible = "operating-points-v2";
 			opp-shared;
 
-			opp@50000000 {
+			opp-50000000 {
 				opp-hz = /bits/ 64 <50000000>;
 			};
-			opp@80000000 {
+			opp-80000000 {
 				opp-hz = /bits/ 64 <80000000>;
 			};
-			opp@100000000 {
+			opp-100000000 {
 				opp-hz = /bits/ 64 <100000000>;
 			};
-			opp@200000000 {
+			opp-200000000 {
 				opp-hz = /bits/ 64 <200000000>;
 			};
-			opp@400000000 {
+			opp-400000000 {
 				opp-hz = /bits/ 64 <400000000>;
 			};
 		};
@@ -882,19 +882,19 @@
 			compatible = "operating-points-v2";
 			opp-shared;
 
-			opp@50000000 {
+			opp-50000000 {
 				opp-hz = /bits/ 64 <50000000>;
 			};
-			opp@80000000 {
+			opp-80000000 {
 				opp-hz = /bits/ 64 <80000000>;
 			};
-			opp@100000000 {
+			opp-100000000 {
 				opp-hz = /bits/ 64 <100000000>;
 			};
-			opp@200000000 {
+			opp-200000000 {
 				opp-hz = /bits/ 64 <200000000>;
 			};
-			opp@300000000 {
+			opp-300000000 {
 				opp-hz = /bits/ 64 <300000000>;
 			};
 		};
@@ -903,13 +903,13 @@
 			compatible = "operating-points-v2";
 			opp-shared;
 
-			opp@50000000 {
+			opp-50000000 {
 				opp-hz = /bits/ 64 <50000000>;
 			};
-			opp@80000000 {
+			opp-80000000 {
 				opp-hz = /bits/ 64 <80000000>;
 			};
-			opp@100000000 {
+			opp-100000000 {
 				opp-hz = /bits/ 64 <100000000>;
 			};
 		};
diff --git a/arch/arm/boot/dts/exynos4210.dtsi b/arch/arm/boot/dts/exynos4210.dtsi
index e6e62103a71f..768fb075b1fd 100644
--- a/arch/arm/boot/dts/exynos4210.dtsi
+++ b/arch/arm/boot/dts/exynos4210.dtsi
@@ -343,15 +343,15 @@
 		compatible = "operating-points-v2";
 		opp-shared;
 
-		opp@134000000 {
+		opp-134000000 {
 			opp-hz = /bits/ 64 <134000000>;
 			opp-microvolt = <1025000>;
 		};
-		opp@267000000 {
+		opp-267000000 {
 			opp-hz = /bits/ 64 <267000000>;
 			opp-microvolt = <1050000>;
 		};
-		opp@400000000 {
+		opp-400000000 {
 			opp-hz = /bits/ 64 <400000000>;
 			opp-microvolt = <1150000>;
 		};
@@ -361,13 +361,13 @@
 		compatible = "operating-points-v2";
 		opp-shared;
 
-		opp@134000000 {
+		opp-134000000 {
 			opp-hz = /bits/ 64 <134000000>;
 		};
-		opp@160000000 {
+		opp-160000000 {
 			opp-hz = /bits/ 64 <160000000>;
 		};
-		opp@200000000 {
+		opp-200000000 {
 			opp-hz = /bits/ 64 <200000000>;
 		};
 	};
@@ -376,10 +376,10 @@
 		compatible = "operating-points-v2";
 		opp-shared;
 
-		opp@5000000 {
+		opp-5000000 {
 			opp-hz = /bits/ 64 <5000000>;
 		};
-		opp@100000000 {
+		opp-100000000 {
 			opp-hz = /bits/ 64 <100000000>;
 		};
 	};
@@ -388,10 +388,10 @@
 		compatible = "operating-points-v2";
 		opp-shared;
 
-		opp@10000000 {
+		opp-10000000 {
 			opp-hz = /bits/ 64 <10000000>;
 		};
-		opp@134000000 {
+		opp-134000000 {
 			opp-hz = /bits/ 64 <134000000>;
 		};
 	};
@@ -400,13 +400,13 @@
 		compatible = "operating-points-v2";
 		opp-shared;
 
-		opp@100000000 {
+		opp-100000000 {
 			opp-hz = /bits/ 64 <100000000>;
 		};
-		opp@134000000 {
+		opp-134000000 {
 			opp-hz = /bits/ 64 <134000000>;
 		};
-		opp@160000000 {
+		opp-160000000 {
 			opp-hz = /bits/ 64 <160000000>;
 		};
 	};
@@ -415,13 +415,13 @@
 		compatible = "operating-points-v2";
 		opp-shared;
 
-		opp@100000000 {
+		opp-100000000 {
 			opp-hz = /bits/ 64 <100000000>;
 		};
-		opp@160000000 {
+		opp-160000000 {
 			opp-hz = /bits/ 64 <160000000>;
 		};
-		opp@200000000 {
+		opp-200000000 {
 			opp-hz = /bits/ 64 <200000000>;
 		};
 	};
diff --git a/arch/arm/boot/dts/exynos4412-prime.dtsi b/arch/arm/boot/dts/exynos4412-prime.dtsi
index e75bc170c89c..a67bd953d754 100644
--- a/arch/arm/boot/dts/exynos4412-prime.dtsi
+++ b/arch/arm/boot/dts/exynos4412-prime.dtsi
@@ -20,12 +20,12 @@
 };
 
 &cpu0_opp_table {
-	opp@1600000000 {
+	opp-1600000000 {
 		opp-hz = /bits/ 64 <1600000000>;
 		opp-microvolt = <1350000>;
 		clock-latency-ns = <200000>;
 	};
-	opp@1704000000 {
+	opp-1704000000 {
 		opp-hz = /bits/ 64 <1704000000>;
 		opp-microvolt = <1350000>;
 		clock-latency-ns = <200000>;
diff --git a/arch/arm/boot/dts/exynos4412.dtsi b/arch/arm/boot/dts/exynos4412.dtsi
index cc69466f17c0..7ff03a7e8fb9 100644
--- a/arch/arm/boot/dts/exynos4412.dtsi
+++ b/arch/arm/boot/dts/exynos4412.dtsi
@@ -76,73 +76,73 @@
 		compatible = "operating-points-v2";
 		opp-shared;
 
-		opp@200000000 {
+		opp-200000000 {
 			opp-hz = /bits/ 64 <200000000>;
 			opp-microvolt = <900000>;
 			clock-latency-ns = <200000>;
 		};
-		opp@300000000 {
+		opp-300000000 {
 			opp-hz = /bits/ 64 <300000000>;
 			opp-microvolt = <900000>;
 			clock-latency-ns = <200000>;
 		};
-		opp@400000000 {
+		opp-400000000 {
 			opp-hz = /bits/ 64 <400000000>;
 			opp-microvolt = <925000>;
 			clock-latency-ns = <200000>;
 		};
-		opp@500000000 {
+		opp-500000000 {
 			opp-hz = /bits/ 64 <500000000>;
 			opp-microvolt = <950000>;
 			clock-latency-ns = <200000>;
 		};
-		opp@600000000 {
+		opp-600000000 {
 			opp-hz = /bits/ 64 <600000000>;
 			opp-microvolt = <975000>;
 			clock-latency-ns = <200000>;
 		};
-		opp@700000000 {
+		opp-700000000 {
 			opp-hz = /bits/ 64 <700000000>;
 			opp-microvolt = <987500>;
 			clock-latency-ns = <200000>;
 		};
-		opp@800000000 {
+		opp-800000000 {
 			opp-hz = /bits/ 64 <800000000>;
 			opp-microvolt = <1000000>;
 			clock-latency-ns = <200000>;
 			opp-suspend;
 		};
-		opp@900000000 {
+		opp-900000000 {
 			opp-hz = /bits/ 64 <900000000>;
 			opp-microvolt = <1037500>;
 			clock-latency-ns = <200000>;
 		};
-		opp@1000000000 {
+		opp-1000000000 {
 			opp-hz = /bits/ 64 <1000000000>;
 			opp-microvolt = <1087500>;
 			clock-latency-ns = <200000>;
 		};
-		opp@1100000000 {
+		opp-1100000000 {
 			opp-hz = /bits/ 64 <1100000000>;
 			opp-microvolt = <1137500>;
 			clock-latency-ns = <200000>;
 		};
-		opp@1200000000 {
+		opp-1200000000 {
 			opp-hz = /bits/ 64 <1200000000>;
 			opp-microvolt = <1187500>;
 			clock-latency-ns = <200000>;
 		};
-		opp@1300000000 {
+		opp-1300000000 {
 			opp-hz = /bits/ 64 <1300000000>;
 			opp-microvolt = <1250000>;
 			clock-latency-ns = <200000>;
 		};
-		opp@1400000000 {
+		opp-1400000000 {
 			opp-hz = /bits/ 64 <1400000000>;
 			opp-microvolt = <1287500>;
 			clock-latency-ns = <200000>;
 		};
-		cpu0_opp_1500: opp@1500000000 {
+		cpu0_opp_1500: opp-1500000000 {
 			opp-hz = /bits/ 64 <1500000000>;
 			opp-microvolt = <1350000>;
 			clock-latency-ns = <200000>;
@@ -442,23 +442,23 @@
 		compatible = "operating-points-v2";
 		opp-shared;
 
-		opp@100000000 {
+		opp-100000000 {
 			opp-hz = /bits/ 64 <100000000>;
 			opp-microvolt = <900000>;
 		};
-		opp@134000000 {
+		opp-134000000 {
 			opp-hz = /bits/ 64 <134000000>;
 			opp-microvolt = <900000>;
 		};
-		opp@160000000 {
+		opp-160000000 {
 			opp-hz = /bits/ 64 <160000000>;
 			opp-microvolt = <900000>;
 		};
-		opp@267000000 {
+		opp-267000000 {
 			opp-hz = /bits/ 64 <267000000>;
 			opp-microvolt = <950000>;
 		};
-		opp@400000000 {
+		opp-400000000 {
 			opp-hz = /bits/ 64 <400000000>;
 			opp-microvolt = <1050000>;
 		};
@@ -468,16 +468,16 @@
 		compatible = "operating-points-v2";
 		opp-shared;
 
-		opp@100000000 {
+		opp-100000000 {
 			opp-hz = /bits/ 64 <100000000>;
 		};
-		opp@134000000 {
+		opp-134000000 {
 			opp-hz = /bits/ 64 <134000000>;
 		};
-		opp@160000000 {
+		opp-160000000 {
 			opp-hz = /bits/ 64 <160000000>;
 		};
-		opp@267000000 {
+		opp-267000000 {
 			opp-hz = /bits/ 64 <267000000>;
 		};
 	};
@@ -534,19 +534,19 @@
 		compatible = "operating-points-v2";
 		opp-shared;
 
-		opp@100000000 {
+		opp-100000000 {
 			opp-hz = /bits/ 64 <100000000>;
 			opp-microvolt = <900000>;
 		};
-		opp@134000000 {
+		opp-134000000 {
 			opp-hz = /bits/ 64 <134000000>;
 			opp-microvolt = <925000>;
 		};
-		opp@160000000 {
+		opp-160000000 {
 			opp-hz = /bits/ 64 <160000000>;
 			opp-microvolt = <950000>;
 		};
-		opp@200000000 {
+		opp-200000000 {
 			opp-hz = /bits/ 64 <200000000>;
 			opp-microvolt = <1000000>;
 		};
@@ -556,10 +556,10 @@
 		compatible = "operating-points-v2";
 		opp-shared;
 
-		opp@160000000 {
+		opp-160000000 {
 			opp-hz = /bits/ 64 <160000000>;
 		};
-		opp@200000000 {
+		opp-200000000 {
 			opp-hz = /bits/ 64 <200000000>;
 		};
 	};
@@ -568,10 +568,10 @@
 		compatible = "operating-points-v2";
 		opp-shared;
 
-		opp@100000000 {
+		opp-100000000 {
 			opp-hz = /bits/ 64 <100000000>;
 		};
-		opp@134000000 {
+		opp-134000000 {
 			opp-hz = /bits/ 64 <134000000>;
 		};
 	};
@@ -580,10 +580,10 @@
 		compatible = "operating-points-v2";
 		opp-shared;
 
-		opp@50000000 {
+		opp-50000000 {
 			opp-hz = /bits/ 64 <50000000>;
 		};
-		opp@100000000 {
+		opp-100000000 {
 			opp-hz = /bits/ 64 <100000000>;
 		};
 	};
diff --git a/arch/arm/boot/dts/exynos5420.dtsi b/arch/arm/boot/dts/exynos5420.dtsi
index 83b3899d228d..0db0bcf8da36 100644
--- a/arch/arm/boot/dts/exynos5420.dtsi
+++ b/arch/arm/boot/dts/exynos5420.dtsi
@@ -49,62 +49,62 @@
 		cluster_a15_opp_table: opp_table0 {
 			compatible = "operating-points-v2";
 			opp-shared;
-			opp@1800000000 {
+			opp-1800000000 {
 				opp-hz = /bits/ 64 <1800000000>;
 				opp-microvolt = <1250000>;
 				clock-latency-ns = <140000>;
 			};
-			opp@1700000000 {
+			opp-1700000000 {
 				opp-hz = /bits/ 64 <1700000000>;
 				opp-microvolt = <1212500>;
 				clock-latency-ns = <140000>;
 			};
-			opp@1600000000 {
+			opp-1600000000 {
 				opp-hz = /bits/ 64 <1600000000>;
 				opp-microvolt = <1175000>;
 				clock-latency-ns = <140000>;
 			};
-			opp@1500000000 {
+			opp-1500000000 {
 				opp-hz = /bits/ 64 <1500000000>;
 				opp-microvolt = <1137500>;
 				clock-latency-ns = <140000>;
 			};
-			opp@1400000000 {
+			opp-1400000000 {
 				opp-hz = /bits/ 64 <1400000000>;
 				opp-microvolt = <1112500>;
 				clock-latency-ns = <140000>;
 			};
-			opp@1300000000 {
+			opp-1300000000 {
 				opp-hz = /bits/ 64 <1300000000>;
 				opp-microvolt = <1062500>;
 				clock-latency-ns = <140000>;
 			};
-			opp@1200000000 {
+			opp-1200000000 {
 				opp-hz = /bits/ 64 <1200000000>;
 				opp-microvolt = <1037500>;
 				clock-latency-ns = <140000>;
 			};
-			opp@1100000000 {
+			opp-1100000000 {
 				opp-hz = /bits/ 64 <1100000000>;
 				opp-microvolt = <1012500>;
 				clock-latency-ns = <140000>;
 			};
-			opp@1000000000 {
+			opp-1000000000 {
 				opp-hz = /bits/ 64 <1000000000>;
 				opp-microvolt = < 987500>;
 				clock-latency-ns = <140000>;
 			};
-			opp@900000000 {
+			opp-900000000 {
 				opp-hz = /bits/ 64 <900000000>;
 				opp-microvolt = < 962500>;
 				clock-latency-ns = <140000>;
 			};
-			opp@800000000 {
+			opp-800000000 {
 				opp-hz = /bits/ 64 <800000000>;
 				opp-microvolt = < 937500>;
 				clock-latency-ns = <140000>;
 			};
-			opp@700000000 {
+			opp-700000000 {
 				opp-hz = /bits/ 64 <700000000>;
 				opp-microvolt = < 912500>;
 				clock-latency-ns = <140000>;
@@ -114,42 +114,42 @@
 		cluster_a7_opp_table: opp_table1 {
 			compatible = "operating-points-v2";
 			opp-shared;
-			opp@1300000000 {
+			opp-1300000000 {
 				opp-hz = /bits/ 64 <1300000000>;
 				opp-microvolt = <1275000>;
 				clock-latency-ns = <140000>;
 			};
-			opp@1200000000 {
+			opp-1200000000 {
 				opp-hz = /bits/ 64 <1200000000>;
 				opp-microvolt = <1212500>;
 				clock-latency-ns = <140000>;
 			};
-			opp@1100000000 {
+			opp-1100000000 {
 				opp-hz = /bits/ 64 <1100000000>;
 				opp-microvolt = <1162500>;
 				clock-latency-ns = <140000>;
 			};
-			opp@1000000000 {
+			opp-1000000000 {
 				opp-hz = /bits/ 64 <1000000000>;
 				opp-microvolt = <1112500>;
 				clock-latency-ns = <140000>;
 			};
-			opp@900000000 {
+			opp-900000000 {
 				opp-hz = /bits/ 64 <900000000>;
 				opp-microvolt = <1062500>;
 				clock-latency-ns = <140000>;
 			};
-			opp@800000000 {
+			opp-800000000 {
 				opp-hz = /bits/ 64 <800000000>;
 				opp-microvolt = <1025000>;
 				clock-latency-ns = <140000>;
 			};
-			opp@700000000 {
+			opp-700000000 {
 				opp-hz = /bits/ 64 <700000000>;
 				opp-microvolt = <975000>;
 				clock-latency-ns = <140000>;
 			};
-			opp@600000000 {
+			opp-600000000 {
 				opp-hz = /bits/ 64 <600000000>;
 				opp-microvolt = <937500>;
 				clock-latency-ns = <140000>;
diff --git a/arch/arm/boot/dts/exynos5800.dtsi b/arch/arm/boot/dts/exynos5800.dtsi
index 8213016803e5..9ddb6bacac5a 100644
--- a/arch/arm/boot/dts/exynos5800.dtsi
+++ b/arch/arm/boot/dts/exynos5800.dtsi
@@ -24,60 +24,60 @@
 };
 
 &cluster_a15_opp_table {
-	opp@1700000000 {
+	opp-1700000000 {
 		opp-microvolt = <1250000>;
 	};
-	opp@1600000000 {
+	opp-1600000000 {
 		opp-microvolt = <1250000>;
 	};
-	opp@1500000000 {
+	opp-1500000000 {
 		opp-microvolt = <1100000>;
 	};
-	opp@1400000000 {
+	opp-1400000000 {
 		opp-microvolt = <1100000>;
 	};
-	opp@1300000000 {
+	opp-1300000000 {
 		opp-microvolt = <1100000>;
 	};
-	opp@1200000000 {
+	opp-1200000000 {
 		opp-microvolt = <1000000>;
 	};
-	opp@1100000000 {
+	opp-1100000000 {
 		opp-microvolt = <1000000>;
 	};
-	opp@1000000000 {
+	opp-1000000000 {
 		opp-microvolt = <1000000>;
 	};
-	opp@900000000 {
+	opp-900000000 {
 		opp-microvolt = <1000000>;
 	};
-	opp@800000000 {
+	opp-800000000 {
 		opp-microvolt = <900000>;
 	};
-	opp@700000000 {
+	opp-700000000 {
 		opp-microvolt = <900000>;
 	};
-	opp@600000000 {
+	opp-600000000 {
 		opp-hz = /bits/ 64 <600000000>;
 		opp-microvolt = <900000>;
 		clock-latency-ns = <140000>;
 	};
-	opp@500000000 {
+	opp-500000000 {
 		opp-hz = /bits/ 64 <500000000>;
 		opp-microvolt = <900000>;
 		clock-latency-ns = <140000>;
 	};
-	opp@400000000 {
+	opp-400000000 {
 		opp-hz = /bits/ 64 <400000000>;
 		opp-microvolt = <900000>;
 		clock-latency-ns = <140000>;
 	};
-	opp@300000000 {
+	opp-300000000 {
 		opp-hz = /bits/ 64 <300000000>;
 		opp-microvolt = <900000>;
 		clock-latency-ns = <140000>;
 	};
-	opp@200000000 {
+	opp-200000000 {
 		opp-hz = /bits/ 64 <200000000>;
 		opp-microvolt = <900000>;
 		clock-latency-ns = <140000>;
@@ -85,46 +85,46 @@
 };
 
 &cluster_a7_opp_table {
-	opp@1300000000 {
+	opp-1300000000 {
 		opp-microvolt = <1250000>;
 	};
-	opp@1200000000 {
+	opp-1200000000 {
 		opp-microvolt = <1250000>;
 	};
-	opp@1100000000 {
+	opp-1100000000 {
 		opp-microvolt = <1250000>;
 	};
-	opp@1000000000 {
+	opp-1000000000 {
 		opp-microvolt = <1100000>;
 	};
-	opp@900000000 {
+	opp-900000000 {
 		opp-microvolt = <1100000>;
 	};
-	opp@800000000 {
+	opp-800000000 {
 		opp-microvolt = <1100000>;
 	};
-	opp@700000000 {
+	opp-700000000 {
 		opp-microvolt = <1000000>;
 	};
-	opp@600000000 {
+	opp-600000000 {
 		opp-microvolt = <1000000>;
 	};
-	opp@500000000 {
+	opp-500000000 {
 		opp-hz = /bits/ 64 <500000000>;
 		opp-microvolt = <1000000>;
 		clock-latency-ns = <140000>;
 	};
-	opp@400000000 {
+	opp-400000000 {
 		opp-hz = /bits/ 64 <400000000>;
 		opp-microvolt = <1000000>;
 		clock-latency-ns = <140000>;
 	};
-	opp@300000000 {
+	opp-300000000 {
 		opp-hz = /bits/ 64 <300000000>;
 		opp-microvolt = <900000>;
 		clock-latency-ns = <140000>;
 	};
-	opp@200000000 {
+	opp-200000000 {
 		opp-hz = /bits/ 64 <200000000>;
 		opp-microvolt = <900000>;
 		clock-latency-ns = <140000>;
diff --git a/arch/arm64/boot/dts/exynos/exynos5433-bus.dtsi b/arch/arm64/boot/dts/exynos/exynos5433-bus.dtsi
index c42dc39c3223..ec11343dc528 100644
--- a/arch/arm64/boot/dts/exynos/exynos5433-bus.dtsi
+++ b/arch/arm64/boot/dts/exynos/exynos5433-bus.dtsi
@@ -94,27 +94,27 @@
 		compatible = "operating-points-v2";
 		opp-shared;
 
-		opp@400000000 {
+		opp-400000000 {
 			opp-hz = /bits/ 64 <400000000>;
 			opp-microvolt = <1075000>;
 		};
-		opp@267000000 {
+		opp-267000000 {
 			opp-hz = /bits/ 64 <267000000>;
 			opp-microvolt = <1000000>;
 		};
-		opp@200000000 {
+		opp-200000000 {
 			opp-hz = /bits/ 64 <200000000>;
 			opp-microvolt = <975000>;
 		};
-		opp@160000000 {
+		opp-160000000 {
 			opp-hz = /bits/ 64 <160000000>;
 			opp-microvolt = <962500>;
 		};
-		opp@134000000 {
+		opp-134000000 {
 			opp-hz = /bits/ 64 <134000000>;
 			opp-microvolt = <950000>;
 		};
-		opp@100000000 {
+		opp-100000000 {
 			opp-hz = /bits/ 64 <100000000>;
 			opp-microvolt = <937500>;
 		};
@@ -123,19 +123,19 @@
 	bus_g2d_266_opp_table: opp_table3 {
 		compatible = "operating-points-v2";
 
-		opp@267000000 {
+		opp-267000000 {
 			opp-hz = /bits/ 64 <267000000>;
 		};
-		opp@200000000 {
+		opp-200000000 {
 			opp-hz = /bits/ 64 <200000000>;
 		};
-		opp@160000000 {
+		opp-160000000 {
 			opp-hz = /bits/ 64 <160000000>;
 		};
-		opp@134000000 {
+		opp-134000000 {
 			opp-hz = /bits/ 64 <134000000>;
 		};
-		opp@100000000 {
+		opp-100000000 {
 			opp-hz = /bits/ 64 <100000000>;
 		};
 	};
@@ -143,13 +143,13 @@
 	bus_gscl_opp_table: opp_table4 {
 		compatible = "operating-points-v2";
 
-		opp@333000000 {
+		opp-333000000 {
 			opp-hz = /bits/ 64 <333000000>;
 		};
-		opp@222000000 {
+		opp-222000000 {
 			opp-hz = /bits/ 64 <222000000>;
 		};
-		opp@166500000 {
+		opp-166500000 {
 			opp-hz = /bits/ 64 <166500000>;
 		};
 	};
@@ -158,22 +158,22 @@
 		compatible = "operating-points-v2";
 		opp-shared;
 
-		opp@400000000 {
+		opp-400000000 {
 			opp-hz = /bits/ 64 <400000000>;
 		};
-		opp@267000000 {
+		opp-267000000 {
 			opp-hz = /bits/ 64 <267000000>;
 		};
-		opp@200000000 {
+		opp-200000000 {
 			opp-hz = /bits/ 64 <200000000>;
 		};
-		opp@160000000 {
+		opp-160000000 {
 			opp-hz = /bits/ 64 <160000000>;
 		};
-		opp@134000000 {
+		opp-134000000 {
 			opp-hz = /bits/ 64 <134000000>;
 		};
-		opp@100000000 {
+		opp-100000000 {
 			opp-hz = /bits/ 64 <100000000>;
 		};
 	};
@@ -181,16 +181,16 @@
 	bus_noc2_opp_table: opp_table6 {
 		compatible = "operating-points-v2";
 
-		opp@400000000 {
+		opp-400000000 {
 			opp-hz = /bits/ 64 <400000000>;
 		};
-		opp@200000000 {
+		opp-200000000 {
 			opp-hz = /bits/ 64 <200000000>;
 		};
-		opp@134000000 {
+		opp-134000000 {
 			opp-hz = /bits/ 64 <134000000>;
 		};
-		opp@100000000 {
+		opp-100000000 {
 			opp-hz = /bits/ 64 <100000000>;
 		};
 	};
diff --git a/arch/arm64/boot/dts/exynos/exynos5433.dtsi b/arch/arm64/boot/dts/exynos/exynos5433.dtsi
index 16072c1c3ed3..727f36abf3d4 100644
--- a/arch/arm64/boot/dts/exynos/exynos5433.dtsi
+++ b/arch/arm64/boot/dts/exynos/exynos5433.dtsi
@@ -119,43 +119,43 @@
 		compatible = "operating-points-v2";
 		opp-shared;
 
-		opp@400000000 {
+		opp-400000000 {
 			opp-hz = /bits/ 64 <400000000>;
 			opp-microvolt = <900000>;
 		};
-		opp@500000000 {
+		opp-500000000 {
 			opp-hz = /bits/ 64 <500000000>;
 			opp-microvolt = <925000>;
 		};
-		opp@600000000 {
+		opp-600000000 {
 			opp-hz = /bits/ 64 <600000000>;
 			opp-microvolt = <950000>;
 		};
-		opp@700000000 {
+		opp-700000000 {
 			opp-hz = /bits/ 64 <700000000>;
 			opp-microvolt = <975000>;
 		};
-		opp@800000000 {
+		opp-800000000 {
 			opp-hz = /bits/ 64 <800000000>;
 			opp-microvolt = <1000000>;
 		};
-		opp@900000000 {
+		opp-900000000 {
 			opp-hz = /bits/ 64 <900000000>;
 			opp-microvolt = <1050000>;
 		};
-		opp@1000000000 {
+		opp-1000000000 {
 			opp-hz = /bits/ 64 <1000000000>;
 			opp-microvolt = <1075000>;
 		};
-		opp@1100000000 {
+		opp-1100000000 {
 			opp-hz = /bits/ 64 <1100000000>;
 			opp-microvolt = <1112500>;
 		};
-		opp@1200000000 {
+		opp-1200000000 {
 			opp-hz = /bits/ 64 <1200000000>;
 			opp-microvolt = <1112500>;
 		};
-		opp@1300000000 {
+		opp-1300000000 {
 			opp-hz = /bits/ 64 <1300000000>;
 			opp-microvolt = <1150000>;
 		};
@@ -165,63 +165,63 @@
 		compatible = "operating-points-v2";
 		opp-shared;
 
-		opp@500000000 {
+		opp-500000000 {
 			opp-hz = /bits/ 64 <500000000>;
 			opp-microvolt = <900000>;
 		};
-		opp@600000000 {
+		opp-600000000 {
 			opp-hz = /bits/ 64 <600000000>;
 			opp-microvolt = <900000>;
 		};
-		opp@700000000 {
+		opp-700000000 {
 			opp-hz = /bits/ 64 <700000000>;
 			opp-microvolt = <912500>;
 		};
-		opp@800000000 {
+		opp-800000000 {
 			opp-hz = /bits/ 64 <800000000>;
 			opp-microvolt = <912500>;
 		};
-		opp@900000000 {
+		opp-900000000 {
 			opp-hz = /bits/ 64 <900000000>;
 			opp-microvolt = <937500>;
 		};
-		opp@1000000000 {
+		opp-1000000000 {
 			opp-hz = /bits/ 64 <1000000000>;
 			opp-microvolt = <975000>;
 		};
-		opp@1100000000 {
+		opp-1100000000 {
 			opp-hz = /bits/ 64 <1100000000>;
 			opp-microvolt = <1012500>;
 		};
-		opp@1200000000 {
+		opp-1200000000 {
 			opp-hz = /bits/ 64 <1200000000>;
 			opp-microvolt = <1037500>;
 		};
-		opp@1300000000 {
+		opp-1300000000 {
 			opp-hz = /bits/ 64 <1300000000>;
 			opp-microvolt = <1062500>;
 		};
-		opp@1400000000 {
+		opp-1400000000 {
 			opp-hz = /bits/ 64 <1400000000>;
 			opp-microvolt = <1087500>;
 		};
-		opp@1500000000 {
+		opp-1500000000 {
 			opp-hz = /bits/ 64 <1500000000>;
 			opp-microvolt = <1125000>;
 		};
-		opp@1600000000 {
+		opp-1600000000 {
 			opp-hz = /bits/ 64 <1600000000>;
 			opp-microvolt = <1137500>;
 		};
-		opp@1700000000 {
+		opp-1700000000 {
 			opp-hz = /bits/ 64 <1700000000>;
 			opp-microvolt = <1175000>;
 		};
-		opp@1800000000 {
+		opp-1800000000 {
 			opp-hz = /bits/ 64 <1800000000>;
 			opp-microvolt = <1212500>;
 		};
-		opp@1900000000 {
+		opp-1900000000 {
 			opp-hz = /bits/ 64 <1900000000>;
 			opp-microvolt = <1262500>;
 		};
-- 
2.12.0.432.g71c3a4f4ba37
