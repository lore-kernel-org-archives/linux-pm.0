From: Caesar Wang <wxt@rock-chips.com>
Subject: [PATCH 4/8] thermal: rockchip: fix calculation error for code_to_temp
Date: Wed,  3 Feb 2016 12:12:43 +0800
Message-ID: <1454472767-5767-5-git-send-email-wxt@rock-chips.com>
References: <1454472767-5767-1-git-send-email-wxt@rock-chips.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1454472767-5767-1-git-send-email-wxt@rock-chips.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Heiko Stuebner <heiko@sntech.de>, edubezval@gmail.com
Cc: huangtao@rock-chips.com, linux-rockchip@lists.infradead.org, zhangqing@rock-chips.com, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Caesar Wang <wxt@rock-chips.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Zhang Rui <rui.zhang@intel.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

From: Elaine Zhang <zhangqing@rock-chips.com>

the calculation use a global table, not their own table.
so adapt the table to the correct one.

Signed-off-by: Elaine Zhang <zhangqing@rock-chips.com>
Signed-off-by: Caesar Wang <wxt@rock-chips.com>
---

 drivers/thermal/rockchip_thermal.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/thermal/rockchip_thermal.c b/drivers/thermal/rockchip_thermal.c
index 433085a..5c58d48 100644
--- a/drivers/thermal/rockchip_thermal.c
+++ b/drivers/thermal/rockchip_thermal.c
@@ -411,7 +411,7 @@ static int rk_tsadcv2_code_to_temp(struct chip_tsadc_table table, u32 code,
 	 * temperature between 2 table entries is linear and interpolate
 	 * to produce less granular result.
 	 */
-	num = table.id[mid].temp - v2_code_table[mid - 1].temp;
+	num = table.id[mid].temp - table.id[mid - 1].temp;
 	num *= abs(table.id[mid - 1].code - code);
 	denom = abs(table.id[mid - 1].code - table.id[mid].code);
 	*temp = table.id[mid - 1].temp + (num / denom);
-- 
1.9.1
