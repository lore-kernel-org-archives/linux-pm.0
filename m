From: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH/RFC 1/5] clk: shmobile: rcar-gen2: Add CPG Clock Domain support
Date: Wed, 18 Mar 2015 20:46:53 +0100
Message-ID: <1426708017-28885-2-git-send-email-geert+renesas@glider.be>
References: <1426708017-28885-1-git-send-email-geert+renesas@glider.be>
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <1426708017-28885-1-git-send-email-geert+renesas@glider.be>
Sender: linux-sh-owner@vger.kernel.org
To: Mike Turquette <mturquette@linaro.org>, Stephen Boyd <sboyd@codeaurora.org>, Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Kevin Hilman <khilman@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-sh@vger.kernel.org, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>
List-Id: linux-pm@vger.kernel.org

Add Clock Domain support to the R-Car Gen2 Clock Pulse Generator (CPG)
driver using the generic PM Domain.  This allows to power-manage the
module clocks of SoC devices that are part of the CPG Clock Domain using
Runtime PM, or for system suspend/resume.

SoC devices that are part of the CPG Clock Domain and can be
power-managed through their primary clock should be tagged in DT with a
proper "power-domains" property.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 .../clock/renesas,rcar-gen2-cpg-clocks.txt         | 26 ++++++++-
 arch/arm/mach-shmobile/Kconfig                     |  1 +
 drivers/clk/shmobile/clk-rcar-gen2.c               | 63 ++++++++++++++++++++++
 3 files changed, 88 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/clock/renesas,rcar-gen2-cpg-clocks.txt b/Documentation/devicetree/bindings/clock/renesas,rcar-gen2-cpg-clocks.txt
index b02944fba9de4f86..fc013f225a348929 100644
--- a/Documentation/devicetree/bindings/clock/renesas,rcar-gen2-cpg-clocks.txt
+++ b/Documentation/devicetree/bindings/clock/renesas,rcar-gen2-cpg-clocks.txt
@@ -2,6 +2,8 @@
 
 The CPG generates core clocks for the R-Car Gen2 SoCs. It includes three PLLs
 and several fixed ratio dividers.
+The CPG also provides a Clock Domain for SoC devices, in combination with the
+CPG Module Stop (MSTP) Clocks.
 
 Required Properties:
 
@@ -20,10 +22,18 @@ Required Properties:
   - clock-output-names: The names of the clocks. Supported clocks are "main",
     "pll0", "pll1", "pll3", "lb", "qspi", "sdh", "sd0", "sd1", "z", "rcan", and
     "adsp"
+  - #power-domain-cells: Must be 0
 
+SoC devices that are part of the CPG Clock Domain and can be power-managed
+through their primary clock should refer to the CPG device node in their
+"power-domains" property, as documented by the generic PM domain bindings in
+Documentation/devicetree/bindings/power/power_domain.txt.
 
-Example
--------
+
+Examples
+--------
+
+  - CPG device node:
 
 	cpg_clocks: cpg_clocks@e6150000 {
 		compatible = "renesas,r8a7790-cpg-clocks",
@@ -34,4 +44,16 @@ Example
 		clock-output-names = "main", "pll0, "pll1", "pll3",
 				     "lb", "qspi", "sdh", "sd0", "sd1", "z",
 				     "rcan", "adsp";
+		#power-domain-cells = <0>;
+	};
+
+
+  - CPG Clock Domain member node:
+
+	thermal@e61f0000 {
+		compatible = "renesas,thermal-r8a7790", "renesas,rcar-thermal";
+		reg = <0 0xe61f0000 0 0x14>, <0 0xe61f0100 0 0x38>;
+		interrupts = <0 69 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&mstp5_clks R8A7790_CLK_THERMAL>;
+		power-domains = <&cpg_clocks>;
 	};
diff --git a/arch/arm/mach-shmobile/Kconfig b/arch/arm/mach-shmobile/Kconfig
index 0fb484221c90e0eb..048101a3253c52de 100644
--- a/arch/arm/mach-shmobile/Kconfig
+++ b/arch/arm/mach-shmobile/Kconfig
@@ -4,6 +4,7 @@ config ARCH_SHMOBILE
 
 config PM_RCAR
 	bool
+	select PM_GENERIC_DOMAINS
 
 config PM_RMOBILE
 	bool
diff --git a/drivers/clk/shmobile/clk-rcar-gen2.c b/drivers/clk/shmobile/clk-rcar-gen2.c
index acfb6d7dbd6bc049..b54439d3722a13ad 100644
--- a/drivers/clk/shmobile/clk-rcar-gen2.c
+++ b/drivers/clk/shmobile/clk-rcar-gen2.c
@@ -18,6 +18,8 @@
 #include <linux/math64.h>
 #include <linux/of.h>
 #include <linux/of_address.h>
+#include <linux/pm_clock.h>
+#include <linux/pm_domain.h>
 #include <linux/spinlock.h>
 
 struct rcar_gen2_cpg {
@@ -364,6 +366,65 @@ rcar_gen2_cpg_register_clock(struct device_node *np, struct rcar_gen2_cpg *cpg,
 						 4, 0, table, &cpg->lock);
 }
 
+#ifdef CONFIG_PM_GENERIC_DOMAINS_OF
+static int cpg_pd_attach_dev(struct generic_pm_domain *domain,
+			     struct device *dev)
+{
+	int error;
+
+	error = pm_clk_create(dev);
+	if (error) {
+		dev_err(dev, "pm_clk_create failed %d\n", error);
+		return error;
+	}
+
+	error = pm_clk_add(dev, NULL);
+	if (error) {
+		dev_err(dev, "pm_clk_add failed %d\n", error);
+		goto fail;
+	}
+
+	return 0;
+
+fail:
+	pm_clk_destroy(dev);
+	return error;
+}
+
+static void cpg_pd_detach_dev(struct generic_pm_domain *domain,
+			      struct device *dev)
+{
+	pm_clk_destroy(dev);
+}
+
+static void __init rcar_gen2_cpg_add_pm_domain(struct device_node *np)
+{
+	struct generic_pm_domain *pd;
+	u32 ncells;
+
+	if (of_property_read_u32(np, "#power-domain-cells", &ncells)) {
+		pr_warn("%s lacks #power-domain-cells. Clocks may fail.\n",
+			np->full_name);
+		return;
+	}
+
+	pd = kzalloc(sizeof(*pd), GFP_KERNEL);
+	if (!pd)
+		return;
+
+	pd->name = np->name;
+
+	pd->flags = GENPD_FLAG_PM_CLK;
+	pm_genpd_init(pd, &simple_qos_governor, false);
+	pd->attach_dev = cpg_pd_attach_dev;
+	pd->detach_dev = cpg_pd_detach_dev;
+
+	of_genpd_add_provider_simple(np, pd);
+}
+#else /* !CONFIG_PM_GENERIC_DOMAINS_OF */
+static inline void rcar_gen2_cpg_add_pm_domain(struct device_node *np) {}
+#endif /* !CONFIG_PM_GENERIC_DOMAINS_OF */
+
 static void __init rcar_gen2_cpg_clocks_init(struct device_node *np)
 {
 	const struct cpg_pll_config *config;
@@ -415,6 +476,8 @@ static void __init rcar_gen2_cpg_clocks_init(struct device_node *np)
 	}
 
 	of_clk_add_provider(np, of_clk_src_onecell_get, &cpg->data);
+
+	rcar_gen2_cpg_add_pm_domain(np);
 }
 CLK_OF_DECLARE(rcar_gen2_cpg_clks, "renesas,rcar-gen2-cpg-clocks",
 	       rcar_gen2_cpg_clocks_init);
-- 
1.9.1

