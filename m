From: Lukasz Majewski <l.majewski@samsung.com>
Subject: [PATCH v3 09/16] dts: Documentation: Extending documentation entry for
 exynos-thermal
Date: Wed, 14 Jan 2015 14:41:07 +0100
Message-ID: <1421242874-3425-10-git-send-email-l.majewski@samsung.com>
References: <1412872737-624-1-git-send-email-l.majewski@samsung.com>
 <1421242874-3425-1-git-send-email-l.majewski@samsung.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout2.samsung.com ([203.254.224.25]:22093 "EHLO
	mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751404AbbANNrA (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 14 Jan 2015 08:47:00 -0500
In-reply-to: <1421242874-3425-1-git-send-email-l.majewski@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Eduardo Valentin <edubezval@gmail.com>, Zhang Rui <rui.zhang@intel.com>, Kukjin Kim <kgene.kim@samsung.com>, Kukjin Kim <kgene@kernel.org>
Cc: Linux PM list <linux-pm@vger.kernel.org>, "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Lukasz Majewski <l.majewski@majess.pl>, Amit Daniel Kachhap <amit.daniel@samsung.com>, Abhilash Kesavan <kesavan.abhilash@gmail.com>, Kyungmin Park <kyungmin.park@samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>, Lukasz Majewski <l.majewski@samsung.com>

Properties necessary for providing Exynos thermal configuration via device
tree.

Signed-off-by: Lukasz Majewski <l.majewski@samsung.com>
---
Changes for v3:
- New patch

---
 .../devicetree/bindings/thermal/exynos-thermal.txt      | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/Documentation/devicetree/bindings/thermal/exynos-thermal.txt b/Documentation/devicetree/bindings/thermal/exynos-thermal.txt
index ae738f5..0f44932 100644
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
@@ -61,6 +74,7 @@ Example 2):
 		interrupts = <0 58 0>;
 		clocks = <&clock 21>;
 		clock-names = "tmu_apbif";
+		#include "exynos5440-tmu-sensor-conf.dtsi"
 	};
 
 Example 3): (In case of Exynos5420 "with misplaced TRIMINFO register")
@@ -70,6 +84,7 @@ Example 3): (In case of Exynos5420 "with misplaced TRIMINFO register")
 		interrupts = <0 184 0>;
 		clocks = <&clock 318>, <&clock 318>;
 		clock-names = "tmu_apbif", "tmu_triminfo_apbif";
+		#include "exynos4412-tmu-sensor-conf.dtsi"
 	};
 
 	tmu_cpu3: tmu@1006c000 {
@@ -78,6 +93,7 @@ Example 3): (In case of Exynos5420 "with misplaced TRIMINFO register")
 		interrupts = <0 185 0>;
 		clocks = <&clock 318>, <&clock 319>;
 		clock-names = "tmu_apbif", "tmu_triminfo_apbif";
+		#include "exynos4412-tmu-sensor-conf.dtsi"
 	};
 
 	tmu_gpu: tmu@100a0000 {
@@ -86,6 +102,7 @@ Example 3): (In case of Exynos5420 "with misplaced TRIMINFO register")
 		interrupts = <0 215 0>;
 		clocks = <&clock 319>, <&clock 318>;
 		clock-names = "tmu_apbif", "tmu_triminfo_apbif";
+		#include "exynos4412-tmu-sensor-conf.dtsi"
 	};
 
 Note: For multi-instance tmu each instance should have an alias correctly
-- 
2.0.0.rc2

