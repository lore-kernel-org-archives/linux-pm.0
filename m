From: Tomasz Figa <t.figa@samsung.com>
Subject: [PATCH v2 13/38] ARM: EXYNOS: pm_domains: Remove legacy power domain
 registration code
Date: Mon, 17 Jun 2013 18:33:58 +0200
Message-ID: <1371486863-12398-14-git-send-email-t.figa@samsung.com>
References: <1371486863-12398-1-git-send-email-t.figa@samsung.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout1.w1.samsung.com ([210.118.77.11]:10306 "EHLO
	mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752584Ab3FQQet (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 17 Jun 2013 12:34:49 -0400
In-reply-to: <1371486863-12398-1-git-send-email-t.figa@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-samsung-soc@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, Kukjin Kim <kgene.kim@samsung.com>, Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>, Marek Szyprowski <m.szyprowski@samsung.com>, Sylwester Nawrocki <s.nawrocki@samsung.com>, Thomas Abraham <thomas.abraham@linaro.org>, Tomasz Figa <t.figa@samsung.com>, linux-pm@vger.kernel.org, "Rafael J. Wysocki" <rjw@sisk.pl>, Kyungmin Park <kyungmin.park@samsung.com>

This patch removes static definitions of power domains and code
responsible for registering them and adding devices to them, since only
DT based boot is now supported on Exynos.

Cc: linux-pm@vger.kernel.org
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>
Signed-off-by: Tomasz Figa <t.figa@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 arch/arm/mach-exynos/pm_domains.c | 94 +--------------------------------------
 1 file changed, 1 insertion(+), 93 deletions(-)

diff --git a/arch/arm/mach-exynos/pm_domains.c b/arch/arm/mach-exynos/pm_domains.c
index beb946d..1703593 100644
--- a/arch/arm/mach-exynos/pm_domains.c
+++ b/arch/arm/mach-exynos/pm_domains.c
@@ -74,16 +74,6 @@ static int exynos_pd_power_off(struct generic_pm_domain *domain)
 	return exynos_pd_power(domain, false);
 }
 
-#define EXYNOS_GPD(PD, BASE, NAME)			\
-static struct exynos_pm_domain PD = {			\
-	.base = (void __iomem *)BASE,			\
-	.name = NAME,					\
-	.pd = {						\
-		.power_off = exynos_pd_power_off,	\
-		.power_on = exynos_pd_power_on,	\
-	},						\
-}
-
 static void exynos_add_device_to_domain(struct exynos_pm_domain *pd,
 					 struct device *dev)
 {
@@ -156,7 +146,7 @@ static struct notifier_block platform_nb = {
 	.notifier_call = exynos_pm_notifier_call,
 };
 
-static __init int exynos_pm_dt_parse_domains(void)
+static __init int exynos4_pm_init_power_domain(void)
 {
 	struct platform_device *pdev;
 	struct device_node *np;
@@ -192,88 +182,6 @@ static __init int exynos_pm_dt_parse_domains(void)
 
 	return 0;
 }
-
-static __init __maybe_unused void exynos_pm_add_dev_to_genpd(struct platform_device *pdev,
-						struct exynos_pm_domain *pd)
-{
-	if (pdev->dev.bus) {
-		if (!pm_genpd_add_device(&pd->pd, &pdev->dev))
-			pm_genpd_dev_need_restore(&pdev->dev, true);
-		else
-			pr_info("%s: error in adding %s device to %s power"
-				"domain\n", __func__, dev_name(&pdev->dev),
-				pd->name);
-	}
-}
-
-EXYNOS_GPD(exynos4_pd_mfc, S5P_PMU_MFC_CONF, "pd-mfc");
-EXYNOS_GPD(exynos4_pd_g3d, S5P_PMU_G3D_CONF, "pd-g3d");
-EXYNOS_GPD(exynos4_pd_lcd0, S5P_PMU_LCD0_CONF, "pd-lcd0");
-EXYNOS_GPD(exynos4_pd_lcd1, S5P_PMU_LCD1_CONF, "pd-lcd1");
-EXYNOS_GPD(exynos4_pd_tv, S5P_PMU_TV_CONF, "pd-tv");
-EXYNOS_GPD(exynos4_pd_cam, S5P_PMU_CAM_CONF, "pd-cam");
-EXYNOS_GPD(exynos4_pd_gps, S5P_PMU_GPS_CONF, "pd-gps");
-
-static struct exynos_pm_domain *exynos4_pm_domains[] = {
-	&exynos4_pd_mfc,
-	&exynos4_pd_g3d,
-	&exynos4_pd_lcd0,
-	&exynos4_pd_lcd1,
-	&exynos4_pd_tv,
-	&exynos4_pd_cam,
-	&exynos4_pd_gps,
-};
-
-static __init int exynos4_pm_init_power_domain(void)
-{
-	int idx;
-
-	if (of_have_populated_dt())
-		return exynos_pm_dt_parse_domains();
-
-	for (idx = 0; idx < ARRAY_SIZE(exynos4_pm_domains); idx++) {
-		struct exynos_pm_domain *pd = exynos4_pm_domains[idx];
-		int on = __raw_readl(pd->base + 0x4) & S5P_INT_LOCAL_PWR_EN;
-
-		pm_genpd_init(&pd->pd, NULL, !on);
-	}
-
-#ifdef CONFIG_S5P_DEV_FIMD0
-	exynos_pm_add_dev_to_genpd(&s5p_device_fimd0, &exynos4_pd_lcd0);
-#endif
-#ifdef CONFIG_S5P_DEV_TV
-	exynos_pm_add_dev_to_genpd(&s5p_device_hdmi, &exynos4_pd_tv);
-	exynos_pm_add_dev_to_genpd(&s5p_device_mixer, &exynos4_pd_tv);
-#endif
-#ifdef CONFIG_S5P_DEV_MFC
-	exynos_pm_add_dev_to_genpd(&s5p_device_mfc, &exynos4_pd_mfc);
-#endif
-#ifdef CONFIG_S5P_DEV_FIMC0
-	exynos_pm_add_dev_to_genpd(&s5p_device_fimc0, &exynos4_pd_cam);
-#endif
-#ifdef CONFIG_S5P_DEV_FIMC1
-	exynos_pm_add_dev_to_genpd(&s5p_device_fimc1, &exynos4_pd_cam);
-#endif
-#ifdef CONFIG_S5P_DEV_FIMC2
-	exynos_pm_add_dev_to_genpd(&s5p_device_fimc2, &exynos4_pd_cam);
-#endif
-#ifdef CONFIG_S5P_DEV_FIMC3
-	exynos_pm_add_dev_to_genpd(&s5p_device_fimc3, &exynos4_pd_cam);
-#endif
-#ifdef CONFIG_S5P_DEV_CSIS0
-	exynos_pm_add_dev_to_genpd(&s5p_device_mipi_csis0, &exynos4_pd_cam);
-#endif
-#ifdef CONFIG_S5P_DEV_CSIS1
-	exynos_pm_add_dev_to_genpd(&s5p_device_mipi_csis1, &exynos4_pd_cam);
-#endif
-#ifdef CONFIG_S5P_DEV_G2D
-	exynos_pm_add_dev_to_genpd(&s5p_device_g2d, &exynos4_pd_lcd0);
-#endif
-#ifdef CONFIG_S5P_DEV_JPEG
-	exynos_pm_add_dev_to_genpd(&s5p_device_jpeg, &exynos4_pd_cam);
-#endif
-	return 0;
-}
 arch_initcall(exynos4_pm_init_power_domain);
 
 int __init exynos_pm_late_initcall(void)
-- 
1.8.2.1

