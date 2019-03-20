From: Amit Kucheria <amit.kucheria@linaro.org>
Subject: [PATCHv3 20/23] drivers: thermal: tsens: Add generic support for TSENS v1 IP
Date: Wed, 20 Mar 2019 18:48:00 +0530
Message-ID: <6ff45cf459beade7f71eb9323d84a872b6ba1021.1553086065.git.amit.kucheria@linaro.org>
References: <cover.1553086065.git.amit.kucheria@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1553086065.git.amit.kucheria@linaro.org>
In-Reply-To: <cover.1553086065.git.amit.kucheria@linaro.org>
References: <cover.1553086065.git.amit.kucheria@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, bjorn.andersson@linaro.org, edubezval@gmail.com, andy.gross@linaro.org, Daniel Lezcano <daniel.lezcano@linaro.org>, David Brown <david.brown@linaro.org>, Zhang Rui <rui.zhang@intel.com>
Cc: linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

qcs404 has a single TSENS IP block with 10 sensors. It uses version 1.4
of the TSENS IP, functionality for which is encapsulated inside the
qcom,tsens-v1 compatible.

Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
---
 drivers/thermal/qcom/Makefile   |   4 +-
 drivers/thermal/qcom/tsens-v1.c | 193 ++++++++++++++++++++++++++++++++
 drivers/thermal/qcom/tsens.c    |   3 +
 drivers/thermal/qcom/tsens.h    |   3 +
 4 files changed, 202 insertions(+), 1 deletion(-)
 create mode 100644 drivers/thermal/qcom/tsens-v1.c

diff --git a/drivers/thermal/qcom/Makefile b/drivers/thermal/qcom/Makefile
index 7fa3cadce760..fc6fe50cdde4 100644
--- a/drivers/thermal/qcom/Makefile
+++ b/drivers/thermal/qcom/Makefile
@@ -1,3 +1,5 @@
 obj-$(CONFIG_QCOM_TSENS)	+= qcom_tsens.o
-qcom_tsens-y			+= tsens.o tsens-common.o tsens-v0_1.o tsens-8960.o tsens-v2.o
+
+qcom_tsens-y			+= tsens.o tsens-common.o tsens-v0_1.o \
+				   tsens-8960.o tsens-v2.o tsens-v1.o
 obj-$(CONFIG_QCOM_SPMI_TEMP_ALARM)	+= qcom-spmi-temp-alarm.o
diff --git a/drivers/thermal/qcom/tsens-v1.c b/drivers/thermal/qcom/tsens-v1.c
new file mode 100644
index 000000000000..a1221efd1ddc
--- /dev/null
+++ b/drivers/thermal/qcom/tsens-v1.c
@@ -0,0 +1,193 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2019, Linaro Limited
+ */
+
+#include <linux/bitops.h>
+#include <linux/regmap.h>
+#include <linux/delay.h>
+#include "tsens.h"
+
+/* ----- SROT ------ */
+#define SROT_HW_VER_OFF	0x0000
+#define SROT_CTRL_OFF		0x0004
+
+/* ----- TM ------ */
+#define TM_INT_EN_OFF				0x0000
+#define TM_Sn_UPPER_LOWER_STATUS_CTRL_OFF	0x0004
+#define TM_Sn_STATUS_OFF			0x0044
+#define TM_TRDY_OFF				0x0084
+
+/* eeprom layout data for qcs404/405 (v1) */
+#define BASE0_MASK	0x000007f8
+#define BASE1_MASK	0x0007f800
+#define BASE0_SHIFT	3
+#define BASE1_SHIFT	11
+
+#define S0_P1_MASK	0x0000003f
+#define S1_P1_MASK	0x0003f000
+#define S2_P1_MASK	0x3f000000
+#define S3_P1_MASK	0x000003f0
+#define S4_P1_MASK	0x003f0000
+#define S5_P1_MASK	0x0000003f
+#define S6_P1_MASK	0x0003f000
+#define S7_P1_MASK	0x3f000000
+#define S8_P1_MASK	0x000003f0
+#define S9_P1_MASK	0x003f0000
+
+#define S0_P2_MASK	0x00000fc0
+#define S1_P2_MASK	0x00fc0000
+#define S2_P2_MASK_1_0	0xc0000000
+#define S2_P2_MASK_5_2	0x0000000f
+#define S3_P2_MASK	0x0000fc00
+#define S4_P2_MASK	0x0fc00000
+#define S5_P2_MASK	0x00000fc0
+#define S6_P2_MASK	0x00fc0000
+#define S7_P2_MASK_1_0	0xc0000000
+#define S7_P2_MASK_5_2	0x0000000f
+#define S8_P2_MASK	0x0000fc00
+#define S9_P2_MASK	0x0fc00000
+
+#define S0_P1_SHIFT	0
+#define S0_P2_SHIFT	6
+#define S1_P1_SHIFT	12
+#define S1_P2_SHIFT	18
+#define S2_P1_SHIFT	24
+#define S2_P2_SHIFT_1_0	30
+
+#define S2_P2_SHIFT_5_2	0
+#define S3_P1_SHIFT	4
+#define S3_P2_SHIFT	10
+#define S4_P1_SHIFT	16
+#define S4_P2_SHIFT	22
+
+#define S5_P1_SHIFT	0
+#define S5_P2_SHIFT	6
+#define S6_P1_SHIFT	12
+#define S6_P2_SHIFT	18
+#define S7_P1_SHIFT	24
+#define S7_P2_SHIFT_1_0	30
+
+#define S7_P2_SHIFT_5_2	0
+#define S8_P1_SHIFT	4
+#define S8_P2_SHIFT	10
+#define S9_P1_SHIFT	16
+#define S9_P2_SHIFT	22
+
+#define CAL_SEL_MASK	7
+#define CAL_SEL_SHIFT	0
+
+static int calibrate_v1(struct tsens_priv *priv)
+{
+	u32 base0 = 0, base1 = 0;
+	u32 p1[10], p2[10];
+	u32 mode = 0, lsb = 0, msb = 0;
+	u32 *qfprom_cdata;
+	int i;
+
+	qfprom_cdata = (u32 *)qfprom_read(priv->dev, "calib");
+	if (IS_ERR(qfprom_cdata))
+		return PTR_ERR(qfprom_cdata);
+
+	mode = (qfprom_cdata[4] & CAL_SEL_MASK) >> CAL_SEL_SHIFT;
+	dev_dbg(priv->dev, "calibration mode is %d\n", mode);
+
+	switch (mode) {
+	case TWO_PT_CALIB:
+		base1 = (qfprom_cdata[4] & BASE1_MASK) >> BASE1_SHIFT;
+		p2[0] = (qfprom_cdata[0] & S0_P2_MASK) >> S0_P2_SHIFT;
+		p2[1] = (qfprom_cdata[0] & S1_P2_MASK) >> S1_P2_SHIFT;
+		/* This value is split over two registers, 2 bits and 4 bits */
+		lsb   = (qfprom_cdata[0] & S2_P2_MASK_1_0) >> S2_P2_SHIFT_1_0;
+		msb   = (qfprom_cdata[1] & S2_P2_MASK_5_2) >> S2_P2_SHIFT_5_2;
+		p2[2] = msb << 2 | lsb;
+		p2[3] = (qfprom_cdata[1] & S3_P2_MASK) >> S3_P2_SHIFT;
+		p2[4] = (qfprom_cdata[1] & S4_P2_MASK) >> S4_P2_SHIFT;
+		p2[5] = (qfprom_cdata[2] & S5_P2_MASK) >> S5_P2_SHIFT;
+		p2[6] = (qfprom_cdata[2] & S6_P2_MASK) >> S6_P2_SHIFT;
+		/* This value is split over two registers, 2 bits and 4 bits */
+		lsb   = (qfprom_cdata[2] & S7_P2_MASK_1_0) >> S7_P2_SHIFT_1_0;
+		msb   = (qfprom_cdata[3] & S7_P2_MASK_5_2) >> S7_P2_SHIFT_5_2;
+		p2[7] = msb << 2 | lsb;
+		p2[8] = (qfprom_cdata[3] & S8_P2_MASK) >> S8_P2_SHIFT;
+		p2[9] = (qfprom_cdata[3] & S9_P2_MASK) >> S9_P2_SHIFT;
+		for (i = 0; i < priv->num_sensors; i++)
+			p2[i] = ((base1 + p2[i]) << 2);
+		/* Fall through */
+	case ONE_PT_CALIB2:
+		base0 = (qfprom_cdata[4] & BASE0_MASK) >> BASE0_SHIFT;
+		p1[0] = (qfprom_cdata[0] & S0_P1_MASK) >> S0_P1_SHIFT;
+		p1[1] = (qfprom_cdata[0] & S1_P1_MASK) >> S1_P1_SHIFT;
+		p1[2] = (qfprom_cdata[0] & S2_P1_MASK) >> S2_P1_SHIFT;
+		p1[3] = (qfprom_cdata[1] & S3_P1_MASK) >> S3_P1_SHIFT;
+		p1[4] = (qfprom_cdata[1] & S4_P1_MASK) >> S4_P1_SHIFT;
+		p1[5] = (qfprom_cdata[2] & S5_P1_MASK) >> S5_P1_SHIFT;
+		p1[6] = (qfprom_cdata[2] & S6_P1_MASK) >> S6_P1_SHIFT;
+		p1[7] = (qfprom_cdata[2] & S7_P1_MASK) >> S7_P1_SHIFT;
+		p1[8] = (qfprom_cdata[3] & S8_P1_MASK) >> S8_P1_SHIFT;
+		p1[9] = (qfprom_cdata[3] & S9_P1_MASK) >> S9_P1_SHIFT;
+		for (i = 0; i < priv->num_sensors; i++)
+			p1[i] = (((base0) + p1[i]) << 2);
+		break;
+	default:
+		for (i = 0; i < priv->num_sensors; i++) {
+			p1[i] = 500;
+			p2[i] = 780;
+		}
+		break;
+	}
+
+	compute_intercept_slope(priv, p1, p2, mode);
+
+	return 0;
+}
+
+/* v1.x: qcs404,405 */
+
+const struct tsens_features tsens_v1_feat = {
+	.ver_major	= VER_1_X,
+	.crit_int	= 0,
+	.adc		= 1,
+	.srot_split	= 1,
+	.max_sensors	= 11,
+};
+
+const struct reg_field tsens_v1_regfields[MAX_REGFIELDS] = {
+	/* ----- SROT ------ */
+	/* VERSION */
+	[VER_MAJOR] = REG_FIELD(SROT_HW_VER_OFF, 28, 31),
+	[VER_MINOR] = REG_FIELD(SROT_HW_VER_OFF, 16, 27),
+	[VER_STEP]  = REG_FIELD(SROT_HW_VER_OFF,  0, 15),
+	/* CTRL_OFFSET */
+	[TSENS_EN]     = REG_FIELD(SROT_CTRL_OFF, 0,  0),
+	[TSENS_SW_RST] = REG_FIELD(SROT_CTRL_OFF, 1,  1),
+	[SENSOR_EN]    = REG_FIELD(SROT_CTRL_OFF, 3, 13),
+
+	/* ----- TM ------ */
+	/* INTERRUPT ENABLE */
+	[INT_EN]     = REG_FIELD(TM_INT_EN_OFF, 0, 0),
+
+	/* Sn_STATUS */
+	REG_FIELD_FOR_EACH_SENSOR11(LAST_TEMP,    TM_Sn_STATUS_OFF,  0,  9),
+	REG_FIELD_FOR_EACH_SENSOR11(VALID,        TM_Sn_STATUS_OFF, 14, 14),
+	REG_FIELD_FOR_EACH_SENSOR11(MIN_STATUS,   TM_Sn_STATUS_OFF, 10, 10),
+	REG_FIELD_FOR_EACH_SENSOR11(LOWER_STATUS, TM_Sn_STATUS_OFF, 11, 11),
+	REG_FIELD_FOR_EACH_SENSOR11(UPPER_STATUS, TM_Sn_STATUS_OFF, 12, 12),
+	/* No CRITICAL field on v1.x */
+	REG_FIELD_FOR_EACH_SENSOR11(MAX_STATUS,   TM_Sn_STATUS_OFF, 13, 13),
+
+	/* TRDY: 1=ready, 0=in progress */
+	[TRDY] = REG_FIELD(TM_TRDY_OFF, 0, 0),
+};
+
+static const struct tsens_ops ops_generic_v1 = {
+	.init		= init_common,
+	.calibrate	= calibrate_v1,
+	.get_temp	= get_temp_tsens_valid,
+};
+
+const struct tsens_plat_data data_tsens_v1 = {
+	.ops		= &ops_generic_v1,
+	.feat		= &tsens_v1_feat,
+	.fields	= tsens_v1_regfields,
+};
diff --git a/drivers/thermal/qcom/tsens.c b/drivers/thermal/qcom/tsens.c
index fc44cac31fa5..36b0b52db524 100644
--- a/drivers/thermal/qcom/tsens.c
+++ b/drivers/thermal/qcom/tsens.c
@@ -63,6 +63,9 @@ static const struct of_device_id tsens_table[] = {
 	}, {
 		.compatible = "qcom,msm8996-tsens",
 		.data = &data_8996,
+	}, {
+		.compatible = "qcom,tsens-v1",
+		.data = &data_tsens_v1,
 	}, {
 		.compatible = "qcom,tsens-v2",
 		.data = &data_tsens_v2,
diff --git a/drivers/thermal/qcom/tsens.h b/drivers/thermal/qcom/tsens.h
index f14a87aa1a47..d648fba235cf 100644
--- a/drivers/thermal/qcom/tsens.h
+++ b/drivers/thermal/qcom/tsens.h
@@ -318,6 +318,9 @@ extern const struct tsens_plat_data data_8960;
 /* TSENS v0.1 targets */
 extern const struct tsens_plat_data data_8916, data_8974;
 
+/* TSENS v1 targets */
+extern const struct tsens_plat_data data_tsens_v1;
+
 /* TSENS v2 targets */
 extern const struct tsens_plat_data data_8996, data_tsens_v2;
 
-- 
2.17.1
