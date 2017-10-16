From: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH 05/10] [RFC] ARM: shmobile: pm-rmobile: Use GENPD_FLAG_ACTIVE_WAKEUP
Date: Mon, 16 Oct 2017 15:55:11 +0200
Message-ID: <1508162116-5043-6-git-send-email-geert+renesas@glider.be>
References: <1508162116-5043-1-git-send-email-geert+renesas@glider.be>
Return-path: <linux-clk-owner@vger.kernel.org>
In-Reply-To: <1508162116-5043-1-git-send-email-geert+renesas@glider.be>
Sender: linux-clk-owner@vger.kernel.org
To: Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@codeaurora.org>, Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Kevin Hilman <khilman@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>, =?UTF-8?q?Niklas=20S=C3=B6derlund?= <niklas.soderlund+renesas@ragnatech.se>, linux-clk@vger.kernel.org, linux-renesas-soc@vger.kernel.org, linux-pm@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>
List-Id: linux-pm@vger.kernel.org

Set the newly introduced GENPD_FLAG_ACTIVE_WAKEUP, which allows to
remove the driver's own "always true" callback.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
This must not be applied before "PM / Domain: Enable genpd users to
specify default active wakeup behavior" has landed upstream, hence the
"RFC".
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

