From: Caesar Wang <wxt@rock-chips.com>
Subject: [PATCH v2 5/9] thermal: rockchip: Add the flag for adc value increment or decrement
Date: Thu,  5 Nov 2015 13:18:01 +0800
Message-ID: <1446700685-18017-6-git-send-email-wxt@rock-chips.com>
References: <1446700685-18017-1-git-send-email-wxt@rock-chips.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1446700685-18017-1-git-send-email-wxt@rock-chips.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Heiko Stuebner <heiko@sntech.de>, Eduardo Valentin <edubezval@gmail.com>
Cc: linux-rockchip@lists.infradead.org, Caesar Wang <wxt@rock-chips.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Zhang Rui <rui.zhang@intel.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

The conversion table has the adc value and temperature.
In fact, the adc value only has the increment or decrement mode in
conversion table.

Moment, we can add the flag to be better support the *code_to_temp*
for differenr SoCs.

Signed-off-by: Caesar Wang <wxt@rock-chips.com>
---

Changes in v2: None
Changes in v1: None

 drivers/thermal/rockchip_thermal.c | 64 ++++++++++++++++++++++++++++++--------
 1 file changed, 51 insertions(+), 13 deletions(-)

diff --git a/drivers/thermal/rockchip_thermal.c b/drivers/thermal/rockchip_thermal.c
index e828f18..9df027f 100644
--- a/drivers/thermal/rockchip_thermal.c
+++ b/drivers/thermal/rockchip_thermal.c
@@ -53,6 +53,16 @@ enum sensor_id {
 };
 
 /**
+* The conversion table has the adc value and temperature.
+* ADC_DECREMENT is the adc value decremnet.(e.g. v2_code_table)
+* ADC_INCREMNET is the adc value incremnet.(e.g. v3_code_table)
+*/
+enum adc_flag {
+	ADC_DECREMENT = 0,
+	ADC_INCREMENT,
+};
+
+/**
  * The max sensors is two in rockchip SoCs.
  * Two sensors: CPU and GPU sensor.
  */
@@ -66,6 +76,9 @@ struct chip_tsadc_table {
 
 	/* that analogic mask data */
 	unsigned long data_mask;
+
+	/* adc value is increment or decrement */
+	unsigned int flag;
 };
 
 struct rockchip_tsadc_chip {
@@ -223,19 +236,43 @@ static int rk_tsadcv2_code_to_temp(struct chip_tsadc_table table, u32 code,
 
 	WARN_ON(table.length < 2);
 
-	code &= table.data_mask;
-	if (code < table.id[high].code)
+	switch (table.flag) {
+	case ADC_DECREMENT:
+		code &= table.data_mask;
+		if (code < table.id[high].code)
 		return -EAGAIN;		/* Incorrect reading */
 
-	while (low <= high) {
-		if (code >= table.id[mid].code &&
-		    code < table.id[mid - 1].code)
-			break;
-		else if (code < table.id[mid].code)
-			low = mid + 1;
-		else
-			high = mid - 1;
-		mid = (low + high) / 2;
+		while (low <= high) {
+			if (code >= table.id[mid].code &&
+			    code < table.id[mid - 1].code)
+				break;
+			else if (code < table.id[mid].code)
+				low = mid + 1;
+			else
+				high = mid - 1;
+
+			mid = (low + high) / 2;
+		}
+		break;
+	case ADC_INCREMENT:
+		code &= table.data_mask;
+		if (code < table.id[low].code)
+		return -EAGAIN;		/* Incorrect reading */
+
+		while (low <= high) {
+			if (code >= table.id[mid - 1].code &&
+			    code < table.id[mid].code)
+				break;
+			else if (code > table.id[mid].code)
+				low = mid + 1;
+			else
+				high = mid - 1;
+
+			mid = (low + high) / 2;
+		}
+		break;
+	default:
+		pr_err("Invalid the table conversion\n");
 	}
 
 	/*
@@ -245,8 +282,8 @@ static int rk_tsadcv2_code_to_temp(struct chip_tsadc_table table, u32 code,
 	 * to produce less granular result.
 	 */
 	num = table.id[mid].temp - v2_code_table[mid - 1].temp;
-	num *= table.id[mid - 1].code - code;
-	denom = table.id[mid - 1].code - table.id[mid].code;
+	num *= abs(table.id[mid - 1].code - code);
+	denom = abs(table.id[mid - 1].code - table.id[mid].code);
 	*temp = table.id[mid - 1].temp + (num / denom);
 
 	return 0;
@@ -367,6 +404,7 @@ static const struct rockchip_tsadc_chip rk3288_tsadc_data = {
 		.id = v2_code_table,
 		.length = ARRAY_SIZE(v2_code_table),
 		.data_mask = TSADCV2_DATA_MASK,
+		.flag = ADC_DECREMENT,
 	},
 };
 
-- 
1.9.1
