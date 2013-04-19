From: Lukasz Majewski <l.majewski@samsung.com>
Subject: [PATCH 5/6] thermal:exynos4: Enable support for Exynos4412 SoCs
Date: Fri, 19 Apr 2013 18:38:12 +0200
Message-ID: <1366389493-8239-6-git-send-email-l.majewski@samsung.com>
References: <1366389493-8239-1-git-send-email-l.majewski@samsung.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:36199 "EHLO
	mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030932Ab3DSQil (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 19 Apr 2013 12:38:41 -0400
In-reply-to: <1366389493-8239-1-git-send-email-l.majewski@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Kukjin Kim <kgene.kim@samsung.com>
Cc: Mike Turquette <mturquette@linaro.org>, Zhang Rui <rui.zhang@intel.com>, devicetree-discuss@lists.ozlabs.org, linux-samsung-soc@vger.kernel.org, Linux PM list <linux-pm@vger.kernel.org>, Amit Daniel Kachhap <amit.kachhap@linaro.org>, Lukasz Majewski <l.majewski@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>

Enable TMU support for Exynos4412 based target with device tree.

Signed-off-by: Lukasz Majewski <l.majewski@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 drivers/thermal/exynos_thermal.c |    4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/thermal/exynos_thermal.c b/drivers/thermal/exynos_thermal.c
index e922fa4..f54066d 100644
--- a/drivers/thermal/exynos_thermal.c
+++ b/drivers/thermal/exynos_thermal.c
@@ -819,6 +819,10 @@ static const struct of_device_id exynos_tmu_match[] = {
 		.data = (void *)EXYNOS4210_TMU_DRV_DATA,
 	},
 	{
+		.compatible = "samsung,exynos4412-tmu",
+		.data = (void *)EXYNOS_TMU_DRV_DATA,
+	},
+	{
 		.compatible = "samsung,exynos5250-tmu",
 		.data = (void *)EXYNOS_TMU_DRV_DATA,
 	},
-- 
1.7.10.4

