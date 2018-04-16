From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: [PATCH 02/14] thermal: exynos: Propagate error value from
 tmu_read()
Date: Mon, 16 Apr 2018 12:11:53 +0200
Message-ID: <1523873525-23718-3-git-send-email-b.zolnierkie@samsung.com>
References: <1523873525-23718-1-git-send-email-b.zolnierkie@samsung.com>
        <CGME20180416101350epcas1p46d9415458ec463afb2a071a9f765f0ed@epcas1p4.samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <1523873525-23718-1-git-send-email-b.zolnierkie@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Eduardo Valentin <edubezval@gmail.com>
Cc: Zhang Rui <rui.zhang@intel.com>, Krzysztof Kozlowski <krzk@kernel.org>, Kukjin Kim <kgene@kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, linux-samsung-soc@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, b.zolnierkie@samsung.com, Marek Szyprowski <m.szyprowski@samsung.com>
List-Id: linux-pm@vger.kernel.org

From: Marek Szyprowski <m.szyprowski@samsung.com>

tmu_read() in case of Exynos4210 might return error for out of bound
values. Current code ignores such value, what leads to reporting critical
temperature value. Add proper error code propagation to exynos_get_temp()
function.

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
CC: stable@vger.kernel.org # v4.6+
Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
---
 drivers/thermal/samsung/exynos_tmu.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/thermal/samsung/exynos_tmu.c b/drivers/thermal/samsung/exynos_tmu.c
index 986cbd0..ac83f72 100644
--- a/drivers/thermal/samsung/exynos_tmu.c
+++ b/drivers/thermal/samsung/exynos_tmu.c
@@ -892,6 +892,7 @@ static void exynos7_tmu_control(struct platform_device *pdev, bool on)
 static int exynos_get_temp(void *p, int *temp)
 {
 	struct exynos_tmu_data *data = p;
+	int value, ret = 0;
 
 	if (!data || !data->tmu_read || !data->enabled)
 		return -EINVAL;
@@ -899,12 +900,16 @@ static int exynos_get_temp(void *p, int *temp)
 	mutex_lock(&data->lock);
 	clk_enable(data->clk);
 
-	*temp = code_to_temp(data, data->tmu_read(data)) * MCELSIUS;
+	value = data->tmu_read(data);
+	if (value < 0)
+		ret = value;
+	else
+		*temp = code_to_temp(data, value) * MCELSIUS;
 
 	clk_disable(data->clk);
 	mutex_unlock(&data->lock);
 
-	return 0;
+	return ret;
 }
 
 #ifdef CONFIG_THERMAL_EMULATION
-- 
1.9.1
