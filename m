From: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH v3 2/5] ARM: shmobile: pm-rmobile: Use GENPD_FLAG_ACTIVE_WAKEUP
Date: Tue,  7 Nov 2017 13:48:12 +0100
Message-ID: <1510058895-21712-3-git-send-email-geert+renesas@glider.be>
References: <1510058895-21712-1-git-send-email-geert+renesas@glider.be>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1510058895-21712-1-git-send-email-geert+renesas@glider.be>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J . Wysocki" <rjw@rjwysocki.net>, Kevin Hilman <khilman@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, Matthias Brugger <matthias.bgg@gmail.com>, Heiko Stuebner <heiko@sntech.de>, linux-pm@vger.kernel.org, linux-renesas-soc@vger.kernel.org, linux-mediatek@lists.infradead.org, linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>
List-Id: linux-pm@vger.kernel.org

Set the newly introduced GENPD_FLAG_ACTIVE_WAKEUP, which allows to
remove the driver's own "always true" callback.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Acked-by: Ulf Hansson <ulf.hansson@linaro.org>
Acked-by: Simon Horman <horms+renesas@verge.net.au>
---
v3:
  - Add Acked-by,
  - Drop RFC status,

v2:
  - No changes.
---
 arch/arm/mach-shmobile/pm-rmobile.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/arch/arm/mach-shmobile/pm-rmobile.c b/arch/arm/mach-shmobile/pm-rmobile.c
index 3a4ed4c33a68e51e..e348bcfe389da51b 100644
--- a/arch/arm/mach-shmobile/pm-rmobile.c
+++ b/arch/arm/mach-shmobile/pm-rmobile.c
@@ -120,18 +120,12 @@ static int rmobile_pd_power_up(struct generic_pm_domain *genpd)
 	return __rmobile_pd_power_up(to_rmobile_pd(genpd), true);
 }
 
-static bool rmobile_pd_active_wakeup(struct device *dev)
-{
-	return true;
-}
-
 static void rmobile_init_pm_domain(struct rmobile_pm_domain *rmobile_pd)
 {
 	struct generic_pm_domain *genpd = &rmobile_pd->genpd;
 	struct dev_power_governor *gov = rmobile_pd->gov;
 
-	genpd->flags |= GENPD_FLAG_PM_CLK;
-	genpd->dev_ops.active_wakeup	= rmobile_pd_active_wakeup;
+	genpd->flags |= GENPD_FLAG_PM_CLK | GENPD_FLAG_ACTIVE_WAKEUP;
 	genpd->power_off		= rmobile_pd_power_down;
 	genpd->power_on			= rmobile_pd_power_up;
 	genpd->attach_dev		= cpg_mstp_attach_dev;
-- 
2.7.4
