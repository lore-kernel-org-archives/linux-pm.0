From: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH v2 3/5] [RFC] soc: mediatek: Use GENPD_FLAG_ACTIVE_WAKEUP
Date: Tue, 31 Oct 2017 19:11:32 +0100
Message-ID: <1509473494-19740-4-git-send-email-geert+renesas@glider.be>
References: <1509473494-19740-1-git-send-email-geert+renesas@glider.be>
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <1509473494-19740-1-git-send-email-geert+renesas@glider.be>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: "Rafael J . Wysocki" <rjw@rjwysocki.net>, Ulf Hansson <ulf.hansson@linaro.org>, Kevin Hilman <khilman@kernel.org>
Cc: Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, Matthias Brugger <matthias.bgg@gmail.com>, Heiko Stuebner <heiko@sntech.de>, linux-pm@vger.kernel.org, linux-mediatek@lists.infradead.org, linux-rockchip@lists.infradead.org, linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>
List-Id: linux-pm@vger.kernel.org

Set the newly introduced GENPD_FLAG_ACTIVE_WAKEUP, which allows to
remove the driver's own flag-based callback.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
This must not be applied before "PM / Domain: Enable genpd users to
specify default active wakeup behavior" has landed upstream, hence the
"RFC".

Compile-tested only.

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
