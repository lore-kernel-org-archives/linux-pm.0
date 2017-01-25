From: Marek Szyprowski <m.szyprowski@samsung.com>
Subject: [PATCH 1/8] soc: samsung: pm_domains: Add new exynos5433 compatible
Date: Wed, 25 Jan 2017 12:55:35 +0100
Message-ID: <1485345342-3273-2-git-send-email-m.szyprowski@samsung.com>
References: <1485345342-3273-1-git-send-email-m.szyprowski@samsung.com>
 <CGME20170125115559eucas1p22d097adf456c6854c73d1bac9632776c@eucas1p2.samsung.com>
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-reply-to: <1485345342-3273-1-git-send-email-m.szyprowski@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: linux-samsung-soc@vger.kernel.org, linux-pm@vger.kernel.org
Cc: Marek Szyprowski <m.szyprowski@samsung.com>, Sylwester Nawrocki <s.nawrocki@samsung.com>, Krzysztof Kozlowski <krzk@kernel.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>, Inki Dae <inki.dae@samsung.com>, Jonghwa Lee <jonghwa3.lee@samsung.com>
List-Id: linux-pm@vger.kernel.org

From: Chanwoo Choi <cw00.choi@samsung.com>

This patch adds the new compatible string for exynos5433 because the exynos5433
use the '0xf' value to turn on and off instead of '0x7'.

Signed-off-by: Jonghwa Lee <jonghwa3.lee@samsung.com>
Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
 Documentation/devicetree/bindings/power/pd-samsung.txt | 1 +
 drivers/soc/samsung/pm_domains.c                       | 7 +++++++
 2 files changed, 8 insertions(+)

diff --git a/Documentation/devicetree/bindings/power/pd-samsung.txt b/Documentation/devicetree/bindings/power/pd-samsung.txt
index 76df656be618..fb08c8d62733 100644
--- a/Documentation/devicetree/bindings/power/pd-samsung.txt
+++ b/Documentation/devicetree/bindings/power/pd-samsung.txt
@@ -6,6 +6,7 @@ to gate power to one or more peripherals on the processor.
 Required Properties:
 - compatible: should be one of the following.
     * samsung,exynos4210-pd - for exynos4210 type power domain.
+    * samsung,exynos5433-pd - for exynos5433 type power domain.
 - reg: physical base address of the controller and length of memory mapped
     region.
 - #power-domain-cells: number of cells in power domain specifier;
diff --git a/drivers/soc/samsung/pm_domains.c b/drivers/soc/samsung/pm_domains.c
index 7112004b8032..15bad1543409 100644
--- a/drivers/soc/samsung/pm_domains.c
+++ b/drivers/soc/samsung/pm_domains.c
@@ -128,10 +128,17 @@ static int exynos_pd_power_off(struct generic_pm_domain *domain)
 	.local_pwr_cfg		= 0x7,
 };
 
+static const struct exynos_pm_domain_config exynos5433_cfg __initconst = {
+	.local_pwr_cfg		= 0xf,
+};
+
 static const struct of_device_id exynos_pm_domain_of_match[] __initconst = {
 	{
 		.compatible = "samsung,exynos4210-pd",
 		.data = &exynos4210_cfg,
+	}, {
+		.compatible = "samsung,exynos5433-pd",
+		.data = &exynos5433_cfg,
 	},
 	{ },
 };
-- 
1.9.1
