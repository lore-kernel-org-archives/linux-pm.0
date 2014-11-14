From: Abhilash Kesavan <a.kesavan@samsung.com>
Subject: [PATCH 3/4] thermal: exynos: modify the prototype for code_to_temp
 function
Date: Fri, 14 Nov 2014 16:48:01 +0530
Message-ID: <1415963882-3460-4-git-send-email-a.kesavan@samsung.com>
References: <1415963882-3460-1-git-send-email-a.kesavan@samsung.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:51854 "EHLO
	mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964995AbaKNLUQ (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 14 Nov 2014 06:20:16 -0500
Received: from epcpsbgr3.samsung.com
 (u143.gpu120.samsung.co.kr [203.254.230.143])
 by mailout4.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0NF1006KY0TROL50@mailout4.samsung.com> for
 linux-pm@vger.kernel.org; Fri, 14 Nov 2014 20:20:15 +0900 (KST)
In-reply-to: <1415963882-3460-1-git-send-email-a.kesavan@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rui.zhang@intel.com, edubezval@gmail.com, linux-pm@vger.kernel.org
Cc: b.zolnierkie@samsung.com, amit.daniel@samsung.com, kesavan.abhilash@gmail.com

Exynos7 has a 9 bit code associated with a temperature as against
8 bits used in earlier SoCs. Modify the code_to_temp function to
support this.

Signed-off-by: Abhilash Kesavan <a.kesavan@samsung.com>
---
 drivers/thermal/samsung/exynos_tmu.c |    9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/thermal/samsung/exynos_tmu.c b/drivers/thermal/samsung/exynos_tmu.c
index 49d3bcb..9695638 100644
--- a/drivers/thermal/samsung/exynos_tmu.c
+++ b/drivers/thermal/samsung/exynos_tmu.c
@@ -64,7 +64,7 @@ struct exynos_tmu_data {
 	struct work_struct irq_work;
 	struct mutex lock;
 	struct clk *clk, *clk_sec, *sclk;
-	u8 temp_error1, temp_error2;
+	u16 temp_error1, temp_error2;
 	struct regulator *regulator;
 	struct thermal_sensor_conf *reg_conf;
 };
@@ -100,7 +100,7 @@ static int temp_to_code(struct exynos_tmu_data *data, u8 temp)
  * Calculate a temperature value from a temperature code.
  * The unit of the temperature is degree Celsius.
  */
-static int code_to_temp(struct exynos_tmu_data *data, u8 temp_code)
+static int code_to_temp(struct exynos_tmu_data *data, u16 temp_code)
 {
 	struct exynos_tmu_platform_data *pdata = data->pdata;
 	int temp;
@@ -336,13 +336,14 @@ static int exynos_tmu_read(struct exynos_tmu_data *data)
 {
 	struct exynos_tmu_platform_data *pdata = data->pdata;
 	const struct exynos_tmu_registers *reg = pdata->registers;
-	u8 temp_code;
+	u16 temp_code;
 	int temp;
 
 	mutex_lock(&data->lock);
 	clk_enable(data->clk);
 
-	temp_code = readb(data->base + reg->tmu_cur_temp);
+	temp_code = readw(data->base + reg->tmu_cur_temp);
+	temp_code &= reg->triminfo_mask;
 
 	if (data->soc == SOC_ARCH_EXYNOS4210)
 		/* temp_code should range between 75 and 175 */
-- 
1.7.9.5

