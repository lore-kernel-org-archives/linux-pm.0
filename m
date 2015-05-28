From: Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>
Subject: [PATCH v2 01/14] clk: shmobile: Add CPG Clock Domain support
Date: Thu, 28 May 2015 20:53:26 +0200
Message-ID: <1432839219-475-2-git-send-email-geert+renesas@glider.be>
References: <1432839219-475-1-git-send-email-geert+renesas@glider.be>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1432839219-475-1-git-send-email-geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mike Turquette <mturquette-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Stephen Boyd <sboyd-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Simon Horman <horms-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org>, Magnus Damm <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Laurent Pinchart <Laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, Kevin Hilman <khilman-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: linux-clk-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

Add Clock Domain support to the Clock Pulse Generator (CPG) Module Stop
(MSTP) Clocks driver using the generic PM Domain.  This allows to
power-manage the module clocks of SoC devices that are part of the CPG
Clock Domain using Runtime PM, or for system suspend/resume.

SoC devices that are part of a CPG Clock Domain and can be
power-managed through an MSTP clock should be tagged in DT with a
proper "power-domains" property.

The CPG Clock Domain code will scan such devices for clocks that are
suitable for power-managing the device, by looking for a clock that is
compatible with "renesas,cpg-mstp-clocks".

Signed-off-by: Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>
Acked-by: Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>
Reviewed-by: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Reviewed-by: Kevin Hilman <khilman-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
---
v2:
  - Add Acked-by and Reviewed-by,
  - Move core CPG Clock Domain code from the R-Car Gen2 driver to the
    CPG MSTP Clocks driver, as it's generic, and can be used on other
    Renesas SoCs that have a CPG/MSTP block,
  - Scan for an MSTP clock instead of using the first clock tied to the
    device (con_id NULL),
  - Extract R-Car Gen2 specifics to a separate patch.
---
 drivers/clk/shmobile/clk-mstp.c      | 86 ++++++++++++++++++++++++++++++++++++
 drivers/clk/shmobile/clk-rcar-gen2.c |  2 +
 include/linux/clk/shmobile.h         | 12 +++++
 3 files changed, 100 insertions(+)

diff --git a/drivers/clk/shmobile/clk-mstp.c b/drivers/clk/shmobile/clk-mstp.c
index 2d2fe773ac8168f9..619f3eccefd4884f 100644
--- a/drivers/clk/shmobile/clk-mstp.c
+++ b/drivers/clk/shmobile/clk-mstp.c
@@ -2,6 +2,7 @@
  * R-Car MSTP clocks
  *
  * Copyright (C) 2013 Ideas On Board SPRL
+ * Copyright (C) 2015 Glider bvba
  *
  * Contact: Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>
  *
@@ -12,9 +13,13 @@
 
 #include <linux/clk-provider.h>
 #include <linux/clkdev.h>
+#include <linux/clk/shmobile.h>
+#include <linux/device.h>
 #include <linux/io.h>
 #include <linux/of.h>
 #include <linux/of_address.h>
+#include <linux/pm_clock.h>
+#include <linux/pm_domain.h>
 #include <linux/spinlock.h>
 
 /*
@@ -236,3 +241,84 @@ static void __init cpg_mstp_clocks_init(struct device_node *np)
 	of_clk_add_provider(np, of_clk_src_onecell_get, &group->data);
 }
 CLK_OF_DECLARE(cpg_mstp_clks, "renesas,cpg-mstp-clocks", cpg_mstp_clocks_init);
+
+
+#ifdef CONFIG_PM_GENERIC_DOMAINS_OF
+int cpg_mstp_attach_dev(struct generic_pm_domain *domain, struct device *dev)
+{
+	struct device_node *np = dev->of_node;
+	struct of_phandle_args clkspec;
+	struct clk *clk;
+	int i = 0;
+	int error;
+
+	while (!of_parse_phandle_with_args(np, "clocks", "#clock-cells", i,
+					   &clkspec)) {
+		if (of_device_is_compatible(clkspec.np,
+					    "renesas,cpg-mstp-clocks"))
+			goto found;
+
+		of_node_put(clkspec.np);
+		i++;
+	}
+
+	return 0;
+
+found:
+	clk = of_clk_get_from_provider(&clkspec);
+	of_node_put(clkspec.np);
+
+	if (IS_ERR(clk))
+		return PTR_ERR(clk);
+
+	error = pm_clk_create(dev);
+	if (error) {
+		dev_err(dev, "pm_clk_create failed %d\n", error);
+		goto fail_put;
+	}
+
+	error = pm_clk_add_clk(dev, clk);
+	if (error) {
+		dev_err(dev, "pm_clk_add_clk %pC failed %d\n", clk, error);
+		goto fail_destroy;
+	}
+
+	return 0;
+
+fail_destroy:
+	pm_clk_destroy(dev);
+fail_put:
+	clk_put(clk);
+	return error;
+}
+
+void cpg_mstp_detach_dev(struct generic_pm_domain *domain, struct device *dev)
+{
+	pm_clk_destroy(dev);
+}
+
+void __init cpg_mstp_add_clk_domain(struct device_node *np)
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
+	pd->attach_dev = cpg_mstp_attach_dev;
+	pd->detach_dev = cpg_mstp_detach_dev;
+
+	of_genpd_add_provider_simple(np, pd);
+}
+#endif /* !CONFIG_PM_GENERIC_DOMAINS_OF */
diff --git a/drivers/clk/shmobile/clk-rcar-gen2.c b/drivers/clk/shmobile/clk-rcar-gen2.c
index acfb6d7dbd6bc049..c7fde69d455e38c4 100644
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
diff --git a/include/linux/clk/shmobile.h b/include/linux/clk/shmobile.h
index 63a8159c4e64153d..cb19cc1865ca5cfb 100644
--- a/include/linux/clk/shmobile.h
+++ b/include/linux/clk/shmobile.h
@@ -16,8 +16,20 @@
 
 #include <linux/types.h>
 
+struct device;
+struct device_node;
+struct generic_pm_domain;
+
 void r8a7778_clocks_init(u32 mode);
 void r8a7779_clocks_init(u32 mode);
 void rcar_gen2_clocks_init(u32 mode);
 
+#ifdef CONFIG_PM_GENERIC_DOMAINS_OF
+void cpg_mstp_add_clk_domain(struct device_node *np);
+int cpg_mstp_attach_dev(struct generic_pm_domain *domain, struct device *dev);
+void cpg_mstp_detach_dev(struct generic_pm_domain *domain, struct device *dev);
+#else
+static inline void cpg_mstp_add_clk_domain(struct device_node *np) {}
+#endif
+
 #endif
-- 
1.9.1

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
