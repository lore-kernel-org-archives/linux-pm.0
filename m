From: Caesar Wang <wxt-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
Subject: [PATCH v3 05/10] thermal: rockchip: Add the sort flag for adc value
 increment or decrement
Date: Sun,  8 Nov 2015 17:26:03 +0800
Message-ID: <1446974768-25795-6-git-send-email-wxt@rock-chips.com>
References: <1446974768-25795-1-git-send-email-wxt@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-rockchip-bounces+glpar-linux-rockchip=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
In-Reply-To: <1446974768-25795-1-git-send-email-wxt-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-rockchip>,
 <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-rockchip/>
List-Post: <mailto:linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Help: <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-rockchip>,
 <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=subscribe>
Sender: "Linux-rockchip" <linux-rockchip-bounces-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
Errors-To: linux-rockchip-bounces+glpar-linux-rockchip=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: Heiko Stuebner <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>, Eduardo Valentin <edubezval-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Zhang Rui <rui.zhang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Caesar Wang <wxt-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

The conversion table has the adc value and temperature.
In fact, the adc value only has the increment or decrement mode in
conversion table.

Moment, we can add the sort flag to be better support the *code_to_temp*
for differenr SoCs.

Signed-off-by: Caesar Wang <wxt-TNX95d0MmH7DzftRWevZcw@public.gmane.org>

---

Changes in v3:
- rename the flag-> sort_flag.
- fix the indentation.
- change the pr_err information.

Changes in v2: None
Changes in v1: None

 drivers/thermal/rockchip_thermal.c | 68 +++++++++++++++++++++++++++++---------
 1 file changed, 53 insertions(+), 15 deletions(-)

diff --git a/drivers/thermal/rockchip_thermal.c b/drivers/thermal/rockchip_thermal.c
index 3116d07..c1ab346 100644
--- a/drivers/thermal/rockchip_thermal.c
+++ b/drivers/thermal/rockchip_thermal.c
@@ -53,6 +53,16 @@ enum sensor_id {
 };
 
 /**
+* The conversion table has the adc value and temperature.
+* ADC_DECREMENT is the adc value decremnet.(e.g. v2_code_table)
+* ADC_INCREMNET is the adc value incremnet.(e.g. v3_code_table)
+*/
+enum sort_flag {
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
 	u32 data_mask;
+
+	/* the flag is adc value that increment or decrement in table */
+	bool sort_flag;
 };
 
 struct rockchip_tsadc_chip {
@@ -223,19 +236,43 @@ static int rk_tsadcv2_code_to_temp(struct chip_tsadc_table table, u32 code,
 
 	WARN_ON(table.length < 2);
 
-	code &= table.data_mask;
-	if (code < table.id[high].code)
-		return -EAGAIN;		/* Incorrect reading */
-
-	while (low <= high) {
-		if (code >= table.id[mid].code &&
-		    code < table.id[mid - 1].code)
-			break;
-		else if (code < table.id[mid].code)
-			low = mid + 1;
-		else
-			high = mid - 1;
-		mid = (low + high) / 2;
+	switch (table.sort_flag) {
+	case ADC_DECREMENT:
+		code &= table.data_mask;
+		if (code < table.id[high].code)
+			return -EAGAIN;		/* Incorrect reading */
+
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
+			return -EAGAIN;		/* Incorrect reading */
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
+		pr_err("Invalid the conversion table\n");
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
+		.sort_flag = ADC_DECREMENT,
 	},
 };
 
-- 
1.9.1
