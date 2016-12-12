From: Caesar Wang <wxt@rock-chips.com>
Subject: [PATCH v4 4/5] thermal: rockchip: optimize the conversion table
Date: Mon, 12 Dec 2016 19:05:34 +0800
Message-ID: <1481540735-12710-5-git-send-email-wxt@rock-chips.com>
References: <1481540735-12710-1-git-send-email-wxt@rock-chips.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1481540735-12710-1-git-send-email-wxt@rock-chips.com>
Sender: linux-kernel-owner@vger.kernel.org
To: edubezval@gmail.com, rui.zhang@intel.com
Cc: linux-rockchip@lists.infradead.org, linux-pm@vger.kernel.org, briannorris@chromium.org, linux-kernel@vger.kernel.org, smbarber@chromium.org, Caesar Wang <wxt@rock-chips.com>
List-Id: linux-pm@vger.kernel.org

In order to support the valid temperature can conver to analog value.
The rockchip thermal driver has not supported the all valid temperature
to convert the analog value. (e.g.: 61C, 62C, 63C....)

For example:
In some cases, we need adjust the trip point.
$cd /sys/class/thermal/thermal_zone*
$echo 68000 > trip_point_0_temp
That will return the max analogic value indicates the invalid before
posting this patch.

So, this patch will optimize the conversion table to support the other
cases.

Signed-off-by: Caesar Wang <wxt@rock-chips.com>
---

Changes in v4:
- Print a better name.
- As Eduardo commented on https://patchwork.kernel.org/patch/9449313/
- remove the Brain's review for previous version, since the new version
  update something.

Changes in v3: None
Changes in v2:
- improve the commit as Brian commnets on https://patchwork.kernel.org/patch/9440985

Changes in v1: None

 drivers/thermal/rockchip_thermal.c | 25 ++++++++++++++++++++++++-
 1 file changed, 24 insertions(+), 1 deletion(-)

diff --git a/drivers/thermal/rockchip_thermal.c b/drivers/thermal/rockchip_thermal.c
index f027b86..cacc12b 100644
--- a/drivers/thermal/rockchip_thermal.c
+++ b/drivers/thermal/rockchip_thermal.c
@@ -317,6 +317,7 @@ static const struct tsadc_table rk3288_code_table[] = {
 	{3452, 115000},
 	{3437, 120000},
 	{3421, 125000},
+	{0, 125000},
 };
 
 static const struct tsadc_table rk3368_code_table[] = {
@@ -401,10 +402,12 @@ static u32 rk_tsadcv2_temp_to_code(const struct chip_tsadc_table *table,
 				   int temp)
 {
 	int high, low, mid;
+	unsigned long num;
+	unsigned int denom;
 	u32 error = table->data_mask;
 
 	low = 0;
-	high = table->length - 1;
+	high = (table->length - 1) - 1; /* ignore the last check for table */
 	mid = (high + low) / 2;
 
 	/* Return mask code data when the temp is over table range */
@@ -421,6 +424,26 @@ static u32 rk_tsadcv2_temp_to_code(const struct chip_tsadc_table *table,
 		mid = (low + high) / 2;
 	}
 
+	/*
+	 * The conversion code granularity provided by the table. Let's
+	 * assume that the relationship between temperature and
+	 * analog value between 2 table entries is linear and interpolate
+	 * to produce less granular result.
+	 */
+	num = abs(table->id[mid + 1].code - table->id[mid].code);
+	num *= temp - table->id[mid].temp;
+	denom = table->id[mid + 1].temp - table->id[mid].temp;
+
+	switch (table->mode) {
+	case ADC_DECREMENT:
+		return table->id[mid].code - (num / denom);
+	case ADC_INCREMENT:
+		return table->id[mid].code + (num / denom);
+	default:
+		pr_err("%s: unknown table mode: %d\n", __func__, table->mode);
+		return error;
+	}
+
 exit:
 	pr_err("%s: invalid temperature, temp=%d error=%d\n",
 	       __func__, temp, error);
-- 
2.7.4
