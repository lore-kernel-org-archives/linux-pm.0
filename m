From: Amit Kucheria <amit.kucheria@linaro.org>
Subject: [PATCH v1 20/24] dt: thermal: tsens: Add bindings for qcs404
Date: Thu,  7 Feb 2019 16:19:38 +0530
Message-ID: <3f5a9282e815d2244b633a65e126494d23c16a7a.1549525708.git.amit.kucheria@linaro.org>
References: <cover.1549525708.git.amit.kucheria@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1549525708.git.amit.kucheria@linaro.org>
In-Reply-To: <cover.1549525708.git.amit.kucheria@linaro.org>
References: <cover.1549525708.git.amit.kucheria@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, bjorn.andersson@linaro.org, edubezval@gmail.com, andy.gross@linaro.org, Daniel Lezcano <daniel.lezcano@linaro.org>, David Brown <david.brown@linaro.org>, Zhang Rui <rui.zhang@intel.com>
Cc: linux-pm@vger.kernel.org, devicetree@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

qcs404 uses v1 of the TSENS IP block. Create a fallback DT property
"qcom,tsens-v1" to gather common code

Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
---
 .../devicetree/bindings/thermal/qcom-tsens.txt     | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/Documentation/devicetree/bindings/thermal/qcom-tsens.txt b/Documentation/devicetree/bindings/thermal/qcom-tsens.txt
index 1d9e8cf61018..673cc1831ee9 100644
--- a/Documentation/devicetree/bindings/thermal/qcom-tsens.txt
+++ b/Documentation/devicetree/bindings/thermal/qcom-tsens.txt
@@ -6,11 +6,14 @@ Required properties:
     - "qcom,msm8916-tsens" (MSM8916)
     - "qcom,msm8974-tsens" (MSM8974)
     - "qcom,msm8996-tsens" (MSM8996)
+    - "qcom,qcs404-tsens", "qcom,tsens-v1" (QCS404)
     - "qcom,msm8998-tsens", "qcom,tsens-v2" (MSM8998)
     - "qcom,sdm845-tsens", "qcom,tsens-v2" (SDM845)
   The generic "qcom,tsens-v2" property must be used as a fallback for any SoC
   with version 2 of the TSENS IP. MSM8996 is the only exception because the
   generic property did not exist when support was added.
+  Similarly, the generic "qcom,tsens-v1" property must be used as a fallback for
+  any SoC with version 1 of the TSENS IP.
 
 - reg: Address range of the thermal registers.
   New platforms containing v2.x.y of the TSENS IP must specify the SROT and TM
@@ -39,3 +42,14 @@ tsens0: thermal-sensor@c263000 {
 		#qcom,sensors = <13>;
 		#thermal-sensor-cells = <1>;
 	};
+
+Example 3 (for any platform containing v1 of the TSENS IP):
+tsens: thermal-sensor@4a9000 {
+		compatible = "qcom,qcs404-tsens", "qcom,tsens-v1";
+		reg = <0x004a9000 0x1000>, /* TM */
+		      <0x004a8000 0x1000>; /* SROT */
+		nvmem-cells = <&tsens_caldata>;
+		nvmem-cell-names = "calib";
+		#qcom,sensors = <10>;
+		#thermal-sensor-cells = <1>;
+	};
-- 
2.17.1
