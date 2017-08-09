From: <sean.wang-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
Subject: [PATCH 1/2] cpufreq: mediatek: add cleanups with the more generic
 naming
Date: Wed, 9 Aug 2017 18:12:38 +0800
Message-ID: <c658e5aa68d26c645a8ecd58da69576c9fe237c5.1502272372.git.sean.wang@mediatek.com>
References: <cover.1502272372.git.sean.wang@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mediatek-bounces+glpam-linux-mediatek=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
In-Reply-To: <cover.1502272372.git.sean.wang-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-mediatek>,
 <mailto:linux-mediatek-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-mediatek/>
List-Post: <mailto:linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Help: <mailto:linux-mediatek-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-mediatek>,
 <mailto:linux-mediatek-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=subscribe>
Sender: "Linux-mediatek" <linux-mediatek-bounces-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
Errors-To: linux-mediatek-bounces+glpam-linux-mediatek=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org, viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, matthias.bgg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, jdelvare-l3A5Bk7waGM@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
Cc: Sean Wang <sean.wang-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-pm@vger.kernel.org

From: Sean Wang <sean.wang-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>

Since more MediaTek SoCs can be supported with the cpufreq driver and not
limited to MT8173, a couple of cleanups are done here with renaming those
functions and related structures with "mtk" instead of "mt8173".

Signed-off-by: Sean Wang <sean.wang-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
---
 drivers/cpufreq/mediatek-cpufreq.c | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/drivers/cpufreq/mediatek-cpufreq.c b/drivers/cpufreq/mediatek-cpufreq.c
index 008e088..9fa9291 100644
--- a/drivers/cpufreq/mediatek-cpufreq.c
+++ b/drivers/cpufreq/mediatek-cpufreq.c
@@ -507,7 +507,7 @@ static int mtk_cpufreq_exit(struct cpufreq_policy *policy)
 	return 0;
 }
 
-static struct cpufreq_driver mt8173_cpufreq_driver = {
+static struct cpufreq_driver mtk_cpufreq_driver = {
 	.flags = CPUFREQ_STICKY | CPUFREQ_NEED_INITIAL_FREQ_CHECK |
 		 CPUFREQ_HAVE_GOVERNOR_PER_POLICY,
 	.verify = cpufreq_generic_frequency_table_verify,
@@ -520,7 +520,7 @@ static struct cpufreq_driver mt8173_cpufreq_driver = {
 	.attr = cpufreq_generic_attr,
 };
 
-static int mt8173_cpufreq_probe(struct platform_device *pdev)
+static int mtk_cpufreq_probe(struct platform_device *pdev)
 {
 	struct mtk_cpu_dvfs_info *info, *tmp;
 	int cpu, ret;
@@ -547,7 +547,7 @@ static int mt8173_cpufreq_probe(struct platform_device *pdev)
 		list_add(&info->list_head, &dvfs_info_list);
 	}
 
-	ret = cpufreq_register_driver(&mt8173_cpufreq_driver);
+	ret = cpufreq_register_driver(&mtk_cpufreq_driver);
 	if (ret) {
 		dev_err(&pdev->dev, "failed to register mtk cpufreq driver\n");
 		goto release_dvfs_info_list;
@@ -564,15 +564,15 @@ static int mt8173_cpufreq_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static struct platform_driver mt8173_cpufreq_platdrv = {
+static struct platform_driver mtk_cpufreq_platdrv = {
 	.driver = {
-		.name	= "mt8173-cpufreq",
+		.name	= "mtk-cpufreq",
 	},
-	.probe		= mt8173_cpufreq_probe,
+	.probe		= mtk_cpufreq_probe,
 };
 
 /* List of machines supported by this driver */
-static const struct of_device_id mt8173_cpufreq_machines[] __initconst = {
+static const struct of_device_id mtk_cpufreq_machines[] __initconst = {
 	{ .compatible = "mediatek,mt2701", },
 	{ .compatible = "mediatek,mt7623", },
 	{ .compatible = "mediatek,mt817x", },
@@ -582,7 +582,7 @@ static const struct of_device_id mt8173_cpufreq_machines[] __initconst = {
 	{ }
 };
 
-static int __init mt8173_cpufreq_driver_init(void)
+static int __init mtk_cpufreq_driver_init(void)
 {
 	struct device_node *np;
 	const struct of_device_id *match;
@@ -593,14 +593,14 @@ static int __init mt8173_cpufreq_driver_init(void)
 	if (!np)
 		return -ENODEV;
 
-	match = of_match_node(mt8173_cpufreq_machines, np);
+	match = of_match_node(mtk_cpufreq_machines, np);
 	of_node_put(np);
 	if (!match) {
-		pr_warn("Machine is not compatible with mt8173-cpufreq\n");
+		pr_warn("Machine is not compatible with mtk-cpufreq\n");
 		return -ENODEV;
 	}
 
-	err = platform_driver_register(&mt8173_cpufreq_platdrv);
+	err = platform_driver_register(&mtk_cpufreq_platdrv);
 	if (err)
 		return err;
 
@@ -610,7 +610,7 @@ static int __init mt8173_cpufreq_driver_init(void)
 	 * and the device registration codes are put here to handle defer
 	 * probing.
 	 */
-	pdev = platform_device_register_simple("mt8173-cpufreq", -1, NULL, 0);
+	pdev = platform_device_register_simple("mtk-cpufreq", -1, NULL, 0);
 	if (IS_ERR(pdev)) {
 		pr_err("failed to register mtk-cpufreq platform device\n");
 		return PTR_ERR(pdev);
@@ -618,4 +618,4 @@ static int __init mt8173_cpufreq_driver_init(void)
 
 	return 0;
 }
-device_initcall(mt8173_cpufreq_driver_init);
+device_initcall(mtk_cpufreq_driver_init);
-- 
2.7.4
