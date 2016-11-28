From: Caesar Wang <wxt-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
Subject: [PATCH v3 4/5] thermal: rockchip: optimize the conversion table
Date: Mon, 28 Nov 2016 19:12:03 +0800
Message-ID: <1480331524-18741-5-git-send-email-wxt@rock-chips.com>
References: <1480331524-18741-1-git-send-email-wxt@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-rockchip-bounces+glpar-linux-rockchip=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
In-Reply-To: <1480331524-18741-1-git-send-email-wxt-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-rockchip>,
 <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-rockchip/>
List-Post: <mailto:linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Help: <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-rockchip>,
 <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=subscribe>
Sender: "Linux-rockchip" <linux-rockchip-bounces-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
Errors-To: linux-rockchip-bounces+glpar-linux-rockchip=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: rui.zhang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, edubezval-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Cc: heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, briannorris-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, smbarber-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org, linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Caesar Wang <wxt-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
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

Signed-off-by: Caesar Wang <wxt-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
Reviewed-by: Brian Norris <briannorris-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
---

Changes in v3: None
Changes in v2:
- improve the commit as Brian commnets on https://patchwork.kernel.org/patch/9440985

Changes in v1: None

 drivers/thermal/rockchip_thermal.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/drivers/thermal/rockchip_thermal.c b/drivers/thermal/rockchip_thermal.c
index ca1730e..660ed3b 100644
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
