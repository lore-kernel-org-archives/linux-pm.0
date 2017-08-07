From: <sean.wang@mediatek.com>
Subject: [PATCH v3 2/4] soc: mediatek: reduce code duplication of scpsys_probe across all SoCs
Date: Mon, 7 Aug 2017 15:24:35 +0800
Message-ID: <eca19f7f94745edb2227545f9b0539201e73301c.1502090240.git.sean.wang@mediatek.com>
References: <cover.1502090240.git.sean.wang@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1502090240.git.sean.wang@mediatek.com>
Sender: linux-kernel-owner@vger.kernel.org
To: robh+dt@kernel.org, matthias.bgg@gmail.com, rjw@rjwysocki.net, khilman@baylibre.com
Cc: ulf.hansson@linaro.org, devicetree@vger.kernel.org, linux-mediatek@lists.infradead.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Sean Wang <sean.wang@mediatek.com>
List-Id: linux-pm@vger.kernel.org

From: Sean Wang <sean.wang@mediatek.com>

Reduce code duplication of scpsys_probe_mtXXXX across all SoCs using
the more generic scpsys_probe all covering all cases to avoid starting
to bloat the driver when more MediaTek SoCs supported are added.

Suggested-by: Matthias Brugger <matthias.bgg@gmail.com>
Signed-off-by: Sean Wang <sean.wang@mediatek.com>
---
 drivers/soc/mediatek/mtk-scpsys.c | 182 +++++++++++++++++---------------------
 1 file changed, 79 insertions(+), 103 deletions(-)

diff --git a/drivers/soc/mediatek/mtk-scpsys.c b/drivers/soc/mediatek/mtk-scpsys.c
index ceb2cc4..6268b28 100644
--- a/drivers/soc/mediatek/mtk-scpsys.c
+++ b/drivers/soc/mediatek/mtk-scpsys.c
@@ -124,6 +124,19 @@ struct scp {
 	struct scp_ctrl_reg ctrl_reg;
 };
 
+struct scp_subdomain {
+	int origin;
+	int subdomain;
+};
+
+struct scp_soc_data {
+	const struct scp_domain_data *domains;
+	int num_domains;
+	const struct scp_subdomain *subdomains;
+	int num_subdomains;
+	const struct scp_ctrl_reg regs;
+};
+
 static int scpsys_domain_is_on(struct scp_domain *scpd)
 {
 	struct scp *scp = scpd->scp;
@@ -357,7 +370,7 @@ static void init_clks(struct platform_device *pdev, struct clk **clk)
 
 static struct scp *init_scp(struct platform_device *pdev,
 			const struct scp_domain_data *scp_domain_data, int num,
-			struct scp_ctrl_reg *scp_ctrl_reg)
+			const struct scp_ctrl_reg *scp_ctrl_reg)
 {
 	struct genpd_onecell_data *pd_data;
 	struct resource *res;
@@ -565,26 +578,6 @@ static const struct scp_domain_data scp_domain_data_mt2701[] = {
 	},
 };
 
-#define NUM_DOMAINS_MT2701	ARRAY_SIZE(scp_domain_data_mt2701)
-
-static int __init scpsys_probe_mt2701(struct platform_device *pdev)
-{
-	struct scp *scp;
-	struct scp_ctrl_reg scp_reg;
-
-	scp_reg.pwr_sta_offs = SPM_PWR_STATUS;
-	scp_reg.pwr_sta2nd_offs = SPM_PWR_STATUS_2ND;
-
-	scp = init_scp(pdev, scp_domain_data_mt2701, NUM_DOMAINS_MT2701,
-		       &scp_reg);
-	if (IS_ERR(scp))
-		return PTR_ERR(scp);
-
-	mtk_register_power_domains(pdev, scp, NUM_DOMAINS_MT2701);
-
-	return 0;
-}
-
 /*
  * MT6797 power domain support
  */
@@ -649,51 +642,15 @@ static const struct scp_domain_data scp_domain_data_mt6797[] = {
 	},
 };
 
-#define NUM_DOMAINS_MT6797	ARRAY_SIZE(scp_domain_data_mt6797)
 #define SPM_PWR_STATUS_MT6797		0x0180
 #define SPM_PWR_STATUS_2ND_MT6797	0x0184
 
-static int __init scpsys_probe_mt6797(struct platform_device *pdev)
-{
-	struct scp *scp;
-	struct genpd_onecell_data *pd_data;
-	int ret;
-	struct scp_ctrl_reg scp_reg;
-
-	scp_reg.pwr_sta_offs = SPM_PWR_STATUS_MT6797;
-	scp_reg.pwr_sta2nd_offs = SPM_PWR_STATUS_2ND_MT6797;
-
-	scp = init_scp(pdev, scp_domain_data_mt6797, NUM_DOMAINS_MT6797,
-		       &scp_reg);
-	if (IS_ERR(scp))
-		return PTR_ERR(scp);
-
-	mtk_register_power_domains(pdev, scp, NUM_DOMAINS_MT6797);
-
-	pd_data = &scp->pd_data;
-
-	ret = pm_genpd_add_subdomain(pd_data->domains[MT6797_POWER_DOMAIN_MM],
-				     pd_data->domains[MT6797_POWER_DOMAIN_VDEC]);
-	if (ret && IS_ENABLED(CONFIG_PM))
-		dev_err(&pdev->dev, "Failed to add subdomain: %d\n", ret);
-
-	ret = pm_genpd_add_subdomain(pd_data->domains[MT6797_POWER_DOMAIN_MM],
-				     pd_data->domains[MT6797_POWER_DOMAIN_ISP]);
-	if (ret && IS_ENABLED(CONFIG_PM))
-		dev_err(&pdev->dev, "Failed to add subdomain: %d\n", ret);
-
-	ret = pm_genpd_add_subdomain(pd_data->domains[MT6797_POWER_DOMAIN_MM],
-				     pd_data->domains[MT6797_POWER_DOMAIN_VENC]);
-	if (ret && IS_ENABLED(CONFIG_PM))
-		dev_err(&pdev->dev, "Failed to add subdomain: %d\n", ret);
-
-	ret = pm_genpd_add_subdomain(pd_data->domains[MT6797_POWER_DOMAIN_MM],
-				     pd_data->domains[MT6797_POWER_DOMAIN_MJC]);
-	if (ret && IS_ENABLED(CONFIG_PM))
-		dev_err(&pdev->dev, "Failed to add subdomain: %d\n", ret);
-
-	return 0;
-}
+static const struct scp_subdomain scp_subdomain_mt6797[] = {
+	{MT6797_POWER_DOMAIN_MM, MT6797_POWER_DOMAIN_VDEC},
+	{MT6797_POWER_DOMAIN_MM, MT6797_POWER_DOMAIN_ISP},
+	{MT6797_POWER_DOMAIN_MM, MT6797_POWER_DOMAIN_VENC},
+	{MT6797_POWER_DOMAIN_MM, MT6797_POWER_DOMAIN_MJC},
+};
 
 /*
  * MT8173 power domain support
@@ -789,39 +746,41 @@ static const struct scp_domain_data scp_domain_data_mt8173[] = {
 	},
 };
 
-#define NUM_DOMAINS_MT8173	ARRAY_SIZE(scp_domain_data_mt8173)
-
-static int __init scpsys_probe_mt8173(struct platform_device *pdev)
-{
-	struct scp *scp;
-	struct genpd_onecell_data *pd_data;
-	int ret;
-	struct scp_ctrl_reg scp_reg;
-
-	scp_reg.pwr_sta_offs = SPM_PWR_STATUS;
-	scp_reg.pwr_sta2nd_offs = SPM_PWR_STATUS_2ND;
-
-	scp = init_scp(pdev, scp_domain_data_mt8173, NUM_DOMAINS_MT8173,
-		       &scp_reg);
-	if (IS_ERR(scp))
-		return PTR_ERR(scp);
-
-	mtk_register_power_domains(pdev, scp, NUM_DOMAINS_MT8173);
-
-	pd_data = &scp->pd_data;
+static const struct scp_subdomain scp_subdomain_mt8173[] = {
+	{MT8173_POWER_DOMAIN_MFG_ASYNC, MT8173_POWER_DOMAIN_MFG_2D},
+	{MT8173_POWER_DOMAIN_MFG_2D, MT8173_POWER_DOMAIN_MFG},
+};
 
-	ret = pm_genpd_add_subdomain(pd_data->domains[MT8173_POWER_DOMAIN_MFG_ASYNC],
-		pd_data->domains[MT8173_POWER_DOMAIN_MFG_2D]);
-	if (ret && IS_ENABLED(CONFIG_PM))
-		dev_err(&pdev->dev, "Failed to add subdomain: %d\n", ret);
+static const struct scp_soc_data mt2701_data = {
+	.domains = scp_domain_data_mt2701,
+	.num_domains = ARRAY_SIZE(scp_domain_data_mt2701),
+	.regs = {
+		.pwr_sta_offs = SPM_PWR_STATUS,
+		.pwr_sta2nd_offs = SPM_PWR_STATUS_2ND
+	}
+};
 
-	ret = pm_genpd_add_subdomain(pd_data->domains[MT8173_POWER_DOMAIN_MFG_2D],
-		pd_data->domains[MT8173_POWER_DOMAIN_MFG]);
-	if (ret && IS_ENABLED(CONFIG_PM))
-		dev_err(&pdev->dev, "Failed to add subdomain: %d\n", ret);
+static const struct scp_soc_data mt6797_data = {
+	.domains = scp_domain_data_mt6797,
+	.num_domains = ARRAY_SIZE(scp_domain_data_mt6797),
+	.subdomains = scp_subdomain_mt6797,
+	.num_subdomains = ARRAY_SIZE(scp_subdomain_mt6797),
+	.regs = {
+		.pwr_sta_offs = SPM_PWR_STATUS_MT6797,
+		.pwr_sta2nd_offs = SPM_PWR_STATUS_2ND_MT6797
+	}
+};
 
-	return 0;
-}
+static const struct scp_soc_data mt8173_data = {
+	.domains = scp_domain_data_mt8173,
+	.num_domains = ARRAY_SIZE(scp_domain_data_mt8173),
+	.subdomains = scp_subdomain_mt8173,
+	.num_subdomains = ARRAY_SIZE(scp_subdomain_mt8173),
+	.regs = {
+		.pwr_sta_offs = SPM_PWR_STATUS,
+		.pwr_sta2nd_offs = SPM_PWR_STATUS_2ND
+	}
+};
 
 /*
  * scpsys driver init
@@ -830,13 +789,13 @@ static int __init scpsys_probe_mt8173(struct platform_device *pdev)
 static const struct of_device_id of_scpsys_match_tbl[] = {
 	{
 		.compatible = "mediatek,mt2701-scpsys",
-		.data = scpsys_probe_mt2701,
+		.data = &mt2701_data,
 	}, {
 		.compatible = "mediatek,mt6797-scpsys",
-		.data = scpsys_probe_mt6797,
+		.data = &mt6797_data,
 	}, {
 		.compatible = "mediatek,mt8173-scpsys",
-		.data = scpsys_probe_mt8173,
+		.data = &mt8173_data,
 	}, {
 		/* sentinel */
 	}
@@ -844,16 +803,33 @@ static const struct of_device_id of_scpsys_match_tbl[] = {
 
 static int scpsys_probe(struct platform_device *pdev)
 {
-	int (*probe)(struct platform_device *);
-	const struct of_device_id *of_id;
+	const struct of_device_id *match;
+	const struct scp_subdomain *sd;
+	const struct scp_soc_data *soc;
+	struct scp *scp;
+	struct genpd_onecell_data *pd_data;
+	int i, ret;
 
-	of_id = of_match_node(of_scpsys_match_tbl, pdev->dev.of_node);
-	if (!of_id || !of_id->data)
-		return -EINVAL;
+	match = of_match_device(of_scpsys_match_tbl, &pdev->dev);
+	soc = (const struct scp_soc_data *)match->data;
 
-	probe = of_id->data;
+	scp = init_scp(pdev, soc->domains, soc->num_domains, &soc->regs);
+	if (IS_ERR(scp))
+		return PTR_ERR(scp);
+
+	mtk_register_power_domains(pdev, scp, soc->num_domains);
+
+	pd_data = &scp->pd_data;
+
+	for (i = 0, sd = soc->subdomains ; i < soc->num_subdomains ; i++) {
+		ret = pm_genpd_add_subdomain(pd_data->domains[sd->origin],
+					     pd_data->domains[sd->subdomain]);
+		if (ret && IS_ENABLED(CONFIG_PM))
+			dev_err(&pdev->dev, "Failed to add subdomain: %d\n",
+				ret);
+	}
 
-	return probe(pdev);
+	return 0;
 }
 
 static struct platform_driver scpsys_drv = {
-- 
2.7.4
