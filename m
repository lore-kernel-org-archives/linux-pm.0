From: Caesar Wang <wxt-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
Subject: [PATCH 1/2] thermal: rockchip: fixes the period time for tsadc
Date: Wed, 22 Jun 2016 18:13:56 +0800
Message-ID: <1466590437-15912-1-git-send-email-wxt@rock-chips.com>
References: <1466584925-4829-1-git-send-email-wxt@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-rockchip-bounces+glpar-linux-rockchip=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
In-Reply-To: <1466584925-4829-1-git-send-email-wxt-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
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

We should increase the period cycles to save power since the rk3399 has
the high frequency for tsadc clock.

Fixes commit b0d70338bca22cb14
("thermal: rockchip: Support the RK3399 SoCs in thermal driver")

Signed-off-by: Caesar Wang <wxt-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
Cc: Zhang Rui <rui.zhang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: Eduardo Valentin <edubezval-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Heiko Stuebner <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>
Cc: linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

---

Note:
- depend on the " [v6,5/5] thermal: rockchip: add the set_trips function"
  at https://patchwork.kernel.org/patch/9192179/, otherwise will cause the merge
  conflict.

 drivers/thermal/rockchip_thermal.c | 34 ++++++++++++++++++++++++----------
 1 file changed, 24 insertions(+), 10 deletions(-)

diff --git a/drivers/thermal/rockchip_thermal.c b/drivers/thermal/rockchip_thermal.c
index 8175cdb..2d5ba97 100644
--- a/drivers/thermal/rockchip_thermal.c
+++ b/drivers/thermal/rockchip_thermal.c
@@ -211,8 +211,11 @@ struct rockchip_thermal_data {
 
 #define TSADCV2_HIGHT_INT_DEBOUNCE_COUNT	4
 #define TSADCV2_HIGHT_TSHUT_DEBOUNCE_COUNT	4
-#define TSADCV2_AUTO_PERIOD_TIME		250 /* msec */
-#define TSADCV2_AUTO_PERIOD_HT_TIME		50  /* msec */
+#define TSADCV2_AUTO_PERIOD_TIME		250 /* 250ms */
+#define TSADCV2_AUTO_PERIOD_HT_TIME		50  /* 50ms */
+#define TSADCV3_AUTO_PERIOD_TIME		187500 /* 250ms */
+#define TSADCV3_AUTO_PERIOD_HT_TIME		37500  /* 50ms */
+
 #define TSADCV2_USER_INTER_PD_SOC		0x340 /* 13 clocks */
 
 #define GRF_SARADC_TESTBIT			0x0e644
@@ -547,6 +550,16 @@ static void rk_tsadcv3_initialize(struct regmap *grf, void __iomem *regs,
 		/* Set interleave value to workround ic time sync issue */
 		writel_relaxed(TSADCV2_USER_INTER_PD_SOC, regs +
 			       TSADCV2_USER_CON);
+
+		writel_relaxed(TSADCV2_AUTO_PERIOD_TIME,
+			       regs + TSADCV2_AUTO_PERIOD);
+		writel_relaxed(TSADCV2_HIGHT_INT_DEBOUNCE_COUNT,
+			       regs + TSADCV2_HIGHT_INT_DEBOUNCE);
+		writel_relaxed(TSADCV2_AUTO_PERIOD_HT_TIME,
+			       regs + TSADCV2_AUTO_PERIOD_HT);
+		writel_relaxed(TSADCV2_HIGHT_TSHUT_DEBOUNCE_COUNT,
+			       regs + TSADCV2_HIGHT_TSHUT_DEBOUNCE);
+
 	} else {
 		regmap_write(grf, GRF_TSADC_TESTBIT_L, GRF_TSADC_TSEN_PD_ON);
 		mdelay(10);
@@ -555,6 +568,15 @@ static void rk_tsadcv3_initialize(struct regmap *grf, void __iomem *regs,
 		regmap_write(grf, GRF_SARADC_TESTBIT, GRF_SARADC_TESTBIT_ON);
 		regmap_write(grf, GRF_TSADC_TESTBIT_H, GRF_TSADC_TESTBIT_H_ON);
 		usleep_range(90, 200); /* The spec note says at least 90 us */
+
+		writel_relaxed(TSADCV3_AUTO_PERIOD_TIME,
+			       regs + TSADCV2_AUTO_PERIOD);
+		writel_relaxed(TSADCV2_HIGHT_INT_DEBOUNCE_COUNT,
+			       regs + TSADCV2_HIGHT_INT_DEBOUNCE);
+		writel_relaxed(TSADCV3_AUTO_PERIOD_HT_TIME,
+			       regs + TSADCV2_AUTO_PERIOD_HT);
+		writel_relaxed(TSADCV2_HIGHT_TSHUT_DEBOUNCE_COUNT,
+			       regs + TSADCV2_HIGHT_TSHUT_DEBOUNCE);
 	}
 
 	if (tshut_polarity == TSHUT_HIGH_ACTIVE)
@@ -563,14 +585,6 @@ static void rk_tsadcv3_initialize(struct regmap *grf, void __iomem *regs,
 	else
 		writel_relaxed(0U & ~TSADCV2_AUTO_TSHUT_POLARITY_HIGH,
 			       regs + TSADCV2_AUTO_CON);
-
-	writel_relaxed(TSADCV2_AUTO_PERIOD_TIME, regs + TSADCV2_AUTO_PERIOD);
-	writel_relaxed(TSADCV2_HIGHT_INT_DEBOUNCE_COUNT,
-		       regs + TSADCV2_HIGHT_INT_DEBOUNCE);
-	writel_relaxed(TSADCV2_AUTO_PERIOD_HT_TIME,
-		       regs + TSADCV2_AUTO_PERIOD_HT);
-	writel_relaxed(TSADCV2_HIGHT_TSHUT_DEBOUNCE_COUNT,
-		       regs + TSADCV2_HIGHT_TSHUT_DEBOUNCE);
 }
 
 static void rk_tsadcv2_irq_ack(void __iomem *regs)
-- 
1.9.1
