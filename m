From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH V4 3/3] ARM: shmobile: Convert to genpd flags for PM clocks for R-mobile
Date: Mon,  1 Dec 2014 12:50:23 +0100
Message-ID: <1417434623-31301-4-git-send-email-ulf.hansson@linaro.org>
References: <1417434623-31301-1-git-send-email-ulf.hansson@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-lb0-f175.google.com ([209.85.217.175]:45873 "EHLO
	mail-lb0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753567AbaLALuh (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 1 Dec 2014 06:50:37 -0500
Received: by mail-lb0-f175.google.com with SMTP id u10so8561226lbd.34
        for <linux-pm@vger.kernel.org>; Mon, 01 Dec 2014 03:50:36 -0800 (PST)
In-Reply-To: <1417434623-31301-1-git-send-email-ulf.hansson@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Kevin Hilman <khilman@linaro.org>, Simon Horman <horms@verge.net.au>, linux-pm@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>, Magnus Damm <magnus.damm@gmail.com>, Russell King <linux@arm.linux.org.uk>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Sylwester Nawrocki <s.nawrocki@samsung.com>, Grygorii Strashko <grygorii.strashko@ti.com>, Arnd Bergmann <arnd@arndb.de>, Ulf Hansson <ulf.hansson@linaro.org>

Instead of using the dev_ops ->stop|start() callbacks for genpd, let's
convert to use genpd's flag field and set it to GENPD_FLAG_PM_CLK.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>
Tested-by: Geert Uytterhoeven <geert+renesas@glider.be>
---

Changes in v4:
        Convert to renamed define.

Changes in v3:
        Convert to renamed define.

Changes in v2:
        None.
---
 arch/arm/mach-shmobile/pm-rmobile.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/arm/mach-shmobile/pm-rmobile.c b/arch/arm/mach-shmobile/pm-rmobile.c
index 717e641..6f7d56e 100644
--- a/arch/arm/mach-shmobile/pm-rmobile.c
+++ b/arch/arm/mach-shmobile/pm-rmobile.c
@@ -106,9 +106,8 @@ static void rmobile_init_pm_domain(struct rmobile_pm_domain *rmobile_pd)
 	struct generic_pm_domain *genpd = &rmobile_pd->genpd;
 	struct dev_power_governor *gov = rmobile_pd->gov;
 
+	genpd->flags = GENPD_FLAG_PM_CLK;
 	pm_genpd_init(genpd, gov ? : &simple_qos_governor, false);
-	genpd->dev_ops.stop		= pm_clk_suspend;
-	genpd->dev_ops.start		= pm_clk_resume;
 	genpd->dev_ops.active_wakeup	= rmobile_pd_active_wakeup;
 	genpd->power_off		= rmobile_pd_power_down;
 	genpd->power_on			= rmobile_pd_power_up;
-- 
1.9.1

