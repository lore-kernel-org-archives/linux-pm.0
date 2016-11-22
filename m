From: Caesar Wang <wxt@rock-chips.com>
Subject: [PATCH 4/5] thermal: rockchip: optimize the conversion table
Date: Tue, 22 Nov 2016 20:34:47 +0800
Message-ID: <1479818088-6007-5-git-send-email-wxt@rock-chips.com>
References: <1479818088-6007-1-git-send-email-wxt@rock-chips.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1479818088-6007-1-git-send-email-wxt@rock-chips.com>
Sender: linux-kernel-owner@vger.kernel.org
To: edubezval@gmail.com, rui.zhang@intel.com
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, linux-rockchip@lists.infradead.org, briannorris@chromium.org, heiko@sntech.de, smbarber@chromium.org, Caesar Wang <wxt@rock-chips.com>
List-Id: linux-pm@vger.kernel.org

In order to support the valid temperature can conver to analog value.
The rockchip thermal has not supported the all valid temperature.

For example:
In some cases, we need adjust the trip point.
$cd /sys/class/thermal/thermal_zone*
echo 68000 > trip_point_0_temp
That will report the error message before posting this patch.

Signed-off-by: Caesar Wang <wxt@rock-chips.com>
---

 drivers/thermal/rockchip_thermal.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/drivers/thermal/rockchip_thermal.c b/drivers/thermal/rockchip_thermal.c
index 535f1fa..f4d4be9 100644
--- a/drivers/thermal/rockchip_thermal.c
+++ b/drivers/thermal/rockchip_thermal.c
@@ -401,6 +401,8 @@ static u32 rk_tsadcv2_temp_to_code(const struct chip_tsadc_table *table,
 				   int temp)
 {
 	int high, low, mid;
+	unsigned long num;
+	unsigned int denom;
 	u32 error = table->data_mask;
 
 	low = 0;
@@ -421,6 +423,27 @@ static u32 rk_tsadcv2_temp_to_code(const struct chip_tsadc_table *table,
 		mid = (low + high) / 2;
 	}
 
+	/*
+	 * The conversion code granularity provided by the table. Let's
+	 * assume that the relationship between temperature and
+	 * analog value between 2 table entries is linear and interpolate
+	 * to produce less granular result.
+	 */
+	num = abs(table->id[mid].code - table->id[mid + 1].code);
+	num *= temp - table->id[mid].temp;
+	denom = table->id[mid + 1].temp - table->id[mid].temp;
+
+	switch (table->mode) {
+	case ADC_DECREMENT:
+		return table->id[mid].code - (num / denom);
+	case ADC_INCREMENT:
+		return table->id[mid].code + (num / denom);
+	default:
+		pr_err("%s: invalid conversion table, mode=%d\n",
+		       __func__, table->mode);
+		return error;
+	}
+
 exit:
 	pr_err("%s: invalid temperature, temp=%d error=%d\n",
 	       __func__, temp, error);
-- 
2.7.4
