From: Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>
Subject: [PATCH v3 16/16] ARM: shmobile: R-Mobile: Use CPG/MSTP Clock Domain attach/detach helpers
Date: Wed,  1 Jul 2015 17:58:10 +0200
Message-ID: <1435766290-3005-17-git-send-email-geert+renesas@glider.be>
References: <1435766290-3005-1-git-send-email-geert+renesas@glider.be>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1435766290-3005-1-git-send-email-geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Simon Horman <horms-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org>, Magnus Damm <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Michael Turquette <mturquette-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Stephen Boyd <sboyd-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Laurent Pinchart <Laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, Kevin Hilman <khilman-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: linux-clk-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

The R-Mobile PM Domain driver manages both power domains and a clock
domain.

The clock domain part is very similar to the CPG/MSTP Clock Domain,
which is used on shmobile SoCs without device power domains, except for
the way how clocks suitable for power management are selected:
  - The former uses the first clock tied to the device through the NULL
    con_id, which is a relic from the legacy pm_clk_notifier-based
    method in drivers/sh/pm_runtime.c,
  - The latter looks for suitable clocks in DT, which is more
    future-proof.

All platforms using this driver are now supported in DT-based ARM
multi-platform builds only, hence switch to using the CPG/MSTP Clock
Domain helpers.

Signed-off-by: Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>
---
v3:
  - Drop -legacy support, hence this patch depends on r8a7740/sh73a0
    legacy removal,
  - Use "CPG/MSTP Clock Domain" instead of "CPG Clock Domain",

v2:
  - New.
---
 arch/arm/mach-shmobile/pm-rmobile.c | 35 +++--------------------------------
 1 file changed, 3 insertions(+), 32 deletions(-)

diff --git a/arch/arm/mach-shmobile/pm-rmobile.c b/arch/arm/mach-shmobile/pm-rmobile.c
index a5b96b990aea8dfc..89068c8ec50f2c76 100644
--- a/arch/arm/mach-shmobile/pm-rmobile.c
+++ b/arch/arm/mach-shmobile/pm-rmobile.c
@@ -12,6 +12,7 @@
  * License.  See the file "COPYING" in the main directory of this archive
  * for more details.
  */
+#include <linux/clk/shmobile.h>
 #include <linux/console.h>
 #include <linux/delay.h>
 #include <linux/of.h>
@@ -124,36 +125,6 @@ static bool rmobile_pd_active_wakeup(struct device *dev)
 	return true;
 }
 
-static int rmobile_pd_attach_dev(struct generic_pm_domain *domain,
-				 struct device *dev)
-{
-	int error;
-
-	error = pm_clk_create(dev);
-	if (error) {
-		dev_err(dev, "pm_clk_create failed %d\n", error);
-		return error;
-	}
-
-	error = pm_clk_add(dev, NULL);
-	if (error) {
-		dev_err(dev, "pm_clk_add failed %d\n", error);
-		goto fail;
-	}
-
-	return 0;
-
-fail:
-	pm_clk_destroy(dev);
-	return error;
-}
-
-static void rmobile_pd_detach_dev(struct generic_pm_domain *domain,
-				  struct device *dev)
-{
-	pm_clk_destroy(dev);
-}
-
 static void rmobile_init_pm_domain(struct rmobile_pm_domain *rmobile_pd)
 {
 	struct generic_pm_domain *genpd = &rmobile_pd->genpd;
@@ -164,8 +135,8 @@ static void rmobile_init_pm_domain(struct rmobile_pm_domain *rmobile_pd)
 	genpd->dev_ops.active_wakeup	= rmobile_pd_active_wakeup;
 	genpd->power_off		= rmobile_pd_power_down;
 	genpd->power_on			= rmobile_pd_power_up;
-	genpd->attach_dev		= rmobile_pd_attach_dev;
-	genpd->detach_dev		= rmobile_pd_detach_dev;
+	genpd->attach_dev		= cpg_mstp_attach_dev;
+	genpd->detach_dev		= cpg_mstp_detach_dev;
 	__rmobile_pd_power_up(rmobile_pd, false);
 }
 
-- 
1.9.1

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
