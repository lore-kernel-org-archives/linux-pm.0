From: Jon Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH V2 02/10] ARM: EXYNOS: Remove calls to of_genpd_get_from_provider()
Date: Mon, 12 Sep 2016 12:01:06 +0100
Message-ID: <1473678074-15126-3-git-send-email-jonathanh@nvidia.com>
References: <1473678074-15126-1-git-send-email-jonathanh@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1473678074-15126-1-git-send-email-jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, Kevin Hilman <khilman-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Kukjin Kim <kgene-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Krzysztof Kozlowski <k.kozlowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Alexander Aring <alex.aring-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Eric Anholt <eric-WhKQ6XTQaPysTnJN9+BGXg@public.gmane.org>, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Jon Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

Update the EXYNOS PM domain code to use the of_genpd_add_subdomain()
and remove any calls to of_genpd_get_from_provider().

Signed-off-by: Jon Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Reviewed-by: Krzysztof Kozlowski <k.kozlowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Acked-by: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
---
 drivers/soc/samsung/pm_domains.c | 23 ++++++++---------------
 1 file changed, 8 insertions(+), 15 deletions(-)

diff --git a/drivers/soc/samsung/pm_domains.c b/drivers/soc/samsung/pm_domains.c
index 4822346aadc6..7112004b8032 100644
--- a/drivers/soc/samsung/pm_domains.c
+++ b/drivers/soc/samsung/pm_domains.c
@@ -215,29 +215,22 @@ static __init int exynos4_pm_init_power_domain(void)
 
 	/* Assign the child power domains to their parents */
 	for_each_matching_node(np, exynos_pm_domain_of_match) {
-		struct generic_pm_domain *child_domain, *parent_domain;
-		struct of_phandle_args args;
+		struct of_phandle_args child, parent;
 
-		args.np = np;
-		args.args_count = 0;
-		child_domain = of_genpd_get_from_provider(&args);
-		if (IS_ERR(child_domain))
-			continue;
+		child.np = np;
+		child.args_count = 0;
 
 		if (of_parse_phandle_with_args(np, "power-domains",
-					 "#power-domain-cells", 0, &args) != 0)
-			continue;
-
-		parent_domain = of_genpd_get_from_provider(&args);
-		if (IS_ERR(parent_domain))
+					       "#power-domain-cells", 0,
+					       &parent) != 0)
 			continue;
 
-		if (pm_genpd_add_subdomain(parent_domain, child_domain))
+		if (of_genpd_add_subdomain(&parent, &child))
 			pr_warn("%s failed to add subdomain: %s\n",
-				parent_domain->name, child_domain->name);
+				parent.np->name, child.np->name);
 		else
 			pr_info("%s has as child subdomain: %s.\n",
-				parent_domain->name, child_domain->name);
+				parent.np->name, child.np->name);
 	}
 
 	return 0;
-- 
2.1.4
