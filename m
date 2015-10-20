From: Caesar Wang <wxt@rock-chips.com>
Subject: [PATCH 3/4] thermal: rockchip: change the TSHUT default state
Date: Tue, 20 Oct 2015 17:11:03 +0800
Message-ID: <1445332264-6054-4-git-send-email-wxt@rock-chips.com>
References: <1445332264-6054-1-git-send-email-wxt@rock-chips.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f42.google.com ([209.85.220.42]:34746 "EHLO
	mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751706AbbJTJLv (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 20 Oct 2015 05:11:51 -0400
In-Reply-To: <1445332264-6054-1-git-send-email-wxt@rock-chips.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Eduardo Valentin <edubezval@gmail.com>, Heiko Stuebner <heiko@sntech.de>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, dianders@chromium.org, Caesar Wang <wxt@rock-chips.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org, Zhang Rui <rui.zhang@intel.com>, linux-arm-kernel@lists.infradead.org

As the TRM says, the TSHUT default state is high active.
In general, the TSHUT state can get from the dts. Otherwise
it gets the state from this.

Signed-off-by: Caesar Wang <wxt@rock-chips.com>
---

 drivers/thermal/rockchip_thermal.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/thermal/rockchip_thermal.c b/drivers/thermal/rockchip_thermal.c
index c53e318..776d668 100644
--- a/drivers/thermal/rockchip_thermal.c
+++ b/drivers/thermal/rockchip_thermal.c
@@ -326,7 +326,7 @@ static void rk_tsadcv2_tshut_mode(int chn, void __iomem *regs,
 
 static const struct rockchip_tsadc_chip rk3288_tsadc_data = {
 	.tshut_mode = TSHUT_MODE_GPIO, /* default TSHUT via GPIO give PMIC */
-	.tshut_polarity = TSHUT_LOW_ACTIVE, /* default TSHUT LOW ACTIVE */
+	.tshut_polarity = TSHUT_HIGH_ACTIVE, /* default TSHUT HIGH ACTIVE */
 	.tshut_temp = 95000,
 
 	.initialize = rk_tsadcv2_initialize,
-- 
1.9.1

