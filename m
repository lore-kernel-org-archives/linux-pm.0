From: ahaslam@baylibre.com
Subject: [PATCH/RFC v6 1/5] PM / Domains: prepare for multiple states
Date: Wed, 29 Apr 2015 21:10:11 +0200
Message-ID: <1430334615-1161-2-git-send-email-ahaslam@baylibre.com>
References: <1430334615-1161-1-git-send-email-ahaslam@baylibre.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wg0-f47.google.com ([74.125.82.47]:33004 "EHLO
	mail-wg0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751430AbbD2TLS (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 29 Apr 2015 15:11:18 -0400
Received: by wgin8 with SMTP id n8so38935724wgi.0
        for <linux-pm@vger.kernel.org>; Wed, 29 Apr 2015 12:11:17 -0700 (PDT)
In-Reply-To: <1430334615-1161-1-git-send-email-ahaslam@baylibre.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: ulf.hansson@linaro.org, khilman@linaro.org, k.kozlowski.k@gmail.com, geert@linux-m68k.org, rjw@rjwysocki.net
Cc: bcousson@baylibre.com, linux-pm@vger.kernel.org, Axel Haslam <ahaslam+renesas@baylibre.com>

From: Axel Haslam <ahaslam+renesas@baylibre.com>

prepare generic power domain init function parameters
to accept a pointer to the states structure that describes
the possible states that a power domain can enter.

There is no functional change, as support for multiple
domains will be added in subsequent patches.

Signed-off-by: Axel Haslam <ahaslam+renesas@baylibre.com>
---
 arch/arm/mach-exynos/pm_domains.c   |  2 +-
 arch/arm/mach-imx/gpc.c             |  2 +-
 arch/arm/mach-s3c64xx/pm.c          |  5 +++--
 arch/arm/mach-shmobile/pm-r8a7779.c |  2 +-
 arch/arm/mach-shmobile/pm-rmobile.c |  2 +-
 arch/arm/mach-ux500/pm_domains.c    |  2 +-
 drivers/base/power/domain.c         |  6 +++++-
 include/linux/pm_domain.h           | 14 ++++++++++++--
 8 files changed, 25 insertions(+), 10 deletions(-)

diff --git a/arch/arm/mach-exynos/pm_domains.c b/arch/arm/mach-exynos/pm_domains.c
index cbe56b3..3c68239 100644
--- a/arch/arm/mach-exynos/pm_domains.c
+++ b/arch/arm/mach-exynos/pm_domains.c
@@ -176,7 +176,7 @@ static __init int exynos4_pm_init_power_domain(void)
 no_clk:
 		on = __raw_readl(pd->base + 0x4) & INT_LOCAL_PWR_EN;
 
-		pm_genpd_init(&pd->pd, NULL, !on);
+		pm_genpd_init(&pd->pd, NULL, NULL, 0, !on);
 		of_genpd_add_provider_simple(np, &pd->pd);
 	}
 
diff --git a/arch/arm/mach-imx/gpc.c b/arch/arm/mach-imx/gpc.c
index 4d60005..092b4ae 100644
--- a/arch/arm/mach-imx/gpc.c
+++ b/arch/arm/mach-imx/gpc.c
@@ -421,7 +421,7 @@ static int imx_gpc_genpd_init(struct device *dev, struct regulator *pu_reg)
 		imx6q_pm_pu_power_on(&imx6q_pu_domain.base);
 	}
 
-	pm_genpd_init(&imx6q_pu_domain.base, NULL, is_off);
+	pm_genpd_init(&imx6q_pu_domain.base, NULL, NULL, 0, is_off);
 	return of_genpd_add_provider_onecell(dev->of_node,
 					     &imx_gpc_onecell_data);
 
diff --git a/arch/arm/mach-s3c64xx/pm.c b/arch/arm/mach-s3c64xx/pm.c
index 75b14e7..0e79375 100644
--- a/arch/arm/mach-s3c64xx/pm.c
+++ b/arch/arm/mach-s3c64xx/pm.c
@@ -317,10 +317,11 @@ int __init s3c64xx_pm_init(void)
 
 	for (i = 0; i < ARRAY_SIZE(s3c64xx_always_on_pm_domains); i++)
 		pm_genpd_init(&s3c64xx_always_on_pm_domains[i]->pd,
-			      &pm_domain_always_on_gov, false);
+			      &pm_domain_always_on_gov, NULL, 0, false);
 
 	for (i = 0; i < ARRAY_SIZE(s3c64xx_pm_domains); i++)
-		pm_genpd_init(&s3c64xx_pm_domains[i]->pd, NULL, false);
+		pm_genpd_init(&s3c64xx_pm_domains[i]->pd,
+			      NULL, NULL, 0, false);
 
 #ifdef CONFIG_S3C_DEV_FB
 	if (dev_get_platdata(&s3c_device_fb.dev))
diff --git a/arch/arm/mach-shmobile/pm-r8a7779.c b/arch/arm/mach-shmobile/pm-r8a7779.c
index 44a74c4..a89a94f 100644
--- a/arch/arm/mach-shmobile/pm-r8a7779.c
+++ b/arch/arm/mach-shmobile/pm-r8a7779.c
@@ -84,7 +84,7 @@ static void r8a7779_init_pm_domain(struct r8a7779_pm_domain *r8a7779_pd)
 	struct generic_pm_domain *genpd = &r8a7779_pd->genpd;
 
 	genpd->flags = GENPD_FLAG_PM_CLK;
-	pm_genpd_init(genpd, NULL, false);
+	pm_genpd_init(genpd, NULL, NULL, 0, false);
 	genpd->dev_ops.active_wakeup = pd_active_wakeup;
 	genpd->power_off = pd_power_down;
 	genpd->power_on = pd_power_up;
diff --git a/arch/arm/mach-shmobile/pm-rmobile.c b/arch/arm/mach-shmobile/pm-rmobile.c
index 9501820..18f87c5 100644
--- a/arch/arm/mach-shmobile/pm-rmobile.c
+++ b/arch/arm/mach-shmobile/pm-rmobile.c
@@ -154,7 +154,7 @@ static void rmobile_init_pm_domain(struct rmobile_pm_domain *rmobile_pd)
 	struct dev_power_governor *gov = rmobile_pd->gov;
 
 	genpd->flags = GENPD_FLAG_PM_CLK;
-	pm_genpd_init(genpd, gov ? : &simple_qos_governor, false);
+	pm_genpd_init(genpd, gov ? : &simple_qos_governor, NULL, 0, false);
 	genpd->dev_ops.active_wakeup	= rmobile_pd_active_wakeup;
 	genpd->power_off		= rmobile_pd_power_down;
 	genpd->power_on			= rmobile_pd_power_up;
diff --git a/arch/arm/mach-ux500/pm_domains.c b/arch/arm/mach-ux500/pm_domains.c
index 4d71c90..7bd4d98 100644
--- a/arch/arm/mach-ux500/pm_domains.c
+++ b/arch/arm/mach-ux500/pm_domains.c
@@ -72,7 +72,7 @@ int __init ux500_pm_domains_init(void)
 	genpd_data->num_domains = ARRAY_SIZE(ux500_pm_domains);
 
 	for (i = 0; i < ARRAY_SIZE(ux500_pm_domains); ++i)
-		pm_genpd_init(ux500_pm_domains[i], NULL, false);
+		pm_genpd_init(ux500_pm_domains[i], NULL, NULL, 0, false);
 
 	of_genpd_add_provider_onecell(np, genpd_data);
 	return 0;
diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
index 2327613..3849312 100644
--- a/drivers/base/power/domain.c
+++ b/drivers/base/power/domain.c
@@ -1882,10 +1882,14 @@ static int pm_genpd_default_restore_state(struct device *dev)
  * pm_genpd_init - Initialize a generic I/O PM domain object.
  * @genpd: PM domain object to initialize.
  * @gov: PM domain governor to associate with the domain (may be NULL).
+ * @states: Array of possible low power states when powering off.
+ * @state_count: Number of low power states.
  * @is_off: Initial value of the domain's power_is_off field.
  */
 void pm_genpd_init(struct generic_pm_domain *genpd,
-		   struct dev_power_governor *gov, bool is_off)
+		   struct dev_power_governor *gov,
+		   const struct genpd_power_state *states,
+		   int state_count, bool is_off)
 {
 	if (IS_ERR_OR_NULL(genpd))
 		return;
diff --git a/include/linux/pm_domain.h b/include/linux/pm_domain.h
index 681ccb0..96265d5 100644
--- a/include/linux/pm_domain.h
+++ b/include/linux/pm_domain.h
@@ -46,6 +46,12 @@ struct gpd_cpuidle_data {
 	struct cpuidle_state *idle_state;
 };
 
+struct genpd_power_state {
+	char *name;
+	s64 power_off_latency_ns;
+	s64 power_on_latency_ns;
+};
+
 struct generic_pm_domain {
 	struct dev_pm_domain domain;	/* PM domain operations */
 	struct list_head gpd_list_node;	/* Node in the global PM domains list */
@@ -149,7 +155,9 @@ extern int pm_genpd_name_attach_cpuidle(const char *name, int state);
 extern int pm_genpd_detach_cpuidle(struct generic_pm_domain *genpd);
 extern int pm_genpd_name_detach_cpuidle(const char *name);
 extern void pm_genpd_init(struct generic_pm_domain *genpd,
-			  struct dev_power_governor *gov, bool is_off);
+			  struct dev_power_governor *gov,
+			  const struct genpd_power_state *states,
+			  int state_count, bool is_off);
 
 extern int pm_genpd_poweron(struct generic_pm_domain *genpd);
 extern int pm_genpd_name_poweron(const char *domain_name);
@@ -216,7 +224,9 @@ static inline int pm_genpd_name_detach_cpuidle(const char *name)
 	return -ENOSYS;
 }
 static inline void pm_genpd_init(struct generic_pm_domain *genpd,
-				 struct dev_power_governor *gov, bool is_off)
+				 struct dev_power_governor *gov,
+				 const struct genpd_power_state *states,
+				 int state_count, bool is_off)
 {
 }
 static inline int pm_genpd_poweron(struct generic_pm_domain *genpd)
-- 
1.9.1

