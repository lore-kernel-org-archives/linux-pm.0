From: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Subject: [PATCH] thermal: exynos: Disable the regulator on probe failure
Date: Mon, 08 Jun 2015 10:35:49 +0900
Message-ID: <1433727349-23330-1-git-send-email-k.kozlowski@samsung.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout4.w1.samsung.com ([210.118.77.14]:27622 "EHLO
	mailout4.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750872AbbFHBgI (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sun, 7 Jun 2015 21:36:08 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Lukasz Majewski <l.majewski@samsung.com>, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, Kukjin Kim <kgene@kernel.org>, Krzysztof Kozlowski <k.kozlowski@samsung.com>, linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org

During probe the regulator (if present) was enabled but not disabled in
case of failure. So an unsuccessful probe lead to enabling the
regulator which was actually not needed because the device was not
enabled.

Additionally each deferred probe lead to increase of regulator enable
count so it would not be effectively disabled during removal of the
device.

Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Fixes: 498d22f616f6 ("thermal: exynos: Support for TMU regulator defined at device tree")
Cc: <stable@vger.kernel.org>

---

I am not entirely convinced that this should go to stable. Leaving a
regulator enabled in case of probe failure (no exynos TMU device) or
after deferred probe (regulator won't be disabled during device removal)
is not a critical issue, just leaks power.
---
 drivers/thermal/samsung/exynos_tmu.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/thermal/samsung/exynos_tmu.c b/drivers/thermal/samsung/exynos_tmu.c
index 531f4b179871..13c3aceed19d 100644
--- a/drivers/thermal/samsung/exynos_tmu.c
+++ b/drivers/thermal/samsung/exynos_tmu.c
@@ -1392,6 +1392,8 @@ err_clk_sec:
 	if (!IS_ERR(data->clk_sec))
 		clk_unprepare(data->clk_sec);
 err_sensor:
+	if (!IS_ERR_OR_NULL(data->regulator))
+		regulator_disable(data->regulator);
 	thermal_zone_of_sensor_unregister(&pdev->dev, data->tzd);
 
 	return ret;
-- 
1.9.1

