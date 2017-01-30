From: Marek Szyprowski <m.szyprowski@samsung.com>
Subject: [PATCH v3 2/5] soc: samsung: pm_domains: Remove unused name field
Date: Mon, 30 Jan 2017 13:18:57 +0100
Message-ID: <1485778740-30337-3-git-send-email-m.szyprowski@samsung.com>
References: <1485778740-30337-1-git-send-email-m.szyprowski@samsung.com>
 <CGME20170130121913eucas1p187c10b4ad4b3551c0100b492374f42bb@eucas1p1.samsung.com>
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-reply-to: <1485778740-30337-1-git-send-email-m.szyprowski@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: linux-samsung-soc@vger.kernel.org, linux-pm@vger.kernel.org
Cc: Marek Szyprowski <m.szyprowski@samsung.com>, Sylwester Nawrocki <s.nawrocki@samsung.com>, Krzysztof Kozlowski <krzk@kernel.org>, Javier Martinez Canillas <javier@osg.samsung.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>, Inki Dae <inki.dae@samsung.com>
List-Id: linux-pm@vger.kernel.org

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
