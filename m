From: Leonard Crestez <leonard.crestez@nxp.com>
Subject: [PATCH] soc: imx6qp: Use GENPD_FLAG_ALWAYS_ON for PU errata
Date: Fri, 13 Jul 2018 13:01:15 +0300
Message-ID: <c00ad2ebf94d105544b328c77fa1edbfe6bbc193.1531475786.git.leonard.crestez@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Shawn Guo <shawnguo@kernel.org>, Lucas Stach <l.stach@pengutronix.de>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Fabio Estevam <fabio.estevam@nxp.com>, Robin Gong <yibin.gong@nxp.com>, Anson Huang <Anson.Huang@nxp.com>, Dong Aisheng <aisheng.dong@nxp.com>, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-imx@nxp.com, kernel@pengutronix.de
List-Id: linux-pm@vger.kernel.org

This is functionally identical but simpler and slightly faster.

The PU domain is turned on at boot time and never turned off. In the
current implementation the pm core will repeatedly call power_off when
the domain is unused and get -EBUSY back. If the domain is marked as
"always on" instead the pm core won't even attempt to turn it off.

In theory on 6qp it is safe to turn PU off in suspend, however that is
best accomplished with a new core flag.

Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>
---
 drivers/soc/imx/gpc.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

Previous discussion:
* https://lkml.org/lkml/2018/7/11/431
* https://lkml.org/lkml/2018/7/10/103

Attempt at turning PU off in suspend:
* https://lkml.org/lkml/2018/7/6/698

diff --git a/drivers/soc/imx/gpc.c b/drivers/soc/imx/gpc.c
index faf13a0b85d6..f31978e5af20 100644
--- a/drivers/soc/imx/gpc.c
+++ b/drivers/soc/imx/gpc.c
@@ -45,11 +45,10 @@ struct imx_pm_domain {
 	struct clk *clk[GPC_CLK_MAX];
 	int num_clks;
 	unsigned int reg_offs;
 	signed char cntr_pdn_bit;
 	unsigned int ipg_rate_mhz;
-	unsigned int flags;
 };
 
 static inline struct imx_pm_domain *
 to_imx_pm_domain(struct generic_pm_domain *genpd)
 {
@@ -60,13 +59,10 @@ static int imx6_pm_domain_power_off(struct generic_pm_domain *genpd)
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
 
@@ -419,12 +415,12 @@ static int imx_gpc_probe(struct platform_device *pdev)
 		return ret;
 	}
 
 	/* Disable PU power down in normal operation if ERR009619 is present */
 	if (of_id_data->err009619_present)
-		imx_gpc_domains[GPC_PGC_DOMAIN_PU].flags |=
-				PGC_DOMAIN_FLAG_NO_PD;
+		imx_gpc_domains[GPC_PGC_DOMAIN_PU].base.flags |=
+				GENPD_FLAG_ALWAYS_ON;
 
 	/* Keep DISP always on if ERR006287 is present */
 	if (of_id_data->err006287_present)
 		imx_gpc_domains[GPC_PGC_DOMAIN_DISPLAY].base.flags |=
 				GENPD_FLAG_ALWAYS_ON;
-- 
2.17.1
