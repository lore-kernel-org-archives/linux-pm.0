From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: [PATCH 11/12] dt-bindings: thermal: remove no longer needed samsung
 thermal properties
Date: Tue, 06 Mar 2018 15:43:54 +0100
Message-ID: <1520347435-22970-12-git-send-email-b.zolnierkie@samsung.com>
References: <1520347435-22970-1-git-send-email-b.zolnierkie@samsung.com>
        <CGME20180306144516epcas1p3e951e15e666779c870ad091d65041409@epcas1p3.samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <1520347435-22970-1-git-send-email-b.zolnierkie@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, Krzysztof Kozlowski <krzk@kernel.org>
Cc: Kukjin Kim <kgene@kernel.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Russell King <linux@armlinux.org.uk>, linux-samsung-soc@vger.kernel.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, b.zolnierkie@samsung.com
List-Id: linux-pm@vger.kernel.org

Remove documentation for longer needed samsung thermal properties.

Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
---
 .../devicetree/bindings/thermal/exynos-thermal.txt | 23 +++++-----------------
 1 file changed, 5 insertions(+), 18 deletions(-)

diff --git a/Documentation/devicetree/bindings/thermal/exynos-thermal.txt b/Documentation/devicetree/bindings/thermal/exynos-thermal.txt
index 1b596fd..b957acf 100644
--- a/Documentation/devicetree/bindings/thermal/exynos-thermal.txt
+++ b/Documentation/devicetree/bindings/thermal/exynos-thermal.txt
@@ -49,19 +49,6 @@ on the SoC (only first trip points defined in DT will be configured):
  - samsung,exynos5433-tmu: 8
  - samsung,exynos7-tmu: 8
 
-Following properties are mandatory (depending on SoC):
-- samsung,tmu_gain: Gain value for internal TMU operation.
-- samsung,tmu_reference_voltage: Value of TMU IP block's reference voltage
-- samsung,tmu_noise_cancel_mode: Mode for noise cancellation
-- samsung,tmu_efuse_value: Default level of temperature - it is needed when
-			   in factory fusing produced wrong value
-- samsung,tmu_min_efuse_value: Minimum temperature fused value
-- samsung,tmu_max_efuse_value: Maximum temperature fused value
-- samsung,tmu_first_point_trim: First point trimming value
-- samsung,tmu_second_point_trim: Second point trimming value
-- samsung,tmu_default_temp_offset: Default temperature offset
-- samsung,tmu_cal_type: Callibration type
-
 ** Optional properties:
 
 - vtmu-supply: This entry is optional and provides the regulator node supplying
@@ -78,7 +65,7 @@ Example 1):
 		clocks = <&clock 383>;
 		clock-names = "tmu_apbif";
 		vtmu-supply = <&tmu_regulator_node>;
-		#include "exynos4412-tmu-sensor-conf.dtsi"
+		#thermal-sensor-cells = <0>;
 	};
 
 Example 2):
@@ -89,7 +76,7 @@ Example 2):
 		interrupts = <0 58 0>;
 		clocks = <&clock 21>;
 		clock-names = "tmu_apbif";
-		#include "exynos5440-tmu-sensor-conf.dtsi"
+		#thermal-sensor-cells = <0>;
 	};
 
 Example 3): (In case of Exynos5420 "with misplaced TRIMINFO register")
@@ -99,7 +86,7 @@ Example 3): (In case of Exynos5420 "with misplaced TRIMINFO register")
 		interrupts = <0 184 0>;
 		clocks = <&clock 318>, <&clock 318>;
 		clock-names = "tmu_apbif", "tmu_triminfo_apbif";
-		#include "exynos4412-tmu-sensor-conf.dtsi"
+		#thermal-sensor-cells = <0>;
 	};
 
 	tmu_cpu3: tmu@1006c000 {
@@ -108,7 +95,7 @@ Example 3): (In case of Exynos5420 "with misplaced TRIMINFO register")
 		interrupts = <0 185 0>;
 		clocks = <&clock 318>, <&clock 319>;
 		clock-names = "tmu_apbif", "tmu_triminfo_apbif";
-		#include "exynos4412-tmu-sensor-conf.dtsi"
+		#thermal-sensor-cells = <0>;
 	};
 
 	tmu_gpu: tmu@100a0000 {
@@ -117,7 +104,7 @@ Example 3): (In case of Exynos5420 "with misplaced TRIMINFO register")
 		interrupts = <0 215 0>;
 		clocks = <&clock 319>, <&clock 318>;
 		clock-names = "tmu_apbif", "tmu_triminfo_apbif";
-		#include "exynos4412-tmu-sensor-conf.dtsi"
+		#thermal-sensor-cells = <0>;
 	};
 
 Note: For multi-instance tmu each instance should have an alias correctly
-- 
1.9.1
