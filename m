From: Marek Szyprowski <m.szyprowski@samsung.com>
Subject: [PATCH 4/4] soc: samsung: pm_domains: Provide real name for all
 supported domains
Date: Fri, 27 Jan 2017 11:47:52 +0100
Message-ID: <1485514072-29502-5-git-send-email-m.szyprowski@samsung.com>
References: <1485514072-29502-1-git-send-email-m.szyprowski@samsung.com>
 <CGME20170127104802eucas1p121f5f44f8a047ad9b5118a37f66ea032@eucas1p1.samsung.com>
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-reply-to: <1485514072-29502-1-git-send-email-m.szyprowski@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: linux-samsung-soc@vger.kernel.org, linux-pm@vger.kernel.org
Cc: Marek Szyprowski <m.szyprowski@samsung.com>, Sylwester Nawrocki <s.nawrocki@samsung.com>, Krzysztof Kozlowski <krzk@kernel.org>, Javier Martinez Canillas <javier@osg.samsung.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>, Inki Dae <inki.dae@samsung.com>
List-Id: linux-pm@vger.kernel.org

Device tree nodes for each power domain should use generic "power-domain"
name, so using it as a domain name doesn't give much benefits. This patch
adds human readable names for all supported domains, what makes debugging
much easier.

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
 drivers/soc/samsung/pm_domains.c | 125 ++++++++++++++++++++++++++++++++++++++-
 1 file changed, 123 insertions(+), 2 deletions(-)

diff --git a/drivers/soc/samsung/pm_domains.c b/drivers/soc/samsung/pm_domains.c
index 5a0a46bcbe18..67d385eaab63 100644
--- a/drivers/soc/samsung/pm_domains.c
+++ b/drivers/soc/samsung/pm_domains.c
@@ -30,6 +30,17 @@ struct exynos_pm_domain_config {
 	u32 local_pwr_cfg;
 };
 
+struct exynos_pm_domain_data {
+	const char *name;
+	u32 base;
+};
+
+struct exynos_pm_domain_soc_data {
+	const char *compatible;
+	unsigned int nr_domains;
+	const struct exynos_pm_domain_data *domains;
+};
+
 /*
  * Exynos specific wrapper around the generic power domain
  */
@@ -123,6 +134,91 @@ static int exynos_pd_power_off(struct generic_pm_domain *domain)
 	return exynos_pd_power(domain, false);
 }
 
+static const struct exynos_pm_domain_data exynos4210_domains[] __initconst = {
+	{ "LCD1",	0x10023CA0 },
+};
+
+static const struct exynos_pm_domain_data exynos4412_domains[] __initconst = {
+	{ "CAM",	0x10023C00 },
+	{ "TV",		0x10023C20 },
+	{ "MFC",	0x10023C40 },
+	{ "G3D",	0x10023C60 },
+	{ "LCD0",	0x10023C80 },
+	{ "ISP",	0x10023CA0 },
+	{ "GPS",	0x10023CE0 },
+	{ "GPS alive",	0x10023D00 },
+};
+
+static const struct exynos_pm_domain_data exynos5250_domains[] __initconst = {
+	{ "GSCL",	0x10044000 },
+	{ "ISP",	0x10044020 },
+	{ "MFC",	0x10044040 },
+	{ "G3D",	0x10044060 },
+	{ "DISP1",	0x100440A0 },
+	{ "MAU",	0x100440C0 },
+};
+
+static const struct exynos_pm_domain_data exynos542x_domains[] __initconst = {
+	{ "SCALER",	0x10044000 },
+	{ "ISP",	0x10044020 },
+	{ "MFC",	0x10044060 },
+	{ "G3D",	0x10044080 },
+	{ "DISP1",	0x100440C0 },
+	{ "MAU",	0x100440E0 },
+	{ "G2D",	0x10044100 },
+	{ "MSCL",	0x10044120 },
+	{ "FSYS",	0x10044140 },
+	{ "PERIC",	0x100441A0 },
+	{ "CAM",	0x10045100 },
+};
+
+static const struct exynos_pm_domain_data exynos5433_domains[] __initconst = {
+	{ "GSCL",	0x105c4000 },
+	{ "MSCL",	0x105c4040 },
+	{ "DISP",	0x105c4080 },
+	{ "MFC",	0x105c4180 },
+	{ "CAM0",	0x105c4020 },
+	{ "CAM1",	0x105c40a0 },
+	{ "ISP",	0x105c4140 },
+	{ "G2D",	0x105c4120 },
+	{ "G3D",	0x105c4060 },
+	{ "AUD",	0x105c40c0 },
+	{ "FSYS",	0x105c40e0 },
+	{ "HEVC",	0x105c41c0 },
+};
+
+static const struct exynos_pm_domain_soc_data soc_domains_data[] __initconst = {
+	{ /* Exynos3250 uses a subset of 4412 domains */
+		.compatible = "samsung,exynos3250",
+		.nr_domains = ARRAY_SIZE(exynos4412_domains),
+		.domains = exynos4412_domains,
+	}, { /* first check samsung,exynos4210 to detect LCD1 domain */
+		.compatible = "samsung,exynos4210",
+		.nr_domains = ARRAY_SIZE(exynos4210_domains),
+		.domains = exynos4210_domains,
+	}, { /* remaining domains for Exynos4210 and 4412 */
+		.compatible = "samsung,exynos4",
+		.nr_domains = ARRAY_SIZE(exynos4412_domains),
+		.domains = exynos4412_domains
+	}, {
+		.compatible = "samsung,exynos5250",
+		.nr_domains = ARRAY_SIZE(exynos5250_domains),
+		.domains = exynos5250_domains,
+	}, {
+		.compatible = "samsung,exynos5420",
+		.nr_domains = ARRAY_SIZE(exynos542x_domains),
+		.domains = exynos542x_domains,
+	}, {
+		.compatible = "samsung,exynos5800",
+		.nr_domains = ARRAY_SIZE(exynos542x_domains),
+		.domains = exynos542x_domains,
+	}, {
+		.compatible = "samsung,exynos5433",
+		.nr_domains = ARRAY_SIZE(exynos5433_domains),
+		.domains = exynos5433_domains,
+	},
+};
+
 static const struct exynos_pm_domain_config exynos4210_cfg __initconst = {
 	.local_pwr_cfg		= 0x7,
 };
@@ -142,6 +238,32 @@ static int exynos_pd_power_off(struct generic_pm_domain *domain)
 	{ },
 };
 
+static __init const char *exynos_get_domain_name(struct device_node *np)
+{
+	const struct exynos_pm_domain_soc_data *soc = soc_domains_data;
+	const __be32 *reg;
+	u64 addr;
+	int i, j;
+
+
+	reg = of_get_property(np, "reg", NULL);
+	if (!reg || (addr = of_translate_address(np, reg)) == OF_BAD_ADDR)
+		goto not_found;
+
+	for (i = 0; i < ARRAY_SIZE(soc_domains_data); i++, soc++) {
+		if (!of_machine_is_compatible(soc->compatible))
+			continue;
+
+		for (j = 0; j < soc->nr_domains; j++) {
+			if (soc->domains[j].base == addr)
+				return kstrdup_const(soc->domains[j].name,
+						     GFP_KERNEL);
+		}
+	}
+not_found:
+	return kstrdup_const(strrchr(np->full_name, '/') + 1, GFP_KERNEL);
+}
+
 static __init int exynos4_pm_init_power_domain(void)
 {
 	struct device_node *np;
@@ -159,8 +281,7 @@ static __init int exynos4_pm_init_power_domain(void)
 			of_node_put(np);
 			return -ENOMEM;
 		}
-		pd->pd.name = kstrdup_const(strrchr(np->full_name, '/') + 1,
-					    GFP_KERNEL);
+		pd->pd.name = exynos_get_domain_name(np);
 		if (!pd->pd.name) {
 			kfree(pd);
 			of_node_put(np);
-- 
1.9.1
