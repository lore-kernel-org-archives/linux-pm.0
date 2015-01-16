From: Lukasz Majewski <l.majewski@samsung.com>
Subject: [PATCH v4 09/17] dts: Documentation: Extending documentation entry for
 exynos-thermal
Date: Fri, 16 Jan 2015 12:30:53 +0100
Message-ID: <1421407861-25099-10-git-send-email-l.majewski@samsung.com>
References: <1412872737-624-1-git-send-email-l.majewski@samsung.com>
 <1421407861-25099-1-git-send-email-l.majewski@samsung.com>
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-reply-to: <1421407861-25099-1-git-send-email-l.majewski@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Eduardo Valentin <edubezval@gmail.com>, Zhang Rui <rui.zhang@intel.com>, Kukjin Kim <kgene.kim@samsung.com>, Kukjin Kim <kgene@kernel.org>
Cc: Linux PM list <linux-pm@vger.kernel.org>, "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Lukasz Majewski <l.majewski@majess.pl>, Amit Daniel Kachhap <amit.daniel@samsung.com>, Abhilash Kesavan <kesavan.abhilash@gmail.com>, Kyungmin Park <kyungmin.park@samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>, Abhilash Kesavan <a.kesavan@samsung.com>, Lukasz Majewski <l.majewski@samsung.com>
List-Id: linux-pm@vger.kernel.org

Properties necessary for providing Exynos thermal configuration via device
tree.

Signed-off-by: Lukasz Majewski <l.majewski@samsung.com>
---
Changes for v3:
- New patch
Changes for v4:
- Remove entry regarding Exynos5440

---
 .../devicetree/bindings/thermal/exynos-thermal.txt       | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/Documentation/devicetree/bindings/thermal/exynos-thermal.txt b/Documentation/devicetree/bindings/thermal/exynos-thermal.txt
index ae738f5..8497794 100644
--- a/Documentation/devicetree/bindings/thermal/exynos-thermal.txt
+++ b/Documentation/devicetree/bindings/thermal/exynos-thermal.txt
@@ -39,6 +39,18 @@
 - vtmu-supply: This entry is optional and provides the regulator node supplying
 		voltage to TMU. If needed this entry can be placed inside
 		board/platform specific dts file.
+Following properties are mandatory (depending on SoC):
+- samsung,tmu_gain: Gain value for internal TMU operation.
+- samsung,tmu_reference_voltage: Value of TMU IP block's reference voltage
+- samsung,tmu_noise_cancel_mode: Mode for noise cancellation
+- samsung,tmu_efuse_value: Default level of temperature - it is needed when
+			   in factory fusing produced wrong value
+- samsung,tmu_min_efuse_value: Minimum temperature fused value
+- samsung,tmu_max_efuse_value: Maximum temperature fused value
+- samsung,tmu_first_point_trim: First point trimming value
+- samsung,tmu_second_point_trim: Second point trimming value
+- samsung,tmu_default_temp_offset: Default temperature offset
+- samsung,tmu_cal_type: Callibration type
 
 Example 1):
 
@@ -51,6 +63,7 @@ Example 1):
 		clock-names = "tmu_apbif";
 		status = "disabled";
 		vtmu-supply = <&tmu_regulator_node>;
+		#include "exynos4412-tmu-sensor-conf.dtsi"
 	};
 
 Example 2):
@@ -70,6 +83,7 @@ Example 3): (In case of Exynos5420 "with misplaced TRIMINFO register")
 		interrupts = <0 184 0>;
 		clocks = <&clock 318>, <&clock 318>;
 		clock-names = "tmu_apbif", "tmu_triminfo_apbif";
+		#include "exynos4412-tmu-sensor-conf.dtsi"
 	};
 
 	tmu_cpu3: tmu@1006c000 {
@@ -78,6 +92,7 @@ Example 3): (In case of Exynos5420 "with misplaced TRIMINFO register")
 		interrupts = <0 185 0>;
 		clocks = <&clock 318>, <&clock 319>;
 		clock-names = "tmu_apbif", "tmu_triminfo_apbif";
+		#include "exynos4412-tmu-sensor-conf.dtsi"
 	};
 
 	tmu_gpu: tmu@100a0000 {
@@ -86,6 +101,7 @@ Example 3): (In case of Exynos5420 "with misplaced TRIMINFO register")
 		interrupts = <0 215 0>;
 		clocks = <&clock 319>, <&clock 318>;
 		clock-names = "tmu_apbif", "tmu_triminfo_apbif";
+		#include "exynos4412-tmu-sensor-conf.dtsi"
 	};
 
 Note: For multi-instance tmu each instance should have an alias correctly
-- 
2.0.0.rc2
