From: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH v3 3/5] soc: mediatek: Use GENPD_FLAG_ACTIVE_WAKEUP
Date: Tue,  7 Nov 2017 13:48:13 +0100
Message-ID: <1510058895-21712-4-git-send-email-geert+renesas@glider.be>
References: <1510058895-21712-1-git-send-email-geert+renesas@glider.be>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from michel.telenet-ops.be ([195.130.137.88]:54474 "EHLO
        michel.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753102AbdKGMsX (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 7 Nov 2017 07:48:23 -0500
In-Reply-To: <1510058895-21712-1-git-send-email-geert+renesas@glider.be>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J . Wysocki" <rjw@rjwysocki.net>, Kevin Hilman <khilman@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, Matthias Brugger <matthias.bgg@gmail.com>, Heiko Stuebner <heiko@sntech.de>, linux-pm@vger.kernel.org, linux-renesas-soc@vger.kernel.org, linux-mediatek@lists.infradead.org, linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>

Set the newly introduced GENPD_FLAG_ACTIVE_WAKEUP, which allows to
remove the driver's own flag-based callback.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Acked-by: Ulf Hansson <ulf.hansson@linaro.org>
Acked-by: Matthias Brugger <matthias.bgg@gmail.com>
---
Compile-tested only.

v3:
  - Add Acked-by,
  - Drop RFC status,

v2:
  - New.
---
 drivers/soc/mediatek/mtk-scpsys.c | 14 ++------------
 1 file changed, 2 insertions(+), 12 deletions(-)

diff --git a/drivers/soc/mediatek/mtk-scpsys.c b/drivers/soc/mediatek/mtk-scpsys.c
index e1ce8b1b5090aa0a..e570b6af2e6ffbdd 100644
--- a/drivers/soc/mediatek/mtk-scpsys.c
+++ b/drivers/soc/mediatek/mtk-scpsys.c
@@ -361,17 +361,6 @@ static int scpsys_power_off(struct generic_pm_domain *genpd)
 	return ret;
 }
 
-static bool scpsys_active_wakeup(struct device *dev)
-{
-	struct generic_pm_domain *genpd;
-	struct scp_domain *scpd;
-
-	genpd = pd_to_genpd(dev->pm_domain);
-	scpd = container_of(genpd, struct scp_domain, genpd);
-
-	return scpd->data->active_wakeup;
-}
-
 static void init_clks(struct platform_device *pdev, struct clk **clk)
 {
 	int i;
@@ -466,7 +455,8 @@ static struct scp *init_scp(struct platform_device *pdev,
 		genpd->name = data->name;
 		genpd->power_off = scpsys_power_off;
 		genpd->power_on = scpsys_power_on;
-		genpd->dev_ops.active_wakeup = scpsys_active_wakeup;
+		if (scpd->data->active_wakeup)
+			genpd->flags |= GENPD_FLAG_ACTIVE_WAKEUP;
 	}
 
 	return scp;
-- 
2.7.4
