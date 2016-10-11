From: Shawn Lin <shawn.lin@rock-chips.com>
Subject: [PATCH v2 1/2] thermal: rockchip: improve the warning log
Date: Tue, 11 Oct 2016 10:07:34 +0800
Message-ID: <1476151655-18415-1-git-send-email-shawn.lin@rock-chips.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from lucky1.263xmail.com ([211.157.147.134]:51489 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752920AbcJKCCO (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 10 Oct 2016 22:02:14 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>
Cc: Heiko Stuebner <heiko@sntech.de>, linux-pm@vger.kernel.org, linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, Caesar Wang <wxt@rock-chips.com>, Shawn Lin <shawn.lin@rock-chips.com>

It is no necessary to print warning agian and again if we don't
add rockchip,grf for dt, otherwise I saw the following log when
doing suspend-2-resume. We only need to print it once when parsing
dt. It looks quite trivial but the log is apparently verbose.

[   26.615415] PM: early resume of devices complete after 1.539 msecs
[   26.622002] rk_tsadcv2_initialize: Missing rockchip,grf property
[   26.629359] rk_gmac-dwmac ff290000.ethernet: init for RGMII
[   26.639794] PM: resume of devices complete after 18.109 msecs
[   26.646925] Restarting tasks ... done.

Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>

Reviewed-by: Caesar Wang <wxt@rock-chips.com>
---

Changes in v2:
- fix typos(Heiko)

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


