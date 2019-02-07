From: Amit Kucheria <amit.kucheria@linaro.org>
Subject: [PATCH v1 08/24] drivers: thermal: tsens: Rename constants to prepare to merge with tsens-8974
Date: Thu,  7 Feb 2019 16:19:26 +0530
Message-ID: <459c70bd13bf8a9231fa3f1c9694231fb9169d18.1549525708.git.amit.kucheria@linaro.org>
References: <cover.1549525708.git.amit.kucheria@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1549525708.git.amit.kucheria@linaro.org>
In-Reply-To: <cover.1549525708.git.amit.kucheria@linaro.org>
References: <cover.1549525708.git.amit.kucheria@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, bjorn.andersson@linaro.org, edubezval@gmail.com, andy.gross@linaro.org, Daniel Lezcano <daniel.lezcano@linaro.org>, David Brown <david.brown@linaro.org>, Zhang Rui <rui.zhang@intel.com>
Cc: linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Some #defines in tsens-v_0_1.c clash with those in tsens-8974.c. Prefix
them with 8916 to avoid the clash so we can merge the two files.

Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
---
 drivers/thermal/qcom/tsens-v0_1.c | 88 +++++++++++++++----------------
 1 file changed, 44 insertions(+), 44 deletions(-)

diff --git a/drivers/thermal/qcom/tsens-v0_1.c b/drivers/thermal/qcom/tsens-v0_1.c
index d4ad4082c800..30909594b1cf 100644
--- a/drivers/thermal/qcom/tsens-v0_1.c
+++ b/drivers/thermal/qcom/tsens-v0_1.c
@@ -7,37 +7,37 @@
 #include "tsens.h"
 
 /* eeprom layout data for 8916 */
-#define BASE0_MASK	0x0000007f
-#define BASE1_MASK	0xfe000000
-#define BASE0_SHIFT	0
-#define BASE1_SHIFT	25
-
-#define S0_P1_MASK	0x00000f80
-#define S1_P1_MASK	0x003e0000
-#define S2_P1_MASK	0xf8000000
-#define S3_P1_MASK	0x000003e0
-#define S4_P1_MASK	0x000f8000
-
-#define S0_P2_MASK	0x0001f000
-#define S1_P2_MASK	0x07c00000
-#define S2_P2_MASK	0x0000001f
-#define S3_P2_MASK	0x00007c00
-#define S4_P2_MASK	0x01f00000
-
-#define S0_P1_SHIFT	7
-#define S1_P1_SHIFT	17
-#define S2_P1_SHIFT	27
-#define S3_P1_SHIFT	5
-#define S4_P1_SHIFT	15
-
-#define S0_P2_SHIFT	12
-#define S1_P2_SHIFT	22
-#define S2_P2_SHIFT	0
-#define S3_P2_SHIFT	10
-#define S4_P2_SHIFT	20
-
-#define CAL_SEL_MASK	0xe0000000
-#define CAL_SEL_SHIFT	29
+#define MSM8916_BASE0_MASK	0x0000007f
+#define MSM8916_BASE1_MASK	0xfe000000
+#define MSM8916_BASE0_SHIFT	0
+#define MSM8916_BASE1_SHIFT	25
+
+#define MSM8916_S0_P1_MASK	0x00000f80
+#define MSM8916_S1_P1_MASK	0x003e0000
+#define MSM8916_S2_P1_MASK	0xf8000000
+#define MSM8916_S3_P1_MASK	0x000003e0
+#define MSM8916_S4_P1_MASK	0x000f8000
+
+#define MSM8916_S0_P2_MASK	0x0001f000
+#define MSM8916_S1_P2_MASK	0x07c00000
+#define MSM8916_S2_P2_MASK	0x0000001f
+#define MSM8916_S3_P2_MASK	0x00007c00
+#define MSM8916_S4_P2_MASK	0x01f00000
+
+#define MSM8916_S0_P1_SHIFT	7
+#define MSM8916_S1_P1_SHIFT	17
+#define MSM8916_S2_P1_SHIFT	27
+#define MSM8916_S3_P1_SHIFT	5
+#define MSM8916_S4_P1_SHIFT	15
+
+#define MSM8916_S0_P2_SHIFT	12
+#define MSM8916_S1_P2_SHIFT	22
+#define MSM8916_S2_P2_SHIFT	0
+#define MSM8916_S3_P2_SHIFT	10
+#define MSM8916_S4_P2_SHIFT	20
+
+#define MSM8916_CAL_SEL_MASK	0xe0000000
+#define MSM8916_CAL_SEL_SHIFT	29
 
 static int calibrate_8916(struct tsens_priv *priv)
 {
@@ -54,27 +54,27 @@ static int calibrate_8916(struct tsens_priv *priv)
 	if (IS_ERR(qfprom_csel))
 		return PTR_ERR(qfprom_csel);
 
-	mode = (qfprom_csel[0] & CAL_SEL_MASK) >> CAL_SEL_SHIFT;
+	mode = (qfprom_csel[0] & MSM8916_CAL_SEL_MASK) >> MSM8916_CAL_SEL_SHIFT;
 	dev_dbg(priv->dev, "calibration mode is %d\n", mode);
 
 	switch (mode) {
 	case TWO_PT_CALIB:
-		base1 = (qfprom_cdata[1] & BASE1_MASK) >> BASE1_SHIFT;
-		p2[0] = (qfprom_cdata[0] & S0_P2_MASK) >> S0_P2_SHIFT;
-		p2[1] = (qfprom_cdata[0] & S1_P2_MASK) >> S1_P2_SHIFT;
-		p2[2] = (qfprom_cdata[1] & S2_P2_MASK) >> S2_P2_SHIFT;
-		p2[3] = (qfprom_cdata[1] & S3_P2_MASK) >> S3_P2_SHIFT;
-		p2[4] = (qfprom_cdata[1] & S4_P2_MASK) >> S4_P2_SHIFT;
+		base1 = (qfprom_cdata[1] & MSM8916_BASE1_MASK) >> MSM8916_BASE1_SHIFT;
+		p2[0] = (qfprom_cdata[0] & MSM8916_S0_P2_MASK) >> MSM8916_S0_P2_SHIFT;
+		p2[1] = (qfprom_cdata[0] & MSM8916_S1_P2_MASK) >> MSM8916_S1_P2_SHIFT;
+		p2[2] = (qfprom_cdata[1] & MSM8916_S2_P2_MASK) >> MSM8916_S2_P2_SHIFT;
+		p2[3] = (qfprom_cdata[1] & MSM8916_S3_P2_MASK) >> MSM8916_S3_P2_SHIFT;
+		p2[4] = (qfprom_cdata[1] & MSM8916_S4_P2_MASK) >> MSM8916_S4_P2_SHIFT;
 		for (i = 0; i < priv->num_sensors; i++)
 			p2[i] = ((base1 + p2[i]) << 3);
 		/* Fall through */
 	case ONE_PT_CALIB2:
-		base0 = (qfprom_cdata[0] & BASE0_MASK);
-		p1[0] = (qfprom_cdata[0] & S0_P1_MASK) >> S0_P1_SHIFT;
-		p1[1] = (qfprom_cdata[0] & S1_P1_MASK) >> S1_P1_SHIFT;
-		p1[2] = (qfprom_cdata[0] & S2_P1_MASK) >> S2_P1_SHIFT;
-		p1[3] = (qfprom_cdata[1] & S3_P1_MASK) >> S3_P1_SHIFT;
-		p1[4] = (qfprom_cdata[1] & S4_P1_MASK) >> S4_P1_SHIFT;
+		base0 = (qfprom_cdata[0] & MSM8916_BASE0_MASK);
+		p1[0] = (qfprom_cdata[0] & MSM8916_S0_P1_MASK) >> MSM8916_S0_P1_SHIFT;
+		p1[1] = (qfprom_cdata[0] & MSM8916_S1_P1_MASK) >> MSM8916_S1_P1_SHIFT;
+		p1[2] = (qfprom_cdata[0] & MSM8916_S2_P1_MASK) >> MSM8916_S2_P1_SHIFT;
+		p1[3] = (qfprom_cdata[1] & MSM8916_S3_P1_MASK) >> MSM8916_S3_P1_SHIFT;
+		p1[4] = (qfprom_cdata[1] & MSM8916_S4_P1_MASK) >> MSM8916_S4_P1_SHIFT;
 		for (i = 0; i < priv->num_sensors; i++)
 			p1[i] = (((base0) + p1[i]) << 3);
 		break;
-- 
2.17.1
