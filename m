From: Caesar Wang <wxt@rock-chips.com>
Subject: [PATCH] thermal: rockchip: use the usleep_range instead of udelay
Date: Tue,  3 May 2016 10:23:50 +0800
Message-ID: <1462242230-20873-1-git-send-email-wxt@rock-chips.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f52.google.com ([209.85.220.52]:36261 "EHLO
	mail-pa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932239AbcECCYO (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 2 May 2016 22:24:14 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: edubezval@gmail.com
Cc: rui.zhang@intel.com, heiko@sntech.de, linux-rockchip@lists.infradead.org, huangtao@rock-chips.com, Caesar Wang <wxt@rock-chips.com>, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org

Documentation/timers/timers-howto.txt recommends to use
usleep_range on delays > 10usec.
The usleep_range indeed reduces CPU load, since the udelay will busy wait
for enough loop cycles to achieve the desired delay.

Fixes commit b06c52db39fd ("thermal: rockchip:
handle the power sequence for tsadc controller").

Cc: Zhang Rui <rui.zhang@intel.com>
Cc: Eduardo Valentin <edubezval@gmail.com>
Cc: Heiko Stuebner <heiko@sntech.de>
Suggested-by: Eduardo Valentin <edubezval@gmail.com>
Signed-off-by: Caesar Wang <wxt@rock-chips.com>

---

 drivers/thermal/rockchip_thermal.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/thermal/rockchip_thermal.c b/drivers/thermal/rockchip_thermal.c
index 86a1ab0..5d491f1 100644
--- a/drivers/thermal/rockchip_thermal.c
+++ b/drivers/thermal/rockchip_thermal.c
@@ -547,10 +547,10 @@ static void rk_tsadcv3_initialize(struct regmap *grf, void __iomem *regs,
 		regmap_write(grf, GRF_TSADC_TESTBIT_L, GRF_TSADC_TSEN_PD_ON);
 		mdelay(10);
 		regmap_write(grf, GRF_TSADC_TESTBIT_L, GRF_TSADC_TSEN_PD_OFF);
-		udelay(100); /* The spec note says at least 15 us */
+		usleep_range(15, 100); /* The spec note says at least 15 us */
 		regmap_write(grf, GRF_SARADC_TESTBIT, GRF_SARADC_TESTBIT_ON);
 		regmap_write(grf, GRF_TSADC_TESTBIT_H, GRF_TSADC_TESTBIT_H_ON);
-		udelay(200); /* The spec note says at least 90 us */
+		usleep_range(90, 200); /* The spec note says at least 90 us */
 	}
 
 	if (tshut_polarity == TSHUT_HIGH_ACTIVE)
-- 
1.9.1

