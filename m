From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 3/3] cpufreq: exynos: Use generic platdev driver
Date: Tue, 29 Mar 2016 09:49:23 +0530
Message-ID: <20160329041923.GB25424@vireshk-i7>
References: <cover.1458801338.git.viresh.kumar@linaro.org>
 <6cb29053bce7026dd9429326236a67c45e901c7b.1458801338.git.viresh.kumar@linaro.org>
 <56FA0039.6030007@samsung.com>
 <20160329041827.GA25424@vireshk-i7>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f53.google.com ([209.85.220.53]:35459 "EHLO
	mail-pa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750742AbcC2ET0 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 29 Mar 2016 00:19:26 -0400
Received: by mail-pa0-f53.google.com with SMTP id td3so4235919pab.2
        for <linux-pm@vger.kernel.org>; Mon, 28 Mar 2016 21:19:26 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20160329041827.GA25424@vireshk-i7>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, arnd.bergmann@linaro.org, Kukjin Kim <kgene@kernel.org>, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, kgene.kim@samsung.com, xf@rock-chips.com, heiko@sntech.de, mmcclint@codeaurora.org, linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org

On 29-03-16, 09:48, Viresh Kumar wrote:
> On 29-03-16, 13:10, Krzysztof Kozlowski wrote:
> > On 24.03.2016 15:40, Viresh Kumar wrote:
> > > The cpufreq-dt-platdev driver supports creation of cpufreq-dt platform
> > > device now, reuse that and remove similar code from platform code.
> > > 
> > > Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> > > ---
> > >  arch/arm/mach-exynos/exynos.c        | 25 -------------------------
> > >  drivers/cpufreq/cpufreq-dt-platdev.c |  5 +++++
> > >  2 files changed, 5 insertions(+), 25 deletions(-)
> > 
> > Looks fine to me... except that it is a little bit outdated. Please
> > rebase on v4.6-rc1 because Bartlomiej added support for cpufreq @Exynos542x.
> 
> Yeah, I know. I already have the updated version.

Here it is:

From: Viresh Kumar <viresh.kumar@linaro.org>
Date: Thu, 24 Mar 2016 12:04:10 +0530
Subject: [PATCH] cpufreq: exynos: Use generic platdev driver

The cpufreq-dt-platdev driver supports creation of cpufreq-dt platform
device now, reuse that and remove similar code from platform code.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 arch/arm/mach-exynos/exynos.c        | 29 -----------------------------
 drivers/cpufreq/cpufreq-dt-platdev.c |  9 +++++++++
 2 files changed, 9 insertions(+), 29 deletions(-)

diff --git a/arch/arm/mach-exynos/exynos.c b/arch/arm/mach-exynos/exynos.c
index bbf51a46f772..4d3b056fd786 100644
--- a/arch/arm/mach-exynos/exynos.c
+++ b/arch/arm/mach-exynos/exynos.c
@@ -213,33 +213,6 @@ static void __init exynos_init_irq(void)
 	exynos_map_pmu();
 }
 
-static const struct of_device_id exynos_cpufreq_matches[] = {
-	{ .compatible = "samsung,exynos3250", .data = "cpufreq-dt" },
-	{ .compatible = "samsung,exynos4210", .data = "cpufreq-dt" },
-	{ .compatible = "samsung,exynos4212", .data = "cpufreq-dt" },
-	{ .compatible = "samsung,exynos4412", .data = "cpufreq-dt" },
-	{ .compatible = "samsung,exynos5250", .data = "cpufreq-dt" },
-#ifndef CONFIG_BL_SWITCHER
-	{ .compatible = "samsung,exynos5420", .data = "cpufreq-dt" },
-	{ .compatible = "samsung,exynos5800", .data = "cpufreq-dt" },
-#endif
-	{ /* sentinel */ }
-};
-
-static void __init exynos_cpufreq_init(void)
-{
-	struct device_node *root = of_find_node_by_path("/");
-	const struct of_device_id *match;
-
-	match = of_match_node(exynos_cpufreq_matches, root);
-	if (!match) {
-		platform_device_register_simple("exynos-cpufreq", -1, NULL, 0);
-		return;
-	}
-
-	platform_device_register_simple(match->data, -1, NULL, 0);
-}
-
 static void __init exynos_dt_machine_init(void)
 {
 	/*
@@ -262,8 +235,6 @@ static void __init exynos_dt_machine_init(void)
 	    of_machine_is_compatible("samsung,exynos5250"))
 		platform_device_register(&exynos_cpuidle);
 
-	exynos_cpufreq_init();
-
 	of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
 }
 
diff --git a/drivers/cpufreq/cpufreq-dt-platdev.c b/drivers/cpufreq/cpufreq-dt-platdev.c
index 18b81724ca0b..f85d1ab5d621 100644
--- a/drivers/cpufreq/cpufreq-dt-platdev.c
+++ b/drivers/cpufreq/cpufreq-dt-platdev.c
@@ -20,6 +20,15 @@ struct cpufreq_dt_compat {
 };
 
 static struct cpufreq_dt_compat compat[] = {
+	{ "samsung,exynos3250",		NULL,		0 },
+	{ "samsung,exynos4210",		NULL,		0 },
+	{ "samsung,exynos4212",		NULL,		0 },
+	{ "samsung,exynos4412",		NULL,		0 },
+	{ "samsung,exynos5250",		NULL,		0 },
+#ifndef CONFIG_BL_SWITCHER
+	{ "samsung,exynos5420",		NULL, 		0 },
+	{ "samsung,exynos5800",		NULL, 		0 },
+#endif
 };
 
 static int __init cpufreq_dt_platdev_init(void)


-- 
viresh
