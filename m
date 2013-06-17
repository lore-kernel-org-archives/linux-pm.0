From: Tomasz Figa <t.figa@samsung.com>
Subject: [PATCH v2 29/38] thermal: exynos: Support both Exynos4x12 SoCs
Date: Mon, 17 Jun 2013 18:34:14 +0200
Message-ID: <1371486863-12398-30-git-send-email-t.figa@samsung.com>
References: <1371486863-12398-1-git-send-email-t.figa@samsung.com>
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-reply-to: <1371486863-12398-1-git-send-email-t.figa@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: linux-samsung-soc@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, Kukjin Kim <kgene.kim@samsung.com>, Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>, Marek Szyprowski <m.szyprowski@samsung.com>, Sylwester Nawrocki <s.nawrocki@samsung.com>, Thomas Abraham <thomas.abraham@linaro.org>, Tomasz Figa <t.figa@samsung.com>, linux-pm@vger.kernel.org, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <eduardo.valentin@ti.com>, Kyungmin Park <kyungmin.park@samsung.com>
List-Id: linux-pm@vger.kernel.org

Exynos4212 and Exynos4412 have the same thermal block, so there is no
reason to include support only for Exynos4412 in this driver.

Cc: linux-pm@vger.kernel.org
Cc: Zhang Rui <rui.zhang@intel.com>
Cc: Eduardo Valentin <eduardo.valentin@ti.com>
Signed-off-by: Tomasz Figa <t.figa@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 drivers/thermal/exynos_thermal.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/thermal/exynos_thermal.c b/drivers/thermal/exynos_thermal.c
index 788b1dd..4cbe3ee 100644
--- a/drivers/thermal/exynos_thermal.c
+++ b/drivers/thermal/exynos_thermal.c
@@ -817,7 +817,8 @@ static struct exynos_tmu_platform_data const exynos4210_default_tmu_data = {
 #define EXYNOS4210_TMU_DRV_DATA (NULL)
 #endif
 
-#if defined(CONFIG_SOC_EXYNOS5250) || defined(CONFIG_SOC_EXYNOS4412)
+#if defined(CONFIG_SOC_EXYNOS5250) || defined(CONFIG_SOC_EXYNOS4412) || \
+	defined(CONFIG_SOC_EXYNOS4212)
 static struct exynos_tmu_platform_data const exynos_default_tmu_data = {
 	.threshold_falling = 10,
 	.trigger_levels[0] = 85,
-- 
1.8.2.1
