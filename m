From: Jon Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Subject: [RFC PATCH 2/8] ARM: EXYNOS: Remove calls to of_genpd_get_from_provider()
Date: Fri, 4 Mar 2016 11:23:48 +0000
Message-ID: <1457090634-14785-3-git-send-email-jonathanh@nvidia.com>
References: <1457090634-14785-1-git-send-email-jonathanh@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1457090634-14785-1-git-send-email-jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, Kevin Hilman <khilman-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Kukjin Kim <kgene-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Krzysztof Kozlowski <k.kozlowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Alexander Aring <alex.aring-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Eric Anholt <eric-WhKQ6XTQaPysTnJN9+BGXg@public.gmane.org>, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Jon Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

Update the EXYNOS PM domain code to use the of_genpd_add_subdomain()
and remove any calls to of_genpd_get_from_provider().

Signed-off-by: Jon Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
---
 arch/arm/mach-exynos/pm_domains.c | 23 ++++++++---------------
 1 file changed, 8 insertions(+), 15 deletions(-)

diff --git a/arch/arm/mach-exynos/pm_domains.c b/arch/arm/mach-exynos/pm_domains.c
index 7c21760f590f..871f72a292ae 100644
--- a/arch/arm/mach-exynos/pm_domains.c
+++ b/arch/arm/mach-exynos/pm_domains.c
@@ -193,29 +193,22 @@ no_clk:
 
 	/* Assign the child power domains to their parents */
 	for_each_compatible_node(np, NULL, "samsung,exynos4210-pd") {
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
