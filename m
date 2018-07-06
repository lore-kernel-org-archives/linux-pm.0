From: Leonard Crestez <leonard.crestez@nxp.com>
Subject: [PATCH v3] soc: imx: gpc: Turn PU domain on/off in sleep on 6qp
Date: Fri,  6 Jul 2018 19:46:33 +0300
Message-ID: <ab0c7997bdb0caf6fe7e842315bb9565c2cb059d.1530895248.git.leonard.crestez@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Lucas Stach <l.stach@pengutronix.de>, Shawn Guo <shawnguo@kernel.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Fabio Estevam <fabio.estevam@nxp.com>, Andrey Smirnov <andrew.smirnov@gmail.com>, Robin Gong <yibin.gong@nxp.com>, Dong Aisheng <aisheng.dong@nxp.com>, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-imx@nxp.com, kernel@pengutronix.de
List-Id: linux-pm@vger.kernel.org

On imx6qp power gating on the PU domain is disabled because of errata
ERR009619. However power gating during suspend/resume can still be
performed.

Enable this by implementing SLEEP_PM_OPS in imx_pgc_power_domain_driver.

In order to ensure correct ordering add device links from devices inside
the PU domain to the pgc platform_device.

Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>

---
 drivers/soc/imx/gpc.c | 88 +++++++++++++++++++++++++++++++++++--------
 1 file changed, 73 insertions(+), 15 deletions(-)

Link to v2: https://lkml.org/lkml/2018/7/5/564

Changes since v2: Add device links on attach

The NXP kernel has been turning the PU domain off in sleep on 6qp for
many releases so this behavior went through multiple QA cycles and is
known to work. Further small improvements in power usage could be
obtained by also shutting off the PU LDO regulator but that's not as
well-validated.

diff --git a/drivers/soc/imx/gpc.c b/drivers/soc/imx/gpc.c
index 32f0748fd067..b96d8dc9626d 100644
--- a/drivers/soc/imx/gpc.c
+++ b/drivers/soc/imx/gpc.c
@@ -54,19 +54,16 @@ static inline struct imx_pm_domain *
 to_imx_pm_domain(struct generic_pm_domain *genpd)
 {
 	return container_of(genpd, struct imx_pm_domain, base);
 }
 
-static int imx6_pm_domain_power_off(struct generic_pm_domain *genpd)
+static void _imx6_pm_domain_power_off(struct generic_pm_domain *genpd)
 {
 	struct imx_pm_domain *pd = to_imx_pm_domain(genpd);
 	int iso, iso2sw;
 	u32 val;
 
-	if (pd->flags & PGC_DOMAIN_FLAG_NO_PD)
-		return -EBUSY;
-
 	/* Read ISO and ISO2SW power down delays */
 	regmap_read(pd->regmap, pd->reg_offs + GPC_PGC_PUPSCR_OFFS, &val);
 	iso = val & 0x3f;
 	iso2sw = (val >> 8) & 0x3f;
 
@@ -78,32 +75,33 @@ static int imx6_pm_domain_power_off(struct generic_pm_domain *genpd)
 	val = BIT(pd->cntr_pdn_bit);
 	regmap_update_bits(pd->regmap, GPC_CNTR, val, val);
 
 	/* Wait ISO + ISO2SW IPG clock cycles */
 	udelay(DIV_ROUND_UP(iso + iso2sw, pd->ipg_rate_mhz));
+}
+
+static int imx6_pm_domain_power_off(struct generic_pm_domain *genpd)
+{
+	struct imx_pm_domain *pd = to_imx_pm_domain(genpd);
+
+	if (pd->flags & PGC_DOMAIN_FLAG_NO_PD)
+		return -EBUSY;
+
+	_imx6_pm_domain_power_off(genpd);
 
 	if (pd->supply)
 		regulator_disable(pd->supply);
 
 	return 0;
 }
 
-static int imx6_pm_domain_power_on(struct generic_pm_domain *genpd)
+static void _imx6_pm_domain_power_on(struct generic_pm_domain *genpd)
 {
 	struct imx_pm_domain *pd = to_imx_pm_domain(genpd);
-	int i, ret, sw, sw2iso;
+	int i, sw, sw2iso;
 	u32 val;
 
-	if (pd->supply) {
-		ret = regulator_enable(pd->supply);
-		if (ret) {
-			pr_err("%s: failed to enable regulator: %d\n",
-			       __func__, ret);
-			return ret;
-		}
-	}
-
 	/* Enable reset clocks for all devices in the domain */
 	for (i = 0; i < pd->num_clks; i++)
 		clk_prepare_enable(pd->clk[i]);
 
 	/* Gate off domain when powered down */
@@ -123,10 +121,39 @@ static int imx6_pm_domain_power_on(struct generic_pm_domain *genpd)
 	udelay(DIV_ROUND_UP(sw + sw2iso, pd->ipg_rate_mhz));
 
 	/* Disable reset clocks for all devices in the domain */
 	for (i = 0; i < pd->num_clks; i++)
 		clk_disable_unprepare(pd->clk[i]);
+}
+
+static int imx6_pm_domain_power_on(struct generic_pm_domain *genpd)
+{
+	struct imx_pm_domain *pd = to_imx_pm_domain(genpd);
+	int ret;
+
+	if (pd->supply) {
+		ret = regulator_enable(pd->supply);
+		if (ret) {
+			pr_err("%s: failed to enable regulator: %d\n",
+			       __func__, ret);
+			return ret;
+		}
+	}
+
+	_imx6_pm_domain_power_on(genpd);
+
+	return 0;
+}
+
+static int imx6_pm_domain_attach_dev(
+               struct generic_pm_domain *genpd,
+               struct device *dev)
+{
+	struct imx_pm_domain *pd = to_imx_pm_domain(genpd);
+
+	if (pd->flags & PGC_DOMAIN_FLAG_NO_PD)
+		device_link_add(dev, genpd->dev.parent, DL_FLAG_AUTOREMOVE);
 
 	return 0;
 }
 
 static int imx_pgc_get_clocks(struct device *dev, struct imx_pm_domain *domain)
@@ -198,10 +225,11 @@ static int imx_pgc_power_domain_probe(struct platform_device *pdev)
 	if (IS_ENABLED(CONFIG_PM_GENERIC_DOMAINS)) {
 		pm_genpd_init(&domain->base, NULL, false);
 		ret = of_genpd_add_provider_simple(dev->of_node, &domain->base);
 		if (ret)
 			goto genpd_err;
+		domain->base.dev.parent = dev;
 	}
 
 	device_link_add(dev, dev->parent, DL_FLAG_AUTOREMOVE);
 
 	return 0;
@@ -224,18 +252,45 @@ static int imx_pgc_power_domain_remove(struct platform_device *pdev)
 	}
 
 	return 0;
 }
 
+static int imx_pgc_suspend(struct device *dev)
+{
+	struct platform_device *pdev = to_platform_device(dev);
+	struct imx_pm_domain *pd = pdev->dev.platform_data;
+
+	if (pd->flags & PGC_DOMAIN_FLAG_NO_PD)
+		_imx6_pm_domain_power_off(&pd->base);
+
+	return 0;
+}
+
+static int imx_pgc_resume(struct device *dev)
+{
+	struct platform_device *pdev = to_platform_device(dev);
+	struct imx_pm_domain *pd = pdev->dev.platform_data;
+
+	if (pd->flags & PGC_DOMAIN_FLAG_NO_PD)
+		_imx6_pm_domain_power_on(&pd->base);
+
+	return 0;
+}
+
+static const struct dev_pm_ops imx_pgc_pm_ops = {
+	SET_SYSTEM_SLEEP_PM_OPS(imx_pgc_suspend, imx_pgc_resume)
+};
+
 static const struct platform_device_id imx_pgc_power_domain_id[] = {
 	{ "imx-pgc-power-domain"},
 	{ },
 };
 
 static struct platform_driver imx_pgc_power_domain_driver = {
 	.driver = {
 		.name = "imx-pgc-pd",
+		.pm = &imx_pgc_pm_ops,
 	},
 	.probe = imx_pgc_power_domain_probe,
 	.remove = imx_pgc_power_domain_remove,
 	.id_table = imx_pgc_power_domain_id,
 };
@@ -259,28 +314,31 @@ static struct imx_pm_domain imx_gpc_domains[] = {
 	}, {
 		.base = {
 			.name = "PU",
 			.power_off = imx6_pm_domain_power_off,
 			.power_on = imx6_pm_domain_power_on,
+			.attach_dev = imx6_pm_domain_attach_dev,
 			.states = &imx6_pm_domain_pu_state,
 			.state_count = 1,
 		},
 		.reg_offs = 0x260,
 		.cntr_pdn_bit = 0,
 	}, {
 		.base = {
 			.name = "DISPLAY",
 			.power_off = imx6_pm_domain_power_off,
 			.power_on = imx6_pm_domain_power_on,
+			.attach_dev = imx6_pm_domain_attach_dev,
 		},
 		.reg_offs = 0x240,
 		.cntr_pdn_bit = 4,
 	}, {
 		.base = {
 			.name = "PCI",
 			.power_off = imx6_pm_domain_power_off,
 			.power_on = imx6_pm_domain_power_on,
+			.attach_dev = imx6_pm_domain_attach_dev,
 		},
 		.reg_offs = 0x200,
 		.cntr_pdn_bit = 6,
 	},
 };
-- 
2.17.1
