From: Lina Iyer <lina.iyer@linaro.org>
Subject: Re: [PATCH v9 1/6] PM / Domains: prepare for multiple states
Date: Mon, 19 Oct 2015 10:35:23 -0600
Message-ID: <20151019163523.GA79460@linaro.org>
References: <1445266301-32448-1-git-send-email-ahaslam@baylibre.com>
 <1445266301-32448-2-git-send-email-ahaslam@baylibre.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1445266301-32448-2-git-send-email-ahaslam@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
To: ahaslam@baylibre.com
Cc: khilman@linaro.org, ulf.hansson@linaro.org, geert@glider.be, k.kozlowski.k@gmail.com, rjw@rjwysocki.net, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, bcousson@baylibre.com, mturquette@baylibre.com, Axel Haslam <ahaslam+renesas@baylibre.com>
List-Id: linux-pm@vger.kernel.org

Hi Axel,

Thanks for rebasing.

I ran into a compilation issue on ARM64 with defconfig.

On Mon, Oct 19 2015 at 08:52 -0600, ahaslam@baylibre.com wrote:
>From: Axel Haslam <ahaslam+renesas@baylibre.com>
>
>prepare generic power domain init function parameters to accept a pointer
>to the states structure that describes the possible states that a power
>domain can enter.
>
>Also, as most platforms are not initializing states or latencies, add
>pm_genpd_init_simple that allows platfroms to use a default single OFF
>state with initial latencies set to 0.
>
>There is no functional change, as support for multiple domains will be
>added in subsequent patches.
>
>Suggested-by: Lina Iyer <lina.iyer@linaro.org>
>Signed-off-by: Axel Haslam <ahaslam+renesas@baylibre.com>
>---
> arch/arm/mach-exynos/pm_domains.c     |  2 +-
> arch/arm/mach-imx/gpc.c               |  2 +-
> arch/arm/mach-s3c64xx/pm.c            |  4 ++--
> arch/arm/mach-shmobile/pm-r8a7779.c   |  2 +-
> arch/arm/mach-shmobile/pm-rmobile.c   |  2 +-
> arch/arm/mach-ux500/pm_domains.c      |  2 +-
> arch/arm/mach-zx/zx296702-pm-domain.c |  2 +-
> drivers/base/power/domain.c           | 19 ++++++++++++++++++-
> drivers/clk/shmobile/clk-mstp.c       |  2 +-

Change in drivers/clk/qcom/gdsc.c is missing.

Thanks,
Lina

> drivers/soc/dove/pmu.c                |  2 +-
> drivers/soc/mediatek/mtk-scpsys.c     |  2 +-
> include/linux/pm_domain.h             | 27 ++++++++++++++++++++++++++-
> 12 files changed, 55 insertions(+), 13 deletions(-)
>
>diff --git a/arch/arm/mach-exynos/pm_domains.c b/arch/arm/mach-exynos/pm_domains.c
>index 4a87e86..a0abaa1 100644
>--- a/arch/arm/mach-exynos/pm_domains.c
>+++ b/arch/arm/mach-exynos/pm_domains.c
>@@ -187,7 +187,7 @@ static __init int exynos4_pm_init_power_domain(void)
> no_clk:
> 		on = __raw_readl(pd->base + 0x4) & INT_LOCAL_PWR_EN;
>
>-		pm_genpd_init(&pd->pd, NULL, !on);
>+		pm_genpd_init_simple(&pd->pd, NULL, !on);
> 		of_genpd_add_provider_simple(np, &pd->pd);
> 	}
>
>diff --git a/arch/arm/mach-imx/gpc.c b/arch/arm/mach-imx/gpc.c
>index 8c4467f..76658f8 100644
>--- a/arch/arm/mach-imx/gpc.c
>+++ b/arch/arm/mach-imx/gpc.c
>@@ -419,7 +419,7 @@ static int imx_gpc_genpd_init(struct device *dev, struct regulator *pu_reg)
> 	if (!IS_ENABLED(CONFIG_PM_GENERIC_DOMAINS))
> 		return 0;
>
>-	pm_genpd_init(&imx6q_pu_domain.base, NULL, false);
>+	pm_genpd_init_simple(&imx6q_pu_domain.base, NULL, false);
> 	return of_genpd_add_provider_onecell(dev->of_node,
> 					     &imx_gpc_onecell_data);
>
>diff --git a/arch/arm/mach-s3c64xx/pm.c b/arch/arm/mach-s3c64xx/pm.c
>index 75b14e7..d68a45c 100644
>--- a/arch/arm/mach-s3c64xx/pm.c
>+++ b/arch/arm/mach-s3c64xx/pm.c
>@@ -316,11 +316,11 @@ int __init s3c64xx_pm_init(void)
> 	s3c_pm_init();
>
> 	for (i = 0; i < ARRAY_SIZE(s3c64xx_always_on_pm_domains); i++)
>-		pm_genpd_init(&s3c64xx_always_on_pm_domains[i]->pd,
>+		pm_genpd_init_simple(&s3c64xx_always_on_pm_domains[i]->pd,
> 			      &pm_domain_always_on_gov, false);
>
> 	for (i = 0; i < ARRAY_SIZE(s3c64xx_pm_domains); i++)
>-		pm_genpd_init(&s3c64xx_pm_domains[i]->pd, NULL, false);
>+		pm_genpd_init_simple(&s3c64xx_pm_domains[i]->pd, NULL, false);
>
> #ifdef CONFIG_S3C_DEV_FB
> 	if (dev_get_platdata(&s3c_device_fb.dev))
>diff --git a/arch/arm/mach-shmobile/pm-r8a7779.c b/arch/arm/mach-shmobile/pm-r8a7779.c
>index 47a862e..5eac8cd 100644
>--- a/arch/arm/mach-shmobile/pm-r8a7779.c
>+++ b/arch/arm/mach-shmobile/pm-r8a7779.c
>@@ -84,7 +84,7 @@ static void r8a7779_init_pm_domain(struct r8a7779_pm_domain *r8a7779_pd)
> {
> 	struct generic_pm_domain *genpd = &r8a7779_pd->genpd;
>
>-	pm_genpd_init(genpd, NULL, false);
>+	pm_genpd_init_simple(genpd, NULL, false);
> 	genpd->dev_ops.active_wakeup = pd_active_wakeup;
> 	genpd->power_off = pd_power_down;
> 	genpd->power_on = pd_power_up;
>diff --git a/arch/arm/mach-shmobile/pm-rmobile.c b/arch/arm/mach-shmobile/pm-rmobile.c
>index a5b96b9..e1ca6e2 100644
>--- a/arch/arm/mach-shmobile/pm-rmobile.c
>+++ b/arch/arm/mach-shmobile/pm-rmobile.c
>@@ -160,7 +160,7 @@ static void rmobile_init_pm_domain(struct rmobile_pm_domain *rmobile_pd)
> 	struct dev_power_governor *gov = rmobile_pd->gov;
>
> 	genpd->flags = GENPD_FLAG_PM_CLK;
>-	pm_genpd_init(genpd, gov ? : &simple_qos_governor, false);
>+	pm_genpd_init_simple(genpd, gov ? : &simple_qos_governor, false);
> 	genpd->dev_ops.active_wakeup	= rmobile_pd_active_wakeup;
> 	genpd->power_off		= rmobile_pd_power_down;
> 	genpd->power_on			= rmobile_pd_power_up;
>diff --git a/arch/arm/mach-ux500/pm_domains.c b/arch/arm/mach-ux500/pm_domains.c
>index 4d71c90..208e784 100644
>--- a/arch/arm/mach-ux500/pm_domains.c
>+++ b/arch/arm/mach-ux500/pm_domains.c
>@@ -72,7 +72,7 @@ int __init ux500_pm_domains_init(void)
> 	genpd_data->num_domains = ARRAY_SIZE(ux500_pm_domains);
>
> 	for (i = 0; i < ARRAY_SIZE(ux500_pm_domains); ++i)
>-		pm_genpd_init(ux500_pm_domains[i], NULL, false);
>+		pm_genpd_init_simple(ux500_pm_domains[i], NULL, false);
>
> 	of_genpd_add_provider_onecell(np, genpd_data);
> 	return 0;
>diff --git a/arch/arm/mach-zx/zx296702-pm-domain.c b/arch/arm/mach-zx/zx296702-pm-domain.c
>index e08574d..0ec8f0c 100644
>--- a/arch/arm/mach-zx/zx296702-pm-domain.c
>+++ b/arch/arm/mach-zx/zx296702-pm-domain.c
>@@ -175,7 +175,7 @@ static int zx296702_pd_probe(struct platform_device *pdev)
> 	}
>
> 	for (i = 0; i < ARRAY_SIZE(zx296702_pm_domains); ++i)
>-		pm_genpd_init(zx296702_pm_domains[i], NULL, false);
>+		pm_genpd_init_simple(zx296702_pm_domains[i], NULL, false);
>
> 	of_genpd_add_provider_onecell(pdev->dev.of_node, genpd_data);
> 	return 0;
>diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
>index 6e1bcde..bb7f415 100644
>--- a/drivers/base/power/domain.c
>+++ b/drivers/base/power/domain.c
>@@ -1445,10 +1445,14 @@ static int pm_genpd_default_restore_state(struct device *dev)
>  * pm_genpd_init - Initialize a generic I/O PM domain object.
>  * @genpd: PM domain object to initialize.
>  * @gov: PM domain governor to associate with the domain (may be NULL).
>+ * @states: Array of possible low power states when powering off.
>+ * @state_count: Number of low power states.
>  * @is_off: Initial value of the domain's power_is_off field.
>  */
> void pm_genpd_init(struct generic_pm_domain *genpd,
>-		   struct dev_power_governor *gov, bool is_off)
>+		   struct dev_power_governor *gov,
>+		   const struct genpd_power_state *states,
>+		   unsigned int state_count, bool is_off)
> {
> 	if (IS_ERR_OR_NULL(genpd))
> 		return;
>@@ -1500,6 +1504,19 @@ void pm_genpd_init(struct generic_pm_domain *genpd,
> }
> EXPORT_SYMBOL_GPL(pm_genpd_init);
>
>+/**
>+ * pm_genpd_init_simple - Initialize a generic I/O PM domain object.
>+ * @genpd: PM domain object to initialize.
>+ * @gov: PM domain governor to associate with the domain (may be NULL).
>+ * @is_off: Initial value of the domain's power_is_off field.
>+ */
>+void pm_genpd_init_simple(struct generic_pm_domain *genpd,
>+		   struct dev_power_governor *gov, bool is_off)
>+{
>+	pm_genpd_init(genpd, gov, NULL, 0, is_off);
>+}
>+EXPORT_SYMBOL_GPL(pm_genpd_init_simple);
>+
> #ifdef CONFIG_PM_GENERIC_DOMAINS_OF
> /*
>  * Device Tree based PM domain providers.
>diff --git a/drivers/clk/shmobile/clk-mstp.c b/drivers/clk/shmobile/clk-mstp.c
>index b1df7b2..3c96157 100644
>--- a/drivers/clk/shmobile/clk-mstp.c
>+++ b/drivers/clk/shmobile/clk-mstp.c
>@@ -316,7 +316,7 @@ void __init cpg_mstp_add_clk_domain(struct device_node *np)
> 	pd->name = np->name;
>
> 	pd->flags = GENPD_FLAG_PM_CLK;
>-	pm_genpd_init(pd, &simple_qos_governor, false);
>+	pm_genpd_init_simple(pd, &simple_qos_governor, false);
> 	pd->attach_dev = cpg_mstp_attach_dev;
> 	pd->detach_dev = cpg_mstp_detach_dev;
>
>diff --git a/drivers/soc/dove/pmu.c b/drivers/soc/dove/pmu.c
>index abd0879..42adc16 100644
>--- a/drivers/soc/dove/pmu.c
>+++ b/drivers/soc/dove/pmu.c
>@@ -215,7 +215,7 @@ static void __pmu_domain_register(struct pmu_domain *domain,
> 	domain->base.power_off = pmu_domain_power_off;
> 	domain->base.power_on = pmu_domain_power_on;
>
>-	pm_genpd_init(&domain->base, NULL, !(val & domain->pwr_mask));
>+	pm_genpd_init_simple(&domain->base, NULL, !(val & domain->pwr_mask));
>
> 	if (np)
> 		of_genpd_add_provider_simple(np, &domain->base);
>diff --git a/drivers/soc/mediatek/mtk-scpsys.c b/drivers/soc/mediatek/mtk-scpsys.c
>index 164a7d8..adf364f 100644
>--- a/drivers/soc/mediatek/mtk-scpsys.c
>+++ b/drivers/soc/mediatek/mtk-scpsys.c
>@@ -443,7 +443,7 @@ static int __init scpsys_probe(struct platform_device *pdev)
> 		 */
> 		genpd->power_on(genpd);
>
>-		pm_genpd_init(genpd, NULL, false);
>+		pm_genpd_init_simple(genpd, NULL, false);
> 	}
>
> 	/*
>diff --git a/include/linux/pm_domain.h b/include/linux/pm_domain.h
>index f4dd810..f37faec 100644
>--- a/include/linux/pm_domain.h
>+++ b/include/linux/pm_domain.h
>@@ -37,6 +37,17 @@ struct gpd_dev_ops {
> 	bool (*active_wakeup)(struct device *dev);
> };
>
>+struct gpd_cpuidle_data {
>+	unsigned int saved_exit_latency;
>+	struct cpuidle_state *idle_state;
>+};
>+
>+struct genpd_power_state {
>+	char *name;
>+	s64 power_off_latency_ns;
>+	s64 power_on_latency_ns;
>+};
>+
> struct generic_pm_domain {
> 	struct dev_pm_domain domain;	/* PM domain operations */
> 	struct list_head gpd_list_node;	/* Node in the global PM domains list */
>@@ -124,7 +135,14 @@ extern int pm_genpd_add_subdomain(struct generic_pm_domain *genpd,
> extern int pm_genpd_remove_subdomain(struct generic_pm_domain *genpd,
> 				     struct generic_pm_domain *target);
> extern void pm_genpd_init(struct generic_pm_domain *genpd,
>+			  struct dev_power_governor *gov,
>+			  const struct genpd_power_state *states,
>+			  unsigned int state_count, bool is_off);
>+extern void pm_genpd_init_simple(struct generic_pm_domain *genpd,
> 			  struct dev_power_governor *gov, bool is_off);
>+extern int pm_genpd_poweron(struct generic_pm_domain *genpd);
>+extern int pm_genpd_name_poweron(const char *domain_name);
>+extern void pm_genpd_poweroff_unused(void);
>
> extern struct dev_power_governor simple_qos_governor;
> extern struct dev_power_governor pm_domain_always_on_gov;
>@@ -160,7 +178,14 @@ static inline int pm_genpd_remove_subdomain(struct generic_pm_domain *genpd,
> 	return -ENOSYS;
> }
> static inline void pm_genpd_init(struct generic_pm_domain *genpd,
>-				 struct dev_power_governor *gov, bool is_off)
>+				 struct dev_power_governor *gov,
>+				 const struct genpd_power_state *states,
>+				 unsigned int state_count, bool is_off)
>+{
>+}
>+static inline void pm_genpd_init_simple(struct generic_pm_domain *genpd,
>+					struct dev_power_governor *gov,
>+					bool is_off)
> {
> }
> #endif
>-- 
>2.4.5
>
