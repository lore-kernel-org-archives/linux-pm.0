From: Lukasz Luba <l.luba@partner.samsung.com>
Subject: [PATCH v2 06/11] arm64: dts: exynos5433: add support for thermal
 trip irq-mode
Date: Wed,  7 Nov 2018 18:09:48 +0100
Message-ID: <1541610593-28542-7-git-send-email-l.luba@partner.samsung.com>
References: <1541610593-28542-1-git-send-email-l.luba@partner.samsung.com>
        <CGME20181107171041eucas1p1a3cf91435b9071fd6e6f84101ebbcd9f@eucas1p1.samsung.com>
Content-Type: text/plain; charset="utf-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1541610593-28542-1-git-send-email-l.luba@partner.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Cc: rui.zhang@intel.com, edubezval@gmail.com, daniel.lezcano@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com, corbet@lwn.net, b.zolnierkie@samsung.com, krzk@kernel.org, Lukasz Luba <l.luba@partner.samsung.com>, Kukjin Kim <kgene@kernel.org>, linux-samsung-soc@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

This patch adds support for new flag which indicates
that trip point triggers IRQ when temperature is met.
Exynos5433 supports 8 trip point which will trigger IRQ.
Above that number other trip points should be registered
without 'irq-mode' flag.

Cc: Kukjin Kim <kgene@kernel.org>
Cc: Krzysztof Kozlowski <krzk@kernel.org>
Cc: devicetree@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-samsung-soc@vger.kernel.org
Signed-off-by: Lukasz Luba <l.luba@partner.samsung.com>
---
 arch/arm64/boot/dts/exynos/exynos5433-tmu.dtsi | 105 ++++++++++++++++---------
 1 file changed, 70 insertions(+), 35 deletions(-)

diff --git a/arch/arm64/boot/dts/exynos/exynos5433-tmu.dtsi b/arch/arm64/boot/dts/exynos/exynos5433-tmu.dtsi
index fe3a0b1..c4330f6 100644
--- a/arch/arm64/boot/dts/exynos/exynos5433-tmu.dtsi
+++ b/arch/arm64/boot/dts/exynos/exynos5433-tmu.dtsi
@@ -17,37 +17,44 @@ thermal-zones {
 			atlas0_alert_0: atlas0-alert-0 {
 				temperature = <65000>;	/* millicelsius */
 				hysteresis = <1000>;	/* millicelsius */
-				type = "active";
+				type = "passive";
+				irq-mode;
 			};
 			atlas0_alert_1: atlas0-alert-1 {
 				temperature = <70000>;	/* millicelsius */
 				hysteresis = <1000>;	/* millicelsius */
-				type = "active";
+				type = "passive";
+				irq-mode;
 			};
 			atlas0_alert_2: atlas0-alert-2 {
 				temperature = <75000>;	/* millicelsius */
 				hysteresis = <1000>;	/* millicelsius */
-				type = "active";
+				type = "passive";
+				irq-mode;
 			};
 			atlas0_alert_3: atlas0-alert-3 {
 				temperature = <80000>;	/* millicelsius */
 				hysteresis = <1000>;	/* millicelsius */
-				type = "active";
+				type = "passive";
+				irq-mode;
 			};
 			atlas0_alert_4: atlas0-alert-4 {
 				temperature = <85000>;	/* millicelsius */
 				hysteresis = <1000>;	/* millicelsius */
-				type = "active";
+				type = "passive";
+				irq-mode;
 			};
 			atlas0_alert_5: atlas0-alert-5 {
 				temperature = <90000>;	/* millicelsius */
 				hysteresis = <1000>;	/* millicelsius */
-				type = "active";
+				type = "passive";
+				irq-mode;
 			};
 			atlas0_alert_6: atlas0-alert-6 {
 				temperature = <95000>;	/* millicelsius */
 				hysteresis = <1000>;	/* millicelsius */
-				type = "active";
+				type = "passive";
+				irq-mode;
 			};
 		};
 
@@ -98,37 +105,44 @@ thermal-zones {
 			atlas1_alert_0: atlas1-alert-0 {
 				temperature = <65000>;	/* millicelsius */
 				hysteresis = <1000>;	/* millicelsius */
-				type = "active";
+				type = "passive";
+				irq-mode;
 			};
 			atlas1_alert_1: atlas1-alert-1 {
 				temperature = <70000>;	/* millicelsius */
 				hysteresis = <1000>;	/* millicelsius */
-				type = "active";
+				type = "passive";
+				irq-mode;
 			};
 			atlas1_alert_2: atlas1-alert-2 {
 				temperature = <75000>;	/* millicelsius */
 				hysteresis = <1000>;	/* millicelsius */
-				type = "active";
+				type = "passive";
+				irq-mode;
 			};
 			atlas1_alert_3: atlas1-alert-3 {
 				temperature = <80000>;	/* millicelsius */
 				hysteresis = <1000>;	/* millicelsius */
-				type = "active";
+				type = "passive";
+				irq-mode;
 			};
 			atlas1_alert_4: atlas1-alert-4 {
 				temperature = <85000>;	/* millicelsius */
 				hysteresis = <1000>;	/* millicelsius */
-				type = "active";
+				type = "passive";
+				irq-mode;
 			};
 			atlas1_alert_5: atlas1-alert-5 {
 				temperature = <90000>;	/* millicelsius */
 				hysteresis = <1000>;	/* millicelsius */
-				type = "active";
+				type = "passive";
+				irq-mode;
 			};
 			atlas1_alert_6: atlas1-alert-6 {
 				temperature = <95000>;	/* millicelsius */
 				hysteresis = <1000>;	/* millicelsius */
-				type = "active";
+				type = "passive";
+				irq-mode;
 			};
 		};
 	};
@@ -141,37 +155,44 @@ thermal-zones {
 			g3d_alert_0: g3d-alert-0 {
 				temperature = <70000>;	/* millicelsius */
 				hysteresis = <1000>;	/* millicelsius */
-				type = "active";
+				type = "passive";
+				irq-mode;
 			};
 			g3d_alert_1: g3d-alert-1 {
 				temperature = <75000>;	/* millicelsius */
 				hysteresis = <1000>;	/* millicelsius */
-				type = "active";
+				type = "passive";
+				irq-mode;
 			};
 			g3d_alert_2: g3d-alert-2 {
 				temperature = <80000>;	/* millicelsius */
 				hysteresis = <1000>;	/* millicelsius */
-				type = "active";
+				type = "passive";
+				irq-mode;
 			};
 			g3d_alert_3: g3d-alert-3 {
 				temperature = <85000>;	/* millicelsius */
 				hysteresis = <1000>;	/* millicelsius */
-				type = "active";
+				type = "passive";
+				irq-mode;
 			};
 			g3d_alert_4: g3d-alert-4 {
 				temperature = <90000>;	/* millicelsius */
 				hysteresis = <1000>;	/* millicelsius */
-				type = "active";
+				type = "passive";
+				irq-mode;
 			};
 			g3d_alert_5: g3d-alert-5 {
 				temperature = <95000>;	/* millicelsius */
 				hysteresis = <1000>;	/* millicelsius */
-				type = "active";
+				type = "passive";
+				irq-mode;
 			};
 			g3d_alert_6: g3d-alert-6 {
 				temperature = <100000>;	/* millicelsius */
 				hysteresis = <1000>;	/* millicelsius */
-				type = "active";
+				type = "passive";
+				irq-mode;
 			};
 		};
 	};
@@ -184,37 +205,44 @@ thermal-zones {
 			apollo_alert_0: apollo-alert-0 {
 				temperature = <65000>;	/* millicelsius */
 				hysteresis = <1000>;	/* millicelsius */
-				type = "active";
+				type = "passive";
+				irq-mode;
 			};
 			apollo_alert_1: apollo-alert-1 {
 				temperature = <70000>;	/* millicelsius */
 				hysteresis = <1000>;	/* millicelsius */
-				type = "active";
+				type = "passive";
+				irq-mode;
 			};
 			apollo_alert_2: apollo-alert-2 {
 				temperature = <75000>;	/* millicelsius */
 				hysteresis = <1000>;	/* millicelsius */
-				type = "active";
+				type = "passive";
+				irq-mode;
 			};
 			apollo_alert_3: apollo-alert-3 {
 				temperature = <80000>;	/* millicelsius */
 				hysteresis = <1000>;	/* millicelsius */
-				type = "active";
+				type = "passive";
+				irq-mode;
 			};
 			apollo_alert_4: apollo-alert-4 {
 				temperature = <85000>;	/* millicelsius */
 				hysteresis = <1000>;	/* millicelsius */
-				type = "active";
+				type = "passive";
+				irq-mode;
 			};
 			apollo_alert_5: apollo-alert-5 {
 				temperature = <90000>;	/* millicelsius */
 				hysteresis = <1000>;	/* millicelsius */
-				type = "active";
+				type = "passive";
+				irq-mode;
 			};
 			apollo_alert_6: apollo-alert-6 {
 				temperature = <95000>;	/* millicelsius */
 				hysteresis = <1000>;	/* millicelsius */
-				type = "active";
+				type = "passive";
+				irq-mode;
 			};
 		};
 
@@ -255,37 +283,44 @@ thermal-zones {
 			isp_alert_0: isp-alert-0 {
 				temperature = <80000>;	/* millicelsius */
 				hysteresis = <1000>;	/* millicelsius */
-				type = "active";
+				type = "passive";
+				irq-mode;
 			};
 			isp_alert_1: isp-alert-1 {
 				temperature = <85000>;	/* millicelsius */
 				hysteresis = <1000>;	/* millicelsius */
-				type = "active";
+				type = "passive";
+				irq-mode;
 			};
 			isp_alert_2: isp-alert-2 {
 				temperature = <90000>;	/* millicelsius */
 				hysteresis = <1000>;	/* millicelsius */
-				type = "active";
+				type = "passive";
+				irq-mode;
 			};
 			isp_alert_3: isp-alert-3 {
 				temperature = <95000>;	/* millicelsius */
 				hysteresis = <1000>;	/* millicelsius */
-				type = "active";
+				type = "passive";
+				irq-mode;
 			};
 			isp_alert_4: isp-alert-4 {
 				temperature = <100000>;	/* millicelsius */
 				hysteresis = <1000>;	/* millicelsius */
-				type = "active";
+				type = "passive";
+				irq-mode;
 			};
 			isp_alert_5: isp-alert-5 {
 				temperature = <105000>;	/* millicelsius */
 				hysteresis = <1000>;	/* millicelsius */
-				type = "active";
+				type = "passive";
+				irq-mode;
 			};
 			isp_alert_6: isp-alert-6 {
 				temperature = <110000>;	/* millicelsius */
 				hysteresis = <1000>;	/* millicelsius */
-				type = "active";
+				type = "passive";
+				irq-mode;
 			};
 		};
 	};
-- 
2.7.4
