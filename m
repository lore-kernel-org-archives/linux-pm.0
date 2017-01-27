From: Marek Szyprowski <m.szyprowski@samsung.com>
Subject: [PATCH 2/4] soc: samsung: pm_domains: Remove unused name field
Date: Fri, 27 Jan 2017 11:47:50 +0100
Message-ID: <1485514072-29502-3-git-send-email-m.szyprowski@samsung.com>
References: <1485514072-29502-1-git-send-email-m.szyprowski@samsung.com>
 <CGME20170127104801eucas1p2287962bae474ca786644de4ad6a11f57@eucas1p2.samsung.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout1.w1.samsung.com ([210.118.77.11]:14722 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932673AbdA0KsG (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 27 Jan 2017 05:48:06 -0500
In-reply-to: <1485514072-29502-1-git-send-email-m.szyprowski@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-samsung-soc@vger.kernel.org, linux-pm@vger.kernel.org
Cc: Marek Szyprowski <m.szyprowski@samsung.com>, Sylwester Nawrocki <s.nawrocki@samsung.com>, Krzysztof Kozlowski <krzk@kernel.org>, Javier Martinez Canillas <javier@osg.samsung.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>, Inki Dae <inki.dae@samsung.com>

Name is now in generic pm domain structure, so there is no need to
duplicate it in private data.

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
 drivers/soc/samsung/pm_domains.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/soc/samsung/pm_domains.c b/drivers/soc/samsung/pm_domains.c
index c33196087e9f..00e32772655a 100644
--- a/drivers/soc/samsung/pm_domains.c
+++ b/drivers/soc/samsung/pm_domains.c
@@ -35,7 +35,6 @@ struct exynos_pm_domain_config {
  */
 struct exynos_pm_domain {
 	void __iomem *base;
-	char const *name;
 	bool is_off;
 	struct generic_pm_domain pd;
 	struct clk *oscclk;
@@ -70,7 +69,7 @@ static int exynos_pd_power(struct generic_pm_domain *domain, bool power_on)
 			pd->pclk[i] = clk_get_parent(pd->clk[i]);
 			if (clk_set_parent(pd->clk[i], pd->oscclk))
 				pr_err("%s: error setting oscclk as parent to clock %d\n",
-						pd->name, i);
+						domain->name, i);
 		}
 	}
 
@@ -101,7 +100,7 @@ static int exynos_pd_power(struct generic_pm_domain *domain, bool power_on)
 				continue; /* Skip on first power up */
 			if (clk_set_parent(pd->clk[i], pd->pclk[i]))
 				pr_err("%s: error setting parent to clock%d\n",
-						pd->name, i);
+						domain->name, i);
 		}
 	}
 
@@ -170,7 +169,6 @@ static __init int exynos4_pm_init_power_domain(void)
 			return -ENOMEM;
 		}
 
-		pd->name = pd->pd.name;
 		pd->base = of_iomap(np, 0);
 		if (!pd->base) {
 			pr_warn("%s: failed to map memory\n", __func__);
-- 
1.9.1

