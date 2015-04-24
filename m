From: ahaslam@baylibre.com
Subject: [RFC v5 4/8] ARM: exynos: pm: Convert to multiple states
Date: Fri, 24 Apr 2015 19:35:20 +0200
Message-ID: <1429896924-21540-5-git-send-email-ahaslam@baylibre.com>
References: <1429896924-21540-1-git-send-email-ahaslam@baylibre.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wg0-f41.google.com ([74.125.82.41]:36674 "EHLO
	mail-wg0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S966672AbbDXRfs (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 24 Apr 2015 13:35:48 -0400
Received: by wgen6 with SMTP id n6so57895507wge.3
        for <linux-pm@vger.kernel.org>; Fri, 24 Apr 2015 10:35:47 -0700 (PDT)
In-Reply-To: <1429896924-21540-1-git-send-email-ahaslam@baylibre.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: ulf.hansson@linaro.org, khilman@linaro.org, k.kozlowski.k@gmail.com, geert@linux-m68k.org, rjw@rjwysocki.net
Cc: bcousson@baylibre.com, linux-pm@vger.kernel.org, Axel Haslam <ahaslam@baylibre.com>

From: Axel Haslam <ahaslam@baylibre.com>

The generic power domain framework added structure changes
to support multiple intermediate states when powering off a domain.

These changes are needed to prevent compilation breaks with
the new structures.

Signed-off-by: Axel Haslam <ahaslam@baylibre.com>
---
 arch/arm/mach-exynos/pm_domains.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/mach-exynos/pm_domains.c b/arch/arm/mach-exynos/pm_domains.c
index 37266a8..87e67df 100644
--- a/arch/arm/mach-exynos/pm_domains.c
+++ b/arch/arm/mach-exynos/pm_domains.c
@@ -105,6 +105,12 @@ static int exynos_pd_power_off(struct generic_pm_domain *domain)
 	return exynos_pd_power(domain, false);
 }
 
+struct genpd_power_state exynos_pm_states[] = {
+	{
+		.name = "OFF",
+	}
+};
+
 static __init int exynos4_pm_init_power_domain(void)
 {
 	struct platform_device *pdev;
@@ -130,6 +136,8 @@ static __init int exynos4_pm_init_power_domain(void)
 		pd->base = of_iomap(np, 0);
 		pd->pd.power_off = exynos_pd_power_off;
 		pd->pd.power_on = exynos_pd_power_on;
+		pd->pd.states = exynos_pm_states;
+		pd->pd.state_count = ARRAY_SIZE(exynos_pm_states);
 
 		pd->oscclk = clk_get(dev, "oscclk");
 		if (IS_ERR(pd->oscclk))
-- 
1.9.1

