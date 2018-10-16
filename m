From: Lukasz Luba <l.luba@partner.samsung.com>
Subject: [PATCH 07/11] DT: arm64: exynos7: add support for thermal trip
 irq-mode
Date: Tue, 16 Oct 2018 16:56:18 +0200
Message-ID: <20181016145648eucas1p275ad5f845a04e40e5b9d0bbea624f34a~eHqM4Yhz82489624896eucas1p25@eucas1p2.samsung.com>
References: <1539701782-26852-1-git-send-email-l.luba@partner.samsung.com>
        <CGME20181016145648eucas1p275ad5f845a04e40e5b9d0bbea624f34a@eucas1p2.samsung.com>
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
 arch/arm64/boot/dts/exynos/exynos7-trip-points.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm64/boot/dts/exynos/exynos7-trip-points.dtsi b/arch/arm64/boot/dts/exynos/exynos7-trip-points.dtsi
index d3301b8..39185af 100644
--- a/arch/arm64/boot/dts/exynos/exynos7-trip-points.dtsi
+++ b/arch/arm64/boot/dts/exynos/exynos7-trip-points.dtsi
@@ -11,40 +11,48 @@ trips {
 		temperature = <75000>; /* millicelsius */
 		hysteresis = <10000>; /* millicelsius */
 		type = "passive";
+		irq-mode;
 	};
 	cpu-alert-1 {
 		temperature = <80000>; /* millicelsius */
 		hysteresis = <10000>; /* millicelsius */
 		type = "passive";
+		irq-mode;
 	};
 	cpu-alert-2 {
 		temperature = <85000>; /* millicelsius */
 		hysteresis = <10000>; /* millicelsius */
 		type = "passive";
+		irq-mode;
 	};
 	cpu-alert-3 {
 		temperature = <90000>; /* millicelsius */
 		hysteresis = <10000>; /* millicelsius */
 		type = "passive";
+		irq-mode;
 	};
 	cpu-alert-4 {
 		temperature = <95000>; /* millicelsius */
 		hysteresis = <10000>; /* millicelsius */
 		type = "passive";
+		irq-mode;
 	};
 	cpu-alert-5 {
 		temperature = <100000>; /* millicelsius */
 		hysteresis = <10000>; /* millicelsius */
 		type = "passive";
+		irq-mode;
 	};
 	cpu-alert-6 {
 		temperature = <110000>; /* millicelsius */
 		hysteresis = <10000>; /* millicelsius */
 		type = "passive";
+		irq-mode;
 	};
 	cpu-crit-0 {
 		temperature = <115000>; /* millicelsius */
 		hysteresis = <0>; /* millicelsius */
 		type = "critical";
+		irq-mode;
 	};
 };
-- 
2.7.4
