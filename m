From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 3/4] PM / Domains: Expect PM domains being powered at initialization
Date: Tue, 30 Sep 2014 14:43:52 +0200
Message-ID: <1412081033-8136-4-git-send-email-ulf.hansson@linaro.org>
References: <1412081033-8136-1-git-send-email-ulf.hansson@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-lb0-f176.google.com ([209.85.217.176]:64467 "EHLO
	mail-lb0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751995AbaI3MoL (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 30 Sep 2014 08:44:11 -0400
Received: by mail-lb0-f176.google.com with SMTP id p9so4234768lbv.7
        for <linux-pm@vger.kernel.org>; Tue, 30 Sep 2014 05:44:09 -0700 (PDT)
In-Reply-To: <1412081033-8136-1-git-send-email-ulf.hansson@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, linux-pm@vger.kernel.org
Cc: Geert Uytterhoeven <geert+renesas@glider.be>, Kevin Hilman <khilman@linaro.org>, Tomasz Figa <tomasz.figa@gmail.com>, Philipp Zabel <philipp.zabel@gmail.com>, Russell King <linux@arm.linux.org.uk>, Mark Brown <broonie@kernel.org>, Wolfram Sang <wsa@the-dreams.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jack Dai <jack.dai@rock-chips.com>, Jinkun Hong <jinkun.hong@rock-chips.com>, Ulf Hansson <ulf.hansson@linaro.org>

At ->probe() it's common practice for drivers/subsystems to bring their
devices to full power and without depending on CONFIG_PM_RUNTIME.

We could also expect that drivers/subsystems requires their device's
corresponding PM domains to be powered, to successfully complete a
->probe() sequence.

Align the generic PM domain to the behavior above, by enforcing a PM
domain to be powered at initialization. Since all callers of
pm_genpd_init() already provides "false" as the value for the "is_off"
parameter, let's make it clear by removing this option.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 arch/arm/mach-exynos/pm_domains.c   | 2 +-
 arch/arm/mach-s3c64xx/pm.c          | 4 ++--
 arch/arm/mach-shmobile/pm-r8a7779.c | 2 +-
 arch/arm/mach-shmobile/pm-rmobile.c | 2 +-
 drivers/base/power/domain.c         | 5 ++---
 include/linux/pm_domain.h           | 4 ++--
 6 files changed, 9 insertions(+), 10 deletions(-)

diff --git a/arch/arm/mach-exynos/pm_domains.c b/arch/arm/mach-exynos/pm_domains.c
index 58e18e9..f2e5096 100644
--- a/arch/arm/mach-exynos/pm_domains.c
+++ b/arch/arm/mach-exynos/pm_domains.c
@@ -158,7 +158,7 @@ no_clk:
 		if (!(__raw_readl(pd->base + 0x4) & INT_LOCAL_PWR_EN))
 			exynos_pd_power_on(&pd->pd);
 
-		pm_genpd_init(&pd->pd, NULL, false);
+		pm_genpd_init(&pd->pd, NULL);
 		of_genpd_add_provider_simple(np, &pd->pd);
 	}
 
diff --git a/arch/arm/mach-s3c64xx/pm.c b/arch/arm/mach-s3c64xx/pm.c
index aaf7bea..42dead0 100644
--- a/arch/arm/mach-s3c64xx/pm.c
+++ b/arch/arm/mach-s3c64xx/pm.c
@@ -315,10 +315,10 @@ int __init s3c64xx_pm_init(void)
 
 	for (i = 0; i < ARRAY_SIZE(s3c64xx_always_on_pm_domains); i++)
 		pm_genpd_init(&s3c64xx_always_on_pm_domains[i]->pd,
-			      &pm_domain_always_on_gov, false);
+			      &pm_domain_always_on_gov);
 
 	for (i = 0; i < ARRAY_SIZE(s3c64xx_pm_domains); i++)
-		pm_genpd_init(&s3c64xx_pm_domains[i]->pd, NULL, false);
+		pm_genpd_init(&s3c64xx_pm_domains[i]->pd, NULL);
 
 #ifdef CONFIG_S3C_DEV_FB
 	if (dev_get_platdata(&s3c_device_fb.dev))
diff --git a/arch/arm/mach-shmobile/pm-r8a7779.c b/arch/arm/mach-shmobile/pm-r8a7779.c
index 82fe3d7..c20ef44 100644
--- a/arch/arm/mach-shmobile/pm-r8a7779.c
+++ b/arch/arm/mach-shmobile/pm-r8a7779.c
@@ -83,7 +83,7 @@ static void r8a7779_init_pm_domain(struct r8a7779_pm_domain *r8a7779_pd)
 {
 	struct generic_pm_domain *genpd = &r8a7779_pd->genpd;
 
-	pm_genpd_init(genpd, NULL, false);
+	pm_genpd_init(genpd, NULL);
 	genpd->dev_ops.stop = pm_clk_suspend;
 	genpd->dev_ops.start = pm_clk_resume;
 	genpd->dev_ops.active_wakeup = pd_active_wakeup;
diff --git a/arch/arm/mach-shmobile/pm-rmobile.c b/arch/arm/mach-shmobile/pm-rmobile.c
index 818de2f..e6a0490 100644
--- a/arch/arm/mach-shmobile/pm-rmobile.c
+++ b/arch/arm/mach-shmobile/pm-rmobile.c
@@ -107,7 +107,7 @@ static void rmobile_init_pm_domain(struct rmobile_pm_domain *rmobile_pd)
 	struct generic_pm_domain *genpd = &rmobile_pd->genpd;
 	struct dev_power_governor *gov = rmobile_pd->gov;
 
-	pm_genpd_init(genpd, gov ? : &simple_qos_governor, false);
+	pm_genpd_init(genpd, gov ? : &simple_qos_governor);
 	genpd->dev_ops.stop		= pm_clk_suspend;
 	genpd->dev_ops.start		= pm_clk_resume;
 	genpd->dev_ops.active_wakeup	= rmobile_pd_active_wakeup;
diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
index 36871b3..cfb76e8 100644
--- a/drivers/base/power/domain.c
+++ b/drivers/base/power/domain.c
@@ -1836,10 +1836,9 @@ static int pm_genpd_default_restore_state(struct device *dev)
  * pm_genpd_init - Initialize a generic I/O PM domain object.
  * @genpd: PM domain object to initialize.
  * @gov: PM domain governor to associate with the domain (may be NULL).
- * @is_off: Initial value of the domain's power_is_off field.
  */
 void pm_genpd_init(struct generic_pm_domain *genpd,
-		   struct dev_power_governor *gov, bool is_off)
+		   struct dev_power_governor *gov)
 {
 	if (IS_ERR_OR_NULL(genpd))
 		return;
@@ -1852,7 +1851,7 @@ void pm_genpd_init(struct generic_pm_domain *genpd,
 	INIT_WORK(&genpd->power_off_work, genpd_power_off_work_fn);
 	genpd->in_progress = 0;
 	atomic_set(&genpd->sd_count, 0);
-	genpd->status = is_off ? GPD_STATE_POWER_OFF : GPD_STATE_ACTIVE;
+	genpd->status = GPD_STATE_ACTIVE;
 	init_waitqueue_head(&genpd->status_wait_queue);
 	genpd->poweroff_task = NULL;
 	genpd->resume_count = 0;
diff --git a/include/linux/pm_domain.h b/include/linux/pm_domain.h
index a21dfa9..ad4aa87 100644
--- a/include/linux/pm_domain.h
+++ b/include/linux/pm_domain.h
@@ -140,7 +140,7 @@ extern int pm_genpd_name_attach_cpuidle(const char *name, int state);
 extern int pm_genpd_detach_cpuidle(struct generic_pm_domain *genpd);
 extern int pm_genpd_name_detach_cpuidle(const char *name);
 extern void pm_genpd_init(struct generic_pm_domain *genpd,
-			  struct dev_power_governor *gov, bool is_off);
+			  struct dev_power_governor *gov);
 
 extern int pm_genpd_poweron(struct generic_pm_domain *genpd);
 extern int pm_genpd_name_poweron(const char *domain_name);
@@ -206,7 +206,7 @@ static inline int pm_genpd_name_detach_cpuidle(const char *name)
 	return -ENOSYS;
 }
 static inline void pm_genpd_init(struct generic_pm_domain *genpd,
-				 struct dev_power_governor *gov, bool is_off)
+				 struct dev_power_governor *gov)
 {
 }
 static inline int pm_genpd_poweron(struct generic_pm_domain *genpd)
-- 
1.9.1

