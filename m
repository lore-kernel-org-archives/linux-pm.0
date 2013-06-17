From: Tomasz Figa <t.figa@samsung.com>
Subject: [PATCH v2 33/38] thermal: exynos: Remove check for SOC_EXYNOS4412
Date: Mon, 17 Jun 2013 18:34:18 +0200
Message-ID: <1371486863-12398-34-git-send-email-t.figa@samsung.com>
References: <1371486863-12398-1-git-send-email-t.figa@samsung.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout1.w1.samsung.com ([210.118.77.11]:10306 "EHLO
	mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752978Ab3FQQe5 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 17 Jun 2013 12:34:57 -0400
In-reply-to: <1371486863-12398-1-git-send-email-t.figa@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-samsung-soc@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, Kukjin Kim <kgene.kim@samsung.com>, Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>, Marek Szyprowski <m.szyprowski@samsung.com>, Sylwester Nawrocki <s.nawrocki@samsung.com>, Thomas Abraham <thomas.abraham@linaro.org>, Tomasz Figa <t.figa@samsung.com>, linux-pm@vger.kernel.org, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <eduardo.valentin@ti.com>, Kyungmin Park <kyungmin.park@samsung.com>

Since SOC_EXYNOS4412 Kconfig symbol has been removed, it is enough to
check for SOC_EXYNOS4212 for both SoCs from Exynos4x12 series.

Cc: linux-pm@vger.kernel.org
Cc: Zhang Rui <rui.zhang@intel.com>
Cc: Eduardo Valentin <eduardo.valentin@ti.com>
Signed-off-by: Tomasz Figa <t.figa@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 drivers/thermal/exynos_thermal.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/thermal/exynos_thermal.c b/drivers/thermal/exynos_thermal.c
index 4cbe3ee..f88a2ad 100644
--- a/drivers/thermal/exynos_thermal.c
+++ b/drivers/thermal/exynos_thermal.c
@@ -817,8 +817,7 @@ static struct exynos_tmu_platform_data const exynos4210_default_tmu_data = {
 #define EXYNOS4210_TMU_DRV_DATA (NULL)
 #endif
 
-#if defined(CONFIG_SOC_EXYNOS5250) || defined(CONFIG_SOC_EXYNOS4412) || \
-	defined(CONFIG_SOC_EXYNOS4212)
+#if defined(CONFIG_SOC_EXYNOS5250) || defined(CONFIG_SOC_EXYNOS4212)
 static struct exynos_tmu_platform_data const exynos_default_tmu_data = {
 	.threshold_falling = 10,
 	.trigger_levels[0] = 85,
-- 
1.8.2.1

