From: Caesar Wang <wxt-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
Subject: [PATCH v3 5/5] thermal: rockchip: handle set_trips without the trip
 points
Date: Mon, 28 Nov 2016 19:12:04 +0800
Message-ID: <1480331524-18741-6-git-send-email-wxt@rock-chips.com>
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

In some cases, some sensors didn't need the trip points, the
set_trips will pass {-INT_MAX, INT_MAX} to trigger tsadc alarm in the end,
ignore this case and disable the high temperature interrupt.

Signed-off-by: Caesar Wang <wxt-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
Reviewed-by: Brian Norris <briannorris-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
---

Changes in v3:
- change the commit.
- Fixes something as Brian comments on

Changes in v2:
- Fixes something as Brian comments on
  https://patchwork.kernel.org/patch/9440989.

Changes in v1: None

 drivers/thermal/rockchip_thermal.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/drivers/thermal/rockchip_thermal.c b/drivers/thermal/rockchip_thermal.c
index 660ed3b..56c663c 100644
--- a/drivers/thermal/rockchip_thermal.c
+++ b/drivers/thermal/rockchip_thermal.c
@@ -675,7 +675,21 @@ static int rk_tsadcv2_get_temp(const struct chip_tsadc_table *table,
 static int rk_tsadcv2_alarm_temp(const struct chip_tsadc_table *table,
 				 int chn, void __iomem *regs, int temp)
 {
-	u32 alarm_value, int_en;
+	u32 alarm_value;
+	u32 int_en, int_clr;
+
+	/*
+	 * In some cases, some sensors didn't need the trip points, the
+	 * set_trips will pass {-INT_MAX, INT_MAX} to trigger tsadc alarm
+	 * in the end, ignore this case and disable the high temperature
+	 * interrupt.
+	 */
+	if (temp == INT_MAX) {
+		int_clr = readl_relaxed(regs + TSADCV2_INT_EN);
+		int_clr &= ~TSADCV2_INT_SRC_EN(chn);
+		writel_relaxed(int_clr, regs + TSADCV2_INT_EN);
+		return 0;
+	}
 
 	/* Make sure the value is valid */
 	alarm_value = rk_tsadcv2_temp_to_code(table, temp);
-- 
2.7.4
