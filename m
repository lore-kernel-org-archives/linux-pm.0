From: Caesar Wang <wxt@rock-chips.com>
Subject: [PATCH 3/5] thermal: rockchip: fixes invalid temperature case
Date: Tue, 22 Nov 2016 20:34:46 +0800
Message-ID: <1479818088-6007-4-git-send-email-wxt@rock-chips.com>
References: <1479818088-6007-1-git-send-email-wxt@rock-chips.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1479818088-6007-1-git-send-email-wxt@rock-chips.com>
Sender: linux-kernel-owner@vger.kernel.org
To: edubezval@gmail.com, rui.zhang@intel.com
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, linux-rockchip@lists.infradead.org, briannorris@chromium.org, heiko@sntech.de, smbarber@chromium.org, Caesar Wang <wxt@rock-chips.com>
List-Id: linux-pm@vger.kernel.org

The temp_to_code function will return 0 when we set the trip points value
or valid temperature.
This patch will prevent this case happening.

Signed-off-by: Caesar Wang <wxt@rock-chips.com>
---

 drivers/thermal/rockchip_thermal.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/thermal/rockchip_thermal.c b/drivers/thermal/rockchip_thermal.c
index 766486f..535f1fa 100644
--- a/drivers/thermal/rockchip_thermal.c
+++ b/drivers/thermal/rockchip_thermal.c
@@ -401,17 +401,15 @@ static u32 rk_tsadcv2_temp_to_code(const struct chip_tsadc_table *table,
 				   int temp)
 {
 	int high, low, mid;
-	u32 error = 0;
+	u32 error = table->data_mask;
 
 	low = 0;
 	high = table->length - 1;
 	mid = (high + low) / 2;
 
 	/* Return mask code data when the temp is over table range */
-	if (temp < table->id[low].temp || temp > table->id[high].temp) {
-		error = table->data_mask;
+	if (temp < table->id[low].temp || temp > table->id[high].temp)
 		goto exit;
-	}
 
 	while (low <= high) {
 		if (temp == table->id[mid].temp)
-- 
2.7.4
