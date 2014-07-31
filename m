From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: [PATCH v3 5/8] thermal: exynos: simplify temp_to_code() and
 code_to_temp()
Date: Thu, 31 Jul 2014 19:11:03 +0200
Message-ID: <1406826667-2289-6-git-send-email-b.zolnierkie@samsung.com>
References: <1406826667-2289-1-git-send-email-b.zolnierkie@samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <1406826667-2289-1-git-send-email-b.zolnierkie@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Eduardo Valentin <eduardo.valentin@ti.com>
Cc: Zhang Rui <rui.zhang@intel.com>, Amit Daniel Kachhap <amit.daniel@samsung.com>, Tomasz Figa <t.figa@samsung.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Kyungmin Park <kyungmin.park@samsung.com>, linux-samsung-soc@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, b.zolnierkie@samsung.com
List-Id: linux-pm@vger.kernel.org

* Remove dead temp check from temp_to_code() (this function users
  in exynos_tmu_initialize() always pass correct temperatures and
  exynos_tmu_set_emulation() returns early for EXYNOS4210 because
  TMU_SUPPORT_EMULATION flag is not set on this SoC).

* Move temp_code check from code_to_temp() to exynos_tmu_read()
  (code_to_temp() only user).

There should be no functional changes caused by this patch.

Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Acked-by: Kyungmin Park <kyungmin.park@samsung.com>
Reviewed-by: Amit Daniel Kachhap <amit.daniel@samsung.com>
---
 drivers/thermal/samsung/exynos_tmu.c | 28 +++++++++++-----------------
 1 file changed, 11 insertions(+), 17 deletions(-)

diff --git a/drivers/thermal/samsung/exynos_tmu.c b/drivers/thermal/samsung/exynos_tmu.c
index 15574cc..aa4d4fd 100644
--- a/drivers/thermal/samsung/exynos_tmu.c
+++ b/drivers/thermal/samsung/exynos_tmu.c
@@ -77,13 +77,6 @@ static int temp_to_code(struct exynos_tmu_data *data, u8 temp)
 	struct exynos_tmu_platform_data *pdata = data->pdata;
 	int temp_code;
 
-	if (data->soc == SOC_ARCH_EXYNOS4210)
-		/* temp should range between 25 and 125 */
-		if (temp < 25 || temp > 125) {
-			temp_code = -EINVAL;
-			goto out;
-		}
-
 	switch (pdata->cal_type) {
 	case TYPE_TWO_POINT_TRIMMING:
 		temp_code = (temp - pdata->first_point_trim) *
@@ -98,7 +91,7 @@ static int temp_to_code(struct exynos_tmu_data *data, u8 temp)
 		temp_code = temp + pdata->default_temp_offset;
 		break;
 	}
-out:
+
 	return temp_code;
 }
 
@@ -111,13 +104,6 @@ static int code_to_temp(struct exynos_tmu_data *data, u8 temp_code)
 	struct exynos_tmu_platform_data *pdata = data->pdata;
 	int temp;
 
-	if (data->soc == SOC_ARCH_EXYNOS4210)
-		/* temp_code should range between 75 and 175 */
-		if (temp_code < 75 || temp_code > 175) {
-			temp = -ENODATA;
-			goto out;
-		}
-
 	switch (pdata->cal_type) {
 	case TYPE_TWO_POINT_TRIMMING:
 		temp = (temp_code - data->temp_error1) *
@@ -132,7 +118,7 @@ static int code_to_temp(struct exynos_tmu_data *data, u8 temp_code)
 		temp = temp_code - pdata->default_temp_offset;
 		break;
 	}
-out:
+
 	return temp;
 }
 
@@ -346,8 +332,16 @@ static int exynos_tmu_read(struct exynos_tmu_data *data)
 	clk_enable(data->clk);
 
 	temp_code = readb(data->base + reg->tmu_cur_temp);
-	temp = code_to_temp(data, temp_code);
 
+	if (data->soc == SOC_ARCH_EXYNOS4210)
+		/* temp_code should range between 75 and 175 */
+		if (temp_code < 75 || temp_code > 175) {
+			temp = -ENODATA;
+			goto out;
+		}
+
+	temp = code_to_temp(data, temp_code);
+out:
 	clk_disable(data->clk);
 	mutex_unlock(&data->lock);
 
-- 
1.8.2.3
