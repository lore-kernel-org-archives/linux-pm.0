From: ahaslam@baylibre.com
Subject: [RFC v4 4/8] ARM: exynos: pm: Convert to multiple states
Date: Wed, 22 Apr 2015 11:45:31 +0200
Message-ID: <1429695935-15815-5-git-send-email-ahaslam@baylibre.com>
References: <1429695935-15815-1-git-send-email-ahaslam@baylibre.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wg0-f52.google.com ([74.125.82.52]:35740 "EHLO
	mail-wg0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965019AbbDVJqe (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 22 Apr 2015 05:46:34 -0400
Received: by wgyo15 with SMTP id o15so240682061wgy.2
        for <linux-pm@vger.kernel.org>; Wed, 22 Apr 2015 02:46:32 -0700 (PDT)
In-Reply-To: <1429695935-15815-1-git-send-email-ahaslam@baylibre.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: ulf.hansson@linaro.org, khilman@linaro.org, k.kozlowski.k@gmail.com, rjw@rjwysocki.net
Cc: bcousson@baylibre.com, linux-pm@vger.kernel.org, Axel Haslam <ahaslam@baylibre.com>

From: Axel Haslam <ahaslam@baylibre.com>

The generic power domain framework added structure changes
to support multiple intermediate states when powering off a domain.

These changes are needed to prevent compilation breaks with
the new structures.

Signed-off-by: Axel Haslam <ahaslam@baylibre.com>
---
 arch/arm/mach-exynos/pm_domains.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-exynos/pm_domains.c b/arch/arm/mach-exynos/pm_domains.c
index 37266a8..01fc620 100644
--- a/arch/arm/mach-exynos/pm_domains.c
+++ b/arch/arm/mach-exynos/pm_domains.c
@@ -128,8 +128,10 @@ static __init int exynos4_pm_init_power_domain(void)
 		pd->pd.name = kstrdup(np->name, GFP_KERNEL);
 		pd->name = pd->pd.name;
 		pd->base = of_iomap(np, 0);
-		pd->pd.power_off = exynos_pd_power_off;
-		pd->pd.power_on = exynos_pd_power_on;
+		pd->pd.states[0].power_off = exynos_pd_power_off;
+		pd->pd.states[0].power_on = exynos_pd_power_on;
+		pd->pd.states[0].name = "off";
+		pd->pd.state_count = 1;
 
 		pd->oscclk = clk_get(dev, "oscclk");
 		if (IS_ERR(pd->oscclk))
-- 
1.9.1

