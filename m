From: Pankaj Dubey <pankaj.dubey@samsung.com>
Subject: [PATCH v6 2/9] ARM: EXYNOS: Fix potential NULL pointer access in
 exynos_sys_powerdown_conf
Date: Tue, 17 Nov 2015 11:35:44 +0530
Message-ID: <1447740351-14246-3-git-send-email-pankaj.dubey@samsung.com>
References: <1447740351-14246-1-git-send-email-pankaj.dubey@samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <1447740351-14246-1-git-send-email-pankaj.dubey@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org
Cc: kgene.kim@samsung.com, k.kozlowski@samsung.com, thomas.ab@samsung.com, amitdanielk@gmail.com, olof@lixom.net, khilman@linaro.org, arnd@arndb.de, Pankaj Dubey <pankaj.dubey@samsung.com>
List-Id: linux-pm@vger.kernel.org

If no platform devices binded to the driver but driver itself loaded and
exynos_sys_powerdown_conf is called from
arch/arm/mach-exynos/{suspend.c, pm.c} it will result in NULL pointer access,
to prevent this added check on pmu_context for NULL.

Signed-off-by: Pankaj Dubey <pankaj.dubey@samsung.com>
Reviewed-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
---
 arch/arm/mach-exynos/pmu.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-exynos/pmu.c b/arch/arm/mach-exynos/pmu.c
index 64ea7d6..d40f7e9 100644
--- a/arch/arm/mach-exynos/pmu.c
+++ b/arch/arm/mach-exynos/pmu.c
@@ -749,8 +749,12 @@ static void exynos5_powerdown_conf(enum sys_powerdown mode)
 void exynos_sys_powerdown_conf(enum sys_powerdown mode)
 {
 	unsigned int i;
+	const struct exynos_pmu_data *pmu_data;
+
+	if (!pmu_context)
+		return;
 
-	const struct exynos_pmu_data *pmu_data = pmu_context->pmu_data;
+	pmu_data = pmu_context->pmu_data;
 
 	if (pmu_data->powerdown_conf)
 		pmu_data->powerdown_conf(mode);
-- 
2.4.5
