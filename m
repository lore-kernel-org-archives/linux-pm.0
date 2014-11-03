From: Amit Daniel Kachhap <amit.daniel@samsung.com>
Subject: [PATCH 09/12] soc: samsung: pm_domain: Add support for parent power
 domain
Date: Mon, 03 Nov 2014 09:23:07 +0530
Message-ID: <1414986790-11940-10-git-send-email-amit.daniel@samsung.com>
References: <1414986790-11940-1-git-send-email-amit.daniel@samsung.com>
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-reply-to: <1414986790-11940-1-git-send-email-amit.daniel@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, linux-pm@vger.kernel.org
Cc: kgene.kim@samsung.com, pankaj.dubey@samsung.com, Amit Daniel Kachhap <amit.daniel@samsung.com>
List-Id: linux-pm@vger.kernel.org

This patch adds supports for parent power domain. This will ensure
invoking of parent/child power domain on/off in a correct sequence.
In exynos7 SOC's, power domain controllers have parent and child
hierarchy.

Cc: Kukjin Kim <kgene.kim@samsung.com>
Reviewed-by: Pankaj Dubey <pankaj.dubey@samsung.com>
Signed-off-by: Amit Daniel Kachhap <amit.daniel@samsung.com>
---
 .../bindings/arm/exynos/power_domain.txt           |    2 +
 drivers/soc/samsung/pm_domains.c                   |   42 +++++++++++++++++++-
 2 files changed, 43 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/arm/exynos/power_domain.txt b/Documentation/devicetree/bindings/arm/exynos/power_domain.txt
index 07e4ffe..07752a4 100644
--- a/Documentation/devicetree/bindings/arm/exynos/power_domain.txt
+++ b/Documentation/devicetree/bindings/arm/exynos/power_domain.txt
@@ -26,6 +26,7 @@ Optional Properties:
 		are supported currently.
 - pd-power-conf: This optional parameter provides the local power configuration
 	value for the power domain.
+- parent: phandle of parent power domain.
 
 Node of a device using power domains must have a samsung,power-domain property
 defined with a phandle to respective power domain.
@@ -51,6 +52,7 @@ Example:
 		compatible = "samsung,exynos4210-pd", "samsung,exynos7-pd-mfc";
 		pd-offset = <0x4060>;
 		pd-power-conf = <0xf>;
+		parent = <&pd_top>;
 		#power-domain-cells = <0>;
 	};
 
diff --git a/drivers/soc/samsung/pm_domains.c b/drivers/soc/samsung/pm_domains.c
index 84a3f1f..f14f182 100644
--- a/drivers/soc/samsung/pm_domains.c
+++ b/drivers/soc/samsung/pm_domains.c
@@ -26,7 +26,7 @@
 
 #define INT_LOCAL_PWR_EN	0x7
 #define MAX_CLK_PER_DOMAIN	4
-
+#define MAX_PARENT_POWER_DOMAIN	10
 /*
  * Exynos specific wrapper around the generic power domain
  */
@@ -179,7 +179,47 @@ no_clk:
 		pm_genpd_init(&pd->pd, NULL, !on);
 		of_genpd_add_provider_simple(np, &pd->pd);
 	}
+	/* Assign the child power domains to their parents */
+	for_each_compatible_node(np, NULL, "samsung,exynos4210-pd") {
+		struct device_node *parent_np;
+		int i;
+		struct generic_pm_domain *child_domain, *parent_domain;
+		const char *name;
+
+		if (of_property_read_string_index(np, "compatible", 1,
+					&name)) {
+			/* Second entry not found, use the node name*/
+			name = np->name;
+		}
 
+		child_domain = pm_genpd_lookup_name(name);
+		if (!child_domain)
+			continue;
+		/* search parents in device tree */
+		for (i = 0; i < MAX_PARENT_POWER_DOMAIN; i++) {
+			parent_np = of_parse_phandle(np, "parent", i);
+			if (!parent_np)
+				break;
+
+			if (of_property_read_string_index(parent_np,
+						"compatible", 1, &name)) {
+				/* Second entry not found, use the node name*/
+				name = parent_np->name;
+			}
+
+			parent_domain = pm_genpd_lookup_name(name);
+			if (!parent_domain)
+				break;
+			if (pm_genpd_add_subdomain(parent_domain, child_domain))
+				pr_err("%s failed to add subdomain: %s\n",
+						parent_domain->name,
+						child_domain->name);
+			else
+				pr_info("%s has as child subdomain: %s.\n",
+						parent_domain->name,
+						child_domain->name);
+		}
+	}
 	return 0;
 }
 
-- 
1.7.9.5
