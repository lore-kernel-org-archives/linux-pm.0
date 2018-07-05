From: Leonard Crestez <leonard.crestez@nxp.com>
Subject: [PATCH v2] soc: imx: gpc: Turn PU domain on/off in sleep on 6qp
Date: Thu,  5 Jul 2018 18:12:43 +0300
Message-ID: <72f3e615f4df69ee6d802efbd1e1e52692c8e134.1530803324.git.leonard.crestez@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Lucas Stach <l.stach@pengutronix.de>, Shawn Guo <shawnguo@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Andrey Smirnov <andrew.smirnov@gmail.com>, Fabio Estevam <fabio.estevam@nxp.com>, Viresh Kumar <viresh.kumar@linaro.org>, Dong Aisheng <aisheng.dong@nxp.com>, linux-pm@vger.kernel.org, linux-imx@nxp.com, kernel@pengutronix.de, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On imx6qp power gating on the PU domain is disabled because of errata
ERR009619. However power gating during suspend/resume can still be
performed.

Enable this by implementing SLEEP_PM_OPS in imx_pgc_power_domain_driver.

Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>

---
 drivers/soc/imx/gpc.c | 72 ++++++++++++++++++++++++++++++++++---------
 1 file changed, 57 insertions(+), 15 deletions(-)

Changes since v1: Implement SLEEP_PM_OPS instead of calling from
platform-level suspend code, as suggested by Lucas.

I'm not sure if doing interesting things in the pm_ops for PM providers
is recommended. Is correct ordering guaranteed in such a case?  Any
VPU/GPU suspend code must execute before imx_pgc_suspend or it might try
to access registers in a region which is powered off.

Perhaps ordering needs to be guaranteed by implementing device_attach
and adding explicit device links to pgc platform_device?

Link to v1: https://lkml.org/lkml/2018/7/2/370

diff --git a/drivers/soc/imx/gpc.c b/drivers/soc/imx/gpc.c
index b4acdfd3cffd..96d9e882d583 100644
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
@@ -123,10 +121,27 @@ static int imx6_pm_domain_power_on(struct generic_pm_domain *genpd)
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
 
 	return 0;
 }
 
 static int imx_pgc_get_clocks(struct device *dev, struct imx_pm_domain *domain)
@@ -227,18 +242,45 @@ static int imx_pgc_power_domain_remove(struct platform_device *pdev)
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
-- 
2.17.1
