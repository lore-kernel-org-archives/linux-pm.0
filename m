From: ahaslam@baylibre.com
Subject: [PATCH v9 4/6] ARM: imx6: pm: declare pm domain latency on power_state struct.
Date: Mon, 19 Oct 2015 16:51:39 +0200
Message-ID: <1445266301-32448-5-git-send-email-ahaslam@baylibre.com>
References: <1445266301-32448-1-git-send-email-ahaslam@baylibre.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1445266301-32448-1-git-send-email-ahaslam@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
To: khilman@linaro.org, ulf.hansson@linaro.org, lina.iyer@linaro.org, geert@glider.be, k.kozlowski.k@gmail.com, rjw@rjwysocki.net, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: bcousson@baylibre.com, mturquette@baylibre.com, Axel Haslam <ahaslam+renesas@baylibre.com>
List-Id: linux-pm@vger.kernel.org

From: Axel Haslam <ahaslam+renesas@baylibre.com>

The generic_pm_domain structure uses an array of latencies to be able to
declare multiple intermediate states.

Declare a single "OFF" state with the default latencies So that the
power_off_latency_ns and power_on_latency_ns fields of generic_pm_domain
structure can be eventualy removed.

Signed-off-by: Axel Haslam <ahaslam+renesas@baylibre.com>
---
 arch/arm/mach-imx/gpc.c | 18 +++++++++++++++---
 1 file changed, 15 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-imx/gpc.c b/arch/arm/mach-imx/gpc.c
index 76658f8..367a00c 100644
--- a/arch/arm/mach-imx/gpc.c
+++ b/arch/arm/mach-imx/gpc.c
@@ -45,9 +45,11 @@
 
 struct pu_domain {
 	struct generic_pm_domain base;
+	struct genpd_power_state *states;
 	struct regulator *reg;
 	struct clk *clk[GPC_CLK_MAX];
 	int num_clks;
+	unsigned int num_states;
 };
 
 static void __iomem *gpc_base;
@@ -369,14 +371,22 @@ static struct generic_pm_domain imx6q_arm_domain = {
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
@@ -419,7 +429,9 @@ static int imx_gpc_genpd_init(struct device *dev, struct regulator *pu_reg)
 	if (!IS_ENABLED(CONFIG_PM_GENERIC_DOMAINS))
 		return 0;
 
-	pm_genpd_init_simple(&imx6q_pu_domain.base, NULL, false);
+	pm_genpd_init(&imx6q_pu_domain.base, NULL, imx6q_pu_domain.states,
+			imx6q_pu_domain.num_states, false);
+
 	return of_genpd_add_provider_onecell(dev->of_node,
 					     &imx_gpc_onecell_data);
 
-- 
2.4.5
