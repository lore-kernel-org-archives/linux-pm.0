From: ahaslam@baylibre.com
Subject: [PATCH/RFC v6 4/5] ARM: imx6: pm: declare pm domain latency on power_state struct.
Date: Wed, 29 Apr 2015 21:10:14 +0200
Message-ID: <1430334615-1161-5-git-send-email-ahaslam@baylibre.com>
References: <1430334615-1161-1-git-send-email-ahaslam@baylibre.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wi0-f170.google.com ([209.85.212.170]:35641 "EHLO
	mail-wi0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751833AbbD2TLX (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 29 Apr 2015 15:11:23 -0400
Received: by widdi4 with SMTP id di4so191850318wid.0
        for <linux-pm@vger.kernel.org>; Wed, 29 Apr 2015 12:11:22 -0700 (PDT)
In-Reply-To: <1430334615-1161-1-git-send-email-ahaslam@baylibre.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: ulf.hansson@linaro.org, khilman@linaro.org, k.kozlowski.k@gmail.com, geert@linux-m68k.org, rjw@rjwysocki.net
Cc: bcousson@baylibre.com, linux-pm@vger.kernel.org, Axel Haslam <ahaslam+renesas@baylibre.com>

From: Axel Haslam <ahaslam+renesas@baylibre.com>

The generic_pm_domain structure uses an array of latencies
to be able to declare multiple intermediate states.

Declare a single "OFF" state with the default latencies
So that the  power_off_latency_ns and power_on_latency_ns
fields of generic_pm_domain structure can be eventualy removed.

Signed-off-by: Axel Haslam <ahaslam+renesas@baylibre.com>
---
 arch/arm/mach-imx/gpc.c | 18 +++++++++++++++---
 1 file changed, 15 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-imx/gpc.c b/arch/arm/mach-imx/gpc.c
index 092b4ae..4c0ca34 100644
--- a/arch/arm/mach-imx/gpc.c
+++ b/arch/arm/mach-imx/gpc.c
@@ -45,9 +45,11 @@
 
 struct pu_domain {
 	struct generic_pm_domain base;
+	struct genpd_power_state *states;
 	struct regulator *reg;
 	struct clk *clk[GPC_CLK_MAX];
 	int num_clks;
+	int num_states;
 };
 
 static void __iomem *gpc_base;
@@ -365,14 +367,22 @@ static struct generic_pm_domain imx6q_arm_domain = {
 	.name = "ARM",
 };
 
+static struct genpd_power_state imx6q_arm_domain_states[] = {
+	{
+		.name = "OFF",
+		.power_off_latency_ns = 25000,
+		.power_on_latency_ns = 2000000,
+	},
+};
+
 static struct pu_domain imx6q_pu_domain = {
 	.base = {
 		.name = "PU",
 		.power_off = imx6q_pm_pu_power_off,
 		.power_on = imx6q_pm_pu_power_on,
-		.power_off_latency_ns = 25000,
-		.power_on_latency_ns = 2000000,
 	},
+	.states = imx6q_arm_domain_states,
+	.num_states = ARRAY_SIZE(imx6q_arm_domain_states),
 };
 
 static struct generic_pm_domain imx6sl_display_domain = {
@@ -421,7 +431,9 @@ static int imx_gpc_genpd_init(struct device *dev, struct regulator *pu_reg)
 		imx6q_pm_pu_power_on(&imx6q_pu_domain.base);
 	}
 
-	pm_genpd_init(&imx6q_pu_domain.base, NULL, NULL, 0, is_off);
+	pm_genpd_init(&imx6q_pu_domain.base, NULL, imx6q_pu_domain.states,
+		      imx6q_pu_domain.num_states, is_off);
+
 	return of_genpd_add_provider_onecell(dev->of_node,
 					     &imx_gpc_onecell_data);
 
-- 
1.9.1

