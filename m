From: Lukasz Luba <l.luba@partner.samsung.com>
Subject: [PATCH v2 08/11] arm: dts: exynos4: add support for thermal trip
 irq-mode
Date: Wed,  7 Nov 2018 18:09:50 +0100
Message-ID: <1541610593-28542-9-git-send-email-l.luba@partner.samsung.com>
References: <1541610593-28542-1-git-send-email-l.luba@partner.samsung.com>
        <CGME20181107171043eucas1p16be3fa901c7bceb129c70fc81dba6e48@eucas1p1.samsung.com>
Content-Type: text/plain; charset="utf-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1541610593-28542-1-git-send-email-l.luba@partner.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Cc: rui.zhang@intel.com, edubezval@gmail.com, daniel.lezcano@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com, corbet@lwn.net, b.zolnierkie@samsung.com, krzk@kernel.org, Lukasz Luba <l.luba@partner.samsung.com>, Kukjin Kim <kgene@kernel.org>, linux-samsung-soc@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

This patch adds support for new flag which indicates
that trip point triggers IRQ when temperature is met.
Change existing trip points to be expicitly marked with the new flag.

Cc: Kukjin Kim <kgene@kernel.org>
Cc: Krzysztof Kozlowski <krzk@kernel.org>
Cc: devicetree@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-samsung-soc@vger.kernel.org
Signed-off-by: Lukasz Luba <l.luba@partner.samsung.com>
---
 arch/arm/boot/dts/exynos4-cpu-thermal.dtsi | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/exynos4-cpu-thermal.dtsi b/arch/arm/boot/dts/exynos4-cpu-thermal.dtsi
index 021d9fc..5e07289 100644
--- a/arch/arm/boot/dts/exynos4-cpu-thermal.dtsi
+++ b/arch/arm/boot/dts/exynos4-cpu-thermal.dtsi
@@ -17,22 +17,26 @@ thermal-zones {
 			cpu_alert0: cpu-alert-0 {
 				temperature = <70000>; /* millicelsius */
 				hysteresis = <10000>; /* millicelsius */
-				type = "active";
+				type = "passive";
+				irq-mode;
 			};
 			cpu_alert1: cpu-alert-1 {
 				temperature = <95000>; /* millicelsius */
 				hysteresis = <10000>; /* millicelsius */
-				type = "active";
+				type = "passive";
+				irq-mode;
 			};
 			cpu_alert2: cpu-alert-2 {
 				temperature = <110000>; /* millicelsius */
 				hysteresis = <10000>; /* millicelsius */
-				type = "active";
+				type = "passive";
+				irq-mode;
 			};
 			cpu_crit0: cpu-crit-0 {
 				temperature = <120000>; /* millicelsius */
 				hysteresis = <0>; /* millicelsius */
 				type = "critical";
+				irq-mode;
 			};
 		};
 		cooling-maps {
-- 
2.7.4
