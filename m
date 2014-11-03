From: Amit Daniel Kachhap <amit.daniel@samsung.com>
Subject: [PATCH 07/12] soc: samsung: pm_domain: Use compatible name for power
 domain name
Date: Mon, 03 Nov 2014 09:23:05 +0530
Message-ID: <1414986790-11940-8-git-send-email-amit.daniel@samsung.com>
References: <1414986790-11940-1-git-send-email-amit.daniel@samsung.com>
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-reply-to: <1414986790-11940-1-git-send-email-amit.daniel@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, linux-pm@vger.kernel.org
Cc: kgene.kim@samsung.com, pankaj.dubey@samsung.com, Amit Daniel Kachhap <amit.daniel@samsung.com>
List-Id: linux-pm@vger.kernel.org

This patch adds support for second optional compatible complate name. If
this compatible name is present then this name will be used to create
the Power Domain and not the DT node name.
The benefit of this approach is to hook the notifier to the correct
Power Domain.

Cc: Kukjin Kim <kgene.kim@samsung.com>
Reviewed-by: Pankaj Dubey <pankaj.dubey@samsung.com>
Signed-off-by: Amit Daniel Kachhap <amit.daniel@samsung.com>
---
 .../bindings/arm/exynos/power_domain.txt           |    8 ++++++++
 drivers/soc/samsung/pm_domains.c                   |    7 ++++++-
 2 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/arm/exynos/power_domain.txt b/Documentation/devicetree/bindings/arm/exynos/power_domain.txt
index 5599017..7250a5c 100644
--- a/Documentation/devicetree/bindings/arm/exynos/power_domain.txt
+++ b/Documentation/devicetree/bindings/arm/exynos/power_domain.txt
@@ -12,6 +12,8 @@ Required Properties:
     must be 0.
 
 Optional Properties:
+- compatible: This is a second compatible name and gives the complete Power Domain
+	name like "samsung,exynos7-pd-mfc"
 - clocks: List of clock handles. The parent clocks of the input clocks to the
 	devices in this power domain are set to oscclk before power gating
 	and restored back after powering on a domain. This is required for
@@ -43,5 +45,11 @@ Example:
 		#power-domain-cells = <0>;
 	};
 
+	mfc_pd: power-domain@10044060 {
+		compatible = "samsung,exynos4210-pd", "samsung,exynos7-pd-mfc";
+		pd-offset = <0x4060>;
+		#power-domain-cells = <0>;
+	};
+
 See Documentation/devicetree/bindings/power/power_domain.txt for description
 of consumer-side bindings.
diff --git a/drivers/soc/samsung/pm_domains.c b/drivers/soc/samsung/pm_domains.c
index 923eb57..e63d129 100644
--- a/drivers/soc/samsung/pm_domains.c
+++ b/drivers/soc/samsung/pm_domains.c
@@ -124,12 +124,17 @@ static int exynos_power_domain_probe(struct platform_device *pdev)
 	for_each_compatible_node(np, NULL, "samsung,exynos4210-pd") {
 		struct exynos_pm_domain *pd;
 		int on, i;
+		const char *name;
 
 		pd = devm_kzalloc(&pdev->dev, sizeof(*pd), GFP_KERNEL);
 		if (!pd)
 			return -ENOMEM;
 
-		pd->pd.name = kstrdup(np->name, GFP_KERNEL);
+		if (of_property_read_string_index(np, "compatible", 1, &name)) {
+			/* Second entry not found, use the node name*/
+			name = np->name;
+		}
+		pd->pd.name = kstrdup(name, GFP_KERNEL);
 		pd->name = pd->pd.name;
 		if (of_property_read_u32(np, "pd-offset", &offset)) {
 			pr_err("%s: failed to find offset for power domain\n",
-- 
1.7.9.5
