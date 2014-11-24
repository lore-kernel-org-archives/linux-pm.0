From: Amit Daniel Kachhap <amit.daniel@samsung.com>
Subject: [PATCH RFC v2 08/12] soc: samsung: pm_domain: Add support for parent
 power domain
Date: Mon, 24 Nov 2014 18:34:12 +0530
Message-ID: <1416834256-11225-8-git-send-email-amit.daniel@samsung.com>
References: <1416833572-6880-1-git-send-email-amit.daniel@samsung.com>
 <1416834256-11225-1-git-send-email-amit.daniel@samsung.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:14053 "EHLO
	mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750871AbaKXNSj (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 24 Nov 2014 08:18:39 -0500
In-reply-to: <1416834256-11225-1-git-send-email-amit.daniel@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org
Cc: kgene.kim@samsung.com, linux-kernel@vger.kernel.org, s.nawrocki@samsung.com, pankaj.dubey@samsung.com, ulf.hansson@linaro.org, khilman@kernel.org, linux-pm@vger.kernel.org, geert@linux-m68k.org, rjw@rjwysocki.net, devicetree@vger.kernel.org, Amit Daniel Kachhap <amit.daniel@samsung.com>

This patch adds supports for parent power domain. This will ensure
invoking of parent/child power domain on/off in a correct sequence.
In exynos7 SOC's, power domain controllers have parent and child
hierarchy.

Cc: Kukjin Kim <kgene.kim@samsung.com>
Signed-off-by: Amit Daniel Kachhap <amit.daniel@samsung.com>
---
 .../bindings/arm/exynos/power_domain.txt           |    2 +
 drivers/soc/samsung/pm_domains.c                   |   43 +++++++++++++++++++-
 2 files changed, 44 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/arm/exynos/power_domain.txt b/Documentation/devicetree/bindings/arm/exynos/power_domain.txt
index 00ebda1..0160bdc 100644
--- a/Documentation/devicetree/bindings/arm/exynos/power_domain.txt
+++ b/Documentation/devicetree/bindings/arm/exynos/power_domain.txt
@@ -24,6 +24,7 @@ Optional Properties:
 	- pclkN, clkN: Pairs of parent of input clock and input clock to the
 		devices in this power domain. Maximum of 4 pairs (N = 0 to 3)
 		are supported currently.
+- parents: phandle of parent power domains.
 
 Node of a device using power domains must have a samsung,power-domain property
 defined with a phandle to respective power domain.
@@ -48,6 +49,7 @@ Example:
 	mfc_pd: power-domain@10044060 {
 		compatible = "samsung,exynos4210-pd", "samsung,exynos7-pd-mfc";
 		reg = <0x10044060 0x20>;
+		parents = <&pd_top>;
 		#power-domain-cells = <0>;
 	};
 
diff --git a/drivers/soc/samsung/pm_domains.c b/drivers/soc/samsung/pm_domains.c
index f4f2a6c..89e2fd5 100644
--- a/drivers/soc/samsung/pm_domains.c
+++ b/drivers/soc/samsung/pm_domains.c
@@ -25,10 +25,10 @@
 #include <linux/soc/samsung/exynos-pmu.h>
 
 #define MAX_CLK_PER_DOMAIN	4
+#define MAX_PARENT_POWER_DOMAIN	10
 
 static struct exynos_pmu_pd_ops *pd_ops;
 
-
 /*
  * Exynos specific wrapper around the generic power domain
  */
@@ -169,6 +169,47 @@ no_clk:
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
+
+		child_domain = pm_genpd_lookup_name(name);
+		if (!child_domain)
+			continue;
+		/* search parents in device tree */
+		for (i = 0; i < MAX_PARENT_POWER_DOMAIN; i++) {
+			parent_np = of_parse_phandle(np, "parents", i);
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
+				pr_warn("%s failed to add subdomain: %s\n",
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

