From: Jon Hunter <jonathanh@nvidia.com>
Subject: [PATCH 02/10] ARM: EXYNOS: Remove calls to
 of_genpd_get_from_provider()
Date: Tue, 16 Aug 2016 10:49:28 +0100
Message-ID: <1471340976-5379-3-git-send-email-jonathanh@nvidia.com>
References: <1471340976-5379-1-git-send-email-jonathanh@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1471340976-5379-1-git-send-email-jonathanh@nvidia.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Kevin Hilman <khilman@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: Krzysztof Kozlowski <k.kozlowski@samsung.com>, linux-pm@vger.kernel.org, Alexander Aring <alex.aring@gmail.com>, Jon Hunter <jonathanh@nvidia.com>, Eric Anholt <eric@anholt.net>, Thierry Reding <thierry.reding@gmail.com>, Kukjin Kim <kgene@kernel.org>, linux-tegra@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

Update the EXYNOS PM domain code to use the of_genpd_add_subdomain()
and remove any calls to of_genpd_get_from_provider().

Signed-off-by: Jon Hunter <jonathanh@nvidia.com>
---
 drivers/soc/samsung/pm_domains.c | 23 ++++++++---------------
 1 file changed, 8 insertions(+), 15 deletions(-)

diff --git a/drivers/soc/samsung/pm_domains.c b/drivers/soc/samsung/pm_domains.c
index 4822346aadc6..7112004b8032 100644
--- a/drivers/soc/samsung/pm_domains.c
+++ b/drivers/soc/samsung/pm_domains.c
@@ -215,29 +215,22 @@ no_clk:
 
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
