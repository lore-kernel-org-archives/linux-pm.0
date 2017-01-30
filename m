From: Marek Szyprowski <m.szyprowski@samsung.com>
Subject: [PATCH v3 4/5] soc: samsung: pm_domains: Read domain name from the new
 label property
Date: Mon, 30 Jan 2017 13:18:59 +0100
Message-ID: <1485778740-30337-5-git-send-email-m.szyprowski@samsung.com>
References: <1485778740-30337-1-git-send-email-m.szyprowski@samsung.com>
 <CGME20170130121915eucas1p23aa4f4be912bcd64f9521f6e6b51132f@eucas1p2.samsung.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout1.w1.samsung.com ([210.118.77.11]:23731 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753292AbdA3Mbe (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 30 Jan 2017 07:31:34 -0500
In-reply-to: <1485778740-30337-1-git-send-email-m.szyprowski@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-samsung-soc@vger.kernel.org, linux-pm@vger.kernel.org
Cc: Marek Szyprowski <m.szyprowski@samsung.com>, Sylwester Nawrocki <s.nawrocki@samsung.com>, Krzysztof Kozlowski <krzk@kernel.org>, Javier Martinez Canillas <javier@osg.samsung.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>, Inki Dae <inki.dae@samsung.com>, devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>

Device tree nodes for each power domain should use generic "power-domain"
name, so using it as a domain name doesn't give much benefits. This patch
adds support for human readable names defined in 'label' property. Such
names are visible to userspace and makes debugging much easier. When no
'label' property is found, driver keeps using the name constructed from
full node name.

Suggested-by: Krzysztof Kozlowski <krzk@kernel.org>
Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
 Documentation/devicetree/bindings/power/pd-samsung.txt |  4 ++++
 drivers/soc/samsung/pm_domains.c                       | 12 ++++++++++--
 2 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/power/pd-samsung.txt b/Documentation/devicetree/bindings/power/pd-samsung.txt
index fb08c8d62733..549f7dee9b9d 100644
--- a/Documentation/devicetree/bindings/power/pd-samsung.txt
+++ b/Documentation/devicetree/bindings/power/pd-samsung.txt
@@ -13,6 +13,8 @@ Required Properties:
     must be 0.
 
 Optional Properties:
+- label: Human readable string with domain name. Will be visible in userspace
+	to let user to distinguish between multiple domains in SoC.
 - clocks: List of clock handles. The parent clocks of the input clocks to the
 	devices in this power domain are set to oscclk before power gating
 	and restored back after powering on a domain. This is required for
@@ -39,6 +41,7 @@ Example:
 		compatible = "samsung,exynos4210-pd";
 		reg = <0x10023C00 0x10>;
 		#power-domain-cells = <0>;
+		label = "LCD0";
 	};
 
 	mfc_pd: power-domain@10044060 {
@@ -47,6 +50,7 @@ Example:
 		clocks = <&clock CLK_FIN_PLL>, <&clock CLK_MOUT_USER_ACLK333>;
 		clock-names = "oscclk", "clk0";
 		#power-domain-cells = <0>;
+		label = "MFC";
 	};
 
 See Documentation/devicetree/bindings/power/power_domain.txt for description
diff --git a/drivers/soc/samsung/pm_domains.c b/drivers/soc/samsung/pm_domains.c
index 5a0a46bcbe18..a6a5d807cc2b 100644
--- a/drivers/soc/samsung/pm_domains.c
+++ b/drivers/soc/samsung/pm_domains.c
@@ -142,6 +142,15 @@ static int exynos_pd_power_off(struct generic_pm_domain *domain)
 	{ },
 };
 
+static __init const char *exynos_get_domain_name(struct device_node *node)
+{
+	const char *name;
+
+	if (of_property_read_string(node, "label", &name) < 0)
+		name = strrchr(node->full_name, '/') + 1;
+	return kstrdup_const(name, GFP_KERNEL);
+}
+
 static __init int exynos4_pm_init_power_domain(void)
 {
 	struct device_node *np;
@@ -159,8 +168,7 @@ static __init int exynos4_pm_init_power_domain(void)
 			of_node_put(np);
 			return -ENOMEM;
 		}
-		pd->pd.name = kstrdup_const(strrchr(np->full_name, '/') + 1,
-					    GFP_KERNEL);
+		pd->pd.name = exynos_get_domain_name(np);
 		if (!pd->pd.name) {
 			kfree(pd);
 			of_node_put(np);
-- 
1.9.1

