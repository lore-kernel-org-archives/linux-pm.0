From: Amit Daniel Kachhap <amit.daniel@samsung.com>
Subject: [PATCH RFC v2 05/12] soc: samsung: pm_domain: Use unique compatible
 name for power domain
Date: Mon, 24 Nov 2014 18:34:09 +0530
Message-ID: <1416834256-11225-5-git-send-email-amit.daniel@samsung.com>
References: <1416833572-6880-1-git-send-email-amit.daniel@samsung.com>
 <1416834256-11225-1-git-send-email-amit.daniel@samsung.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:28071 "EHLO
	mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751530AbaKXNPe (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 24 Nov 2014 08:15:34 -0500
In-reply-to: <1416834256-11225-1-git-send-email-amit.daniel@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org
Cc: kgene.kim@samsung.com, linux-kernel@vger.kernel.org, s.nawrocki@samsung.com, pankaj.dubey@samsung.com, ulf.hansson@linaro.org, khilman@kernel.org, linux-pm@vger.kernel.org, geert@linux-m68k.org, rjw@rjwysocki.net, devicetree@vger.kernel.org, Amit Daniel Kachhap <amit.daniel@samsung.com>

This patch adds support for second optional compatible complate name. If
this compatible name is present then this name will be used to create
the Power Domain and not the DT node name. This will be useful to carry
out any power domain specific changes in the PD on/off handlers for new
SoCs.
This change will not affect the existing DT bindings.

Cc: Kukjin Kim <kgene.kim@samsung.com>
Signed-off-by: Amit Daniel Kachhap <amit.daniel@samsung.com>
---
 .../bindings/arm/exynos/power_domain.txt           |    8 ++++++++
 drivers/soc/samsung/pm_domains.c                   |   10 +++++++++-
 2 files changed, 17 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/arm/exynos/power_domain.txt b/Documentation/devicetree/bindings/arm/exynos/power_domain.txt
index abde1ea..00ebda1 100644
--- a/Documentation/devicetree/bindings/arm/exynos/power_domain.txt
+++ b/Documentation/devicetree/bindings/arm/exynos/power_domain.txt
@@ -12,6 +12,8 @@ Required Properties:
     must be 0.
 
 Optional Properties:
+- compatible: This is a second compatible name and gives the complete Power
+	Domain name like "samsung,exynos7-pd-mfc".
 - clocks: List of clock handles. The parent clocks of the input clocks to the
 	devices in this power domain are set to oscclk before power gating
 	and restored back after powering on a domain. This is required for
@@ -43,5 +45,11 @@ Example:
 		#power-domain-cells = <0>;
 	};
 
+	mfc_pd: power-domain@10044060 {
+		compatible = "samsung,exynos4210-pd", "samsung,exynos7-pd-mfc";
+		reg = <0x10044060 0x20>;
+		#power-domain-cells = <0>;
+	};
+
 See Documentation/devicetree/bindings/power/power_domain.txt for description
 of consumer-side bindings.
diff --git a/drivers/soc/samsung/pm_domains.c b/drivers/soc/samsung/pm_domains.c
index 69bc8b1..f4f2a6c 100644
--- a/drivers/soc/samsung/pm_domains.c
+++ b/drivers/soc/samsung/pm_domains.c
@@ -120,12 +120,20 @@ static int exynos_power_domain_probe(struct platform_device *pdev)
 		struct exynos_pm_domain *pd;
 		int i;
 		bool on;
+		const char *name;
 
 		pd = devm_kzalloc(&pdev->dev, sizeof(*pd), GFP_KERNEL);
 		if (!pd)
 			return -ENOMEM;
 
-		pd->pd.name = kstrdup(np->name, GFP_KERNEL);
+		/*
+		 * Check if second compatible name found then use as power
+		 * domain name or else use the DT node name as before.
+		 */
+		if (of_property_read_string_index(np, "compatible", 1, &name))
+			name = np->name;
+
+		pd->pd.name = kstrdup(name, GFP_KERNEL);
 		pd->name = pd->pd.name;
 		pd->base = of_iomap(np, 0);
 		pd->pd.power_off = exynos_pd_power_off;
-- 
1.7.9.5

