From: Caesar Wang <wxt-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
Subject: [PATCH 2/2] thermal: rockchip: fixes the exception interrupts
Date: Wed, 22 Jun 2016 18:13:57 +0800
Message-ID: <1466590437-15912-2-git-send-email-wxt@rock-chips.com>
References: <1466584925-4829-1-git-send-email-wxt@rock-chips.com>
 <1466590437-15912-1-git-send-email-wxt@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-rockchip-bounces+glpar-linux-rockchip=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
In-Reply-To: <1466590437-15912-1-git-send-email-wxt-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-rockchip>,
 <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-rockchip/>
List-Post: <mailto:linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Help: <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-rockchip>,
 <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=subscribe>
Sender: "Linux-rockchip" <linux-rockchip-bounces-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
Errors-To: linux-rockchip-bounces+glpar-linux-rockchip=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: edubezval-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: huangtao-TNX95d0MmH7DzftRWevZcw@public.gmane.org, heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org, linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, smbarber-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org, cf-TNX95d0MmH7DzftRWevZcw@public.gmane.org, rui.zhang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, rocky.hao-TNX95d0MmH7DzftRWevZcw@public.gmane.org, Caesar Wang <wxt-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

The hardware-tracked trips will set the alarm interrupt value for
registers. Then when the thermal zone has no trips to be set,
That make the thermal trips callback a over range value.

The root cause is the rk_tsadcv2_temp_to_code() function to handle the
invalid temperature range is indeed incorrect, let's fix it on now.
Otherwise, the thermal alarm interrupt will be triggered all the time
on some SoCs.

Fox example:
localhost tmp # grep thermal /proc/interrupts; sleep 5;
grep thermal /proc/interrupts

23:     994830  ..    GICv3 129 Level     rockchip_thermal
23:    1003423  ..    GICv3 129 Level     rockchip_thermal

Reported-by: Rocky Hao <rocky.hao-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
Signed-off-by: Caesar Wang <wxt-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
Cc: Zhang Rui <rui.zhang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: Eduardo Valentin <edubezval-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Heiko Stuebner <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>
Cc: linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
---

Changes in v1: None

 drivers/thermal/rockchip_thermal.c | 20 +++++++++++++++++---
 1 file changed, 17 insertions(+), 3 deletions(-)

diff --git a/drivers/thermal/rockchip_thermal.c b/drivers/thermal/rockchip_thermal.c
index 2d5ba97..db5ecc5 100644
--- a/drivers/thermal/rockchip_thermal.c
+++ b/drivers/thermal/rockchip_thermal.c
@@ -401,13 +401,17 @@ static u32 rk_tsadcv2_temp_to_code(struct chip_tsadc_table table,
 				   int temp)
 {
 	int high, low, mid;
+	u32 error = 0;
 
 	low = 0;
 	high = table.length - 1;
 	mid = (high + low) / 2;
 
-	if (temp < table.id[low].temp || temp > table.id[high].temp)
-		return 0;
+	/* Return mask code data when the temp is over table range */
+	if (temp < table.id[low].temp || temp > table.id[high].temp) {
+		error = table.data_mask;
+		goto exit;
+	}
 
 	while (low <= high) {
 		if (temp == table.id[mid].temp)
@@ -419,7 +423,9 @@ static u32 rk_tsadcv2_temp_to_code(struct chip_tsadc_table table,
 		mid = (low + high) / 2;
 	}
 
-	return 0;
+exit:
+	pr_err("Invalid the conversion, error=%d\n", error);
+	return error;
 }
 
 static int rk_tsadcv2_code_to_temp(struct chip_tsadc_table table, u32 code,
@@ -651,7 +657,11 @@ static void rk_tsadcv2_alarm_temp(struct chip_tsadc_table table,
 {
 	u32 alarm_value, int_en;
 
+	/* Make sure the value is valid */
 	alarm_value = rk_tsadcv2_temp_to_code(table, temp);
+	if (alarm_value == table.data_mask)
+		return;
+
 	writel_relaxed(alarm_value & table.data_mask,
 		       regs + TSADCV2_COMP_INT(chn));
 
@@ -665,7 +675,11 @@ static void rk_tsadcv2_tshut_temp(struct chip_tsadc_table table,
 {
 	u32 tshut_value, val;
 
+	/* Make sure the value is valid */
 	tshut_value = rk_tsadcv2_temp_to_code(table, temp);
+	if (tshut_value == table.data_mask)
+		return;
+
 	writel_relaxed(tshut_value, regs + TSADCV2_COMP_SHUT(chn));
 
 	/* TSHUT will be valid */
-- 
1.9.1
