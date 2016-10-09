From: Shawn Lin <shawn.lin-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
Subject: [PATCH] thermal: rockchip: improve the warning log
Date: Sun,  9 Oct 2016 20:49:18 +0800
Message-ID: <1476017358-26143-1-git-send-email-shawn.lin@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-rockchip-bounces+glpar-linux-rockchip=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-rockchip>,
 <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-rockchip/>
List-Post: <mailto:linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Help: <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-rockchip>,
 <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=subscribe>
Sender: "Linux-rockchip" <linux-rockchip-bounces-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
Errors-To: linux-rockchip-bounces+glpar-linux-rockchip=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: Eduardo Valentin <edubezval-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Zhang Rui <rui.zhang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Shawn Lin <shawn.lin-TNX95d0MmH7DzftRWevZcw@public.gmane.org>, Caesar Wang <wxt-TNX95d0MmH7DzftRWevZcw@public.gmane.org>, Heiko Stuebner <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-pm@vger.kernel.org

There is no necessary to print warning agian and
again if we don't add rockchip,grf for dt, otherwise
I saw the following log when doning suspend-2-resume.
We only need to print it once when parsing dt. It looks
quite trivial but the log is apparently verbose.

[   26.615415] PM: early resume of devices complete after 1.539 msecs
[   26.622002] rk_tsadcv2_initialize: Missing rockchip,grf property
[   26.629359] rk_gmac-dwmac ff290000.ethernet: init for RGMII
[   26.639794] PM: resume of devices complete after 18.109 msecs
[   26.646925] Restarting tasks ... done.

Signed-off-by: Shawn Lin <shawn.lin-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
---

 drivers/thermal/rockchip_thermal.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/thermal/rockchip_thermal.c b/drivers/thermal/rockchip_thermal.c
index e227a9f..b811b0f 100644
--- a/drivers/thermal/rockchip_thermal.c
+++ b/drivers/thermal/rockchip_thermal.c
@@ -524,11 +524,6 @@ static void rk_tsadcv2_initialize(struct regmap *grf, void __iomem *regs,
 		       regs + TSADCV2_AUTO_PERIOD_HT);
 	writel_relaxed(TSADCV2_HIGHT_TSHUT_DEBOUNCE_COUNT,
 		       regs + TSADCV2_HIGHT_TSHUT_DEBOUNCE);
-
-	if (IS_ERR(grf)) {
-		pr_warn("%s: Missing rockchip,grf property\n", __func__);
-		return;
-	}
 }
 
 /**
@@ -971,6 +966,8 @@ static int rockchip_configure_from_dt(struct device *dev,
 	 * need this property.
 	 */
 	thermal->grf = syscon_regmap_lookup_by_phandle(np, "rockchip,grf");
+	if (IS_ERR(thermal->grf))
+		dev_warn(dev, "Missing rockchip,grf property\n");
 
 	return 0;
 }
-- 
2.3.7
