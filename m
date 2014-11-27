From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH V2 3/3] ARM: shmobile: Convert to genpd flags for PM clocks for R-mobile
Date: Thu, 27 Nov 2014 15:51:51 +0100
Message-ID: <1417099911-12688-4-git-send-email-ulf.hansson@linaro.org>
References: <1417099911-12688-1-git-send-email-ulf.hansson@linaro.org>
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <1417099911-12688-1-git-send-email-ulf.hansson@linaro.org>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, linux-pm@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>, Kevin Hilman <khilman@linaro.org>, Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, Russell King <linux@arm.linux.org.uk>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Sylwester Nawrocki <s.nawrocki@samsung.com>, Grygorii Strashko <grygorii.strashko@ti.com>, Arnd Bergmann <arnd@arndb.de>, Ulf Hansson <ulf.hansson@linaro.org>
List-Id: linux-pm@vger.kernel.org

Instead of using the dev_ops ->stop|start() callbacks for genpd, let's
convert to use genpd's flag field and set it to PM_DOMAIN_PM_CLK.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---

Changes in v2:
	None.

---
 arch/arm/mach-shmobile/pm-rmobile.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/arm/mach-shmobile/pm-rmobile.c b/arch/arm/mach-shmobile/pm-rmobile.c
index 717e641..42af9bd 100644
--- a/arch/arm/mach-shmobile/pm-rmobile.c
+++ b/arch/arm/mach-shmobile/pm-rmobile.c
@@ -106,9 +106,8 @@ static void rmobile_init_pm_domain(struct rmobile_pm_domain *rmobile_pd)
 	struct generic_pm_domain *genpd = &rmobile_pd->genpd;
 	struct dev_power_governor *gov = rmobile_pd->gov;
 
+	genpd->flags = PM_DOMAIN_PM_CLK;
 	pm_genpd_init(genpd, gov ? : &simple_qos_governor, false);
-	genpd->dev_ops.stop		= pm_clk_suspend;
-	genpd->dev_ops.start		= pm_clk_resume;
 	genpd->dev_ops.active_wakeup	= rmobile_pd_active_wakeup;
 	genpd->power_off		= rmobile_pd_power_down;
 	genpd->power_on			= rmobile_pd_power_up;
-- 
1.9.1
