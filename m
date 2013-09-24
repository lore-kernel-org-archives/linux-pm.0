From: Lukasz Majewski <l.majewski@samsung.com>
Subject: [PATCH 4/6] thermal: exynos: Replace SOC_ARCH_EXYNOS with
 SOC_ARCH_EXYNOS5250
Date: Tue, 24 Sep 2013 10:08:20 +0200
Message-ID: <1380010102-25817-5-git-send-email-l.majewski@samsung.com>
References: <1380010102-25817-1-git-send-email-l.majewski@samsung.com>
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-reply-to: <1380010102-25817-1-git-send-email-l.majewski@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <eduardo.valentin@ti.com>, Amit Daniel Kachhap <amit.daniel@samsung.com>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Linux PM list <linux-pm@vger.kernel.org>, Jonghwa Lee <jonghwa3.lee@samsung.com>, Lukasz Majewski <l.majewski@samsung.com>, Lukasz Majewski <l.majewski@majess.pl>, linux-kernel <linux-kernel@vger.kernel.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Tomasz Figa <t.figa@samsung.com>, Myungjoo Ham <myungjoo.ham@samsung.com>, devicetree@vger.kernel.org, linux-samsung-soc@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

The TMU data definition is now separated to Exynos4412 and Exynos5250.

Now SOC_ARCH_EXYNOS only refers to Exynos5250. Hence the name
SOC_ARCH_EXYNOS has been changed to SOC_ARCH_EXYNOS5250.

Signed-off-by: Lukasz Majewski <l.majewski@samsung.com>
---
 drivers/thermal/samsung/exynos_tmu.c      |    4 ++--
 drivers/thermal/samsung/exynos_tmu.h      |    2 +-
 drivers/thermal/samsung/exynos_tmu_data.c |    2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/thermal/samsung/exynos_tmu.c b/drivers/thermal/samsung/exynos_tmu.c
index 21b89e4..037cd46 100644
--- a/drivers/thermal/samsung/exynos_tmu.c
+++ b/drivers/thermal/samsung/exynos_tmu.c
@@ -632,9 +632,9 @@ static int exynos_tmu_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
-	if (pdata->type == SOC_ARCH_EXYNOS ||
-	    pdata->type == SOC_ARCH_EXYNOS4210 ||
+	if (pdata->type == SOC_ARCH_EXYNOS4210 ||
 	    pdata->type == SOC_ARCH_EXYNOS4412 ||
+	    pdata->type == SOC_ARCH_EXYNOS5250 ||
 	    pdata->type == SOC_ARCH_EXYNOS5440)
 		data->soc = pdata->type;
 	else {
diff --git a/drivers/thermal/samsung/exynos_tmu.h b/drivers/thermal/samsung/exynos_tmu.h
index db37df0..b42ece4 100644
--- a/drivers/thermal/samsung/exynos_tmu.h
+++ b/drivers/thermal/samsung/exynos_tmu.h
@@ -42,7 +42,7 @@ enum calibration_mode {
 enum soc_type {
 	SOC_ARCH_EXYNOS4210 = 1,
 	SOC_ARCH_EXYNOS4412,
-	SOC_ARCH_EXYNOS,
+	SOC_ARCH_EXYNOS5250,
 	SOC_ARCH_EXYNOS5440,
 };
 
diff --git a/drivers/thermal/samsung/exynos_tmu_data.c b/drivers/thermal/samsung/exynos_tmu_data.c
index bd08093..188223f 100644
--- a/drivers/thermal/samsung/exynos_tmu_data.c
+++ b/drivers/thermal/samsung/exynos_tmu_data.c
@@ -183,7 +183,7 @@ struct exynos_tmu_init_data const exynos4412_default_tmu_data = {
 struct exynos_tmu_init_data const exynos5250_default_tmu_data = {
 	.tmu_data = {
 		{ EXYNOS4412_TMU_DATA,
-		.type = SOC_ARCH_EXYNOS,
+		.type = SOC_ARCH_EXYNOS5250,
 		},
 	},
 	.tmu_count = 1,
-- 
1.7.10.4
