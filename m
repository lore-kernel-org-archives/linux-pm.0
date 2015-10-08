From: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Subject: [PATCH 3/5] thermal: exynos: Use IS_ERR() because regulator cannot be
 NULL
Date: Thu, 08 Oct 2015 14:34:04 +0900
Message-ID: <1444282446-6419-3-git-send-email-k.kozlowski@samsung.com>
References: <1444282446-6419-1-git-send-email-k.kozlowski@samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <1444282446-6419-1-git-send-email-k.kozlowski@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Lukasz Majewski <l.majewski@samsung.com>, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, Kukjin Kim <kgene@kernel.org>, Krzysztof Kozlowski <k.kozlowski@samsung.com>, linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

The NULL check in probe's error path is not needed because in that time
the regulator cannot be NULL (regulator_get() returns valid pointer or
ERR_PTR).

Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
---
 drivers/thermal/samsung/exynos_tmu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/thermal/samsung/exynos_tmu.c b/drivers/thermal/samsung/exynos_tmu.c
index bc71a61f0c4a..eac6aebf82f3 100644
--- a/drivers/thermal/samsung/exynos_tmu.c
+++ b/drivers/thermal/samsung/exynos_tmu.c
@@ -1396,7 +1396,7 @@ err_clk_sec:
 	if (!IS_ERR(data->clk_sec))
 		clk_unprepare(data->clk_sec);
 err_sensor:
-	if (!IS_ERR_OR_NULL(data->regulator))
+	if (!IS_ERR(data->regulator))
 		regulator_disable(data->regulator);
 
 	return ret;
-- 
1.9.1
