From: Lukasz Luba <l.luba@partner.samsung.com>
Subject: [PATCH 11/11] DT: arm: exynos: add support for thermal trip
 irq-mode
Date: Tue, 16 Oct 2018 16:56:22 +0200
Message-ID: <20181016145653eucas1p2c408ac952ed5c351c98398fa3df373e6~eHqRiOtv50773307733eucas1p20@eucas1p2.samsung.com>
References: <1539701782-26852-1-git-send-email-l.luba@partner.samsung.com>
        <CGME20181016145653eucas1p2c408ac952ed5c351c98398fa3df373e6@eucas1p2.samsung.com>
Content-Type: text/plain; charset="utf-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1539701782-26852-1-git-send-email-l.luba@partner.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Cc: rui.zhang@intel.com, edubezval@gmail.com, daniel.lezcano@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com, corbet@lwn.net, b.zolnierkie@samsung.com, Lukasz Luba <l.luba@partner.samsung.com>, Kukjin Kim <kgene@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>
List-Id: linux-pm@vger.kernel.org

This patch adds support for new flash which indicates
that trip point triggers irq when temperature is met.
Exynos5433 supports 8 trip point which will trigger irq.
Above that number other trip points should be registered
without 'irq-mode' flag.
That will force the thermal framework to start polling
the temperature sensor under configured conditions and
handle the trip point.

Cc: Kukjin Kim <kgene@kernel.org>
Cc: Krzysztof Kozlowski <krzk@kernel.org>
Cc: devicetree@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org
Signed-off-by: Lukasz Luba <l.luba@partner.samsung.com>
---
 arch/arm/boot/dts/exynos5410-odroidxu.dts | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/exynos5410-odroidxu.dts b/arch/arm/boot/dts/exynos5410-odroidxu.dts
index a2046f5..c255466 100644
--- a/arch/arm/boot/dts/exynos5410-odroidxu.dts
+++ b/arch/arm/boot/dts/exynos5410-odroidxu.dts
@@ -121,22 +121,26 @@
 		cpu_alert0: cpu-alert-0 {
 			temperature = <50000>; /* millicelsius */
 			hysteresis = <5000>; /* millicelsius */
-			type = "active";
+			type = "passive";
+			irq-mode;
 		};
 		cpu_alert1: cpu-alert-1 {
 			temperature = <60000>; /* millicelsius */
 			hysteresis = <5000>; /* millicelsius */
-			type = "active";
+			type = "passive";
+			irq-mode;
 		};
 		cpu_alert2: cpu-alert-2 {
 			temperature = <70000>; /* millicelsius */
 			hysteresis = <5000>; /* millicelsius */
-			type = "active";
+			type = "passive";
+			irq-mode;
 		};
 		cpu_crit0: cpu-crit-0 {
 			temperature = <120000>; /* millicelsius */
 			hysteresis = <0>; /* millicelsius */
 			type = "critical";
+			irq-mode;
 		};
 	};
 
-- 
2.7.4
