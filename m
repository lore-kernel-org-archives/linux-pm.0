From: Caesar Wang <wxt@rock-chips.com>
Subject: [PATCH v4 5/5] thermal: rockchip: handle set_trips without the trip points
Date: Mon, 12 Dec 2016 19:05:35 +0800
Message-ID: <1481540735-12710-6-git-send-email-wxt@rock-chips.com>
References: <1481540735-12710-1-git-send-email-wxt@rock-chips.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pg0-f68.google.com ([74.125.83.68]:34778 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932181AbcLLLGN (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 12 Dec 2016 06:06:13 -0500
In-Reply-To: <1481540735-12710-1-git-send-email-wxt@rock-chips.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: edubezval@gmail.com, rui.zhang@intel.com
Cc: linux-rockchip@lists.infradead.org, linux-pm@vger.kernel.org, briannorris@chromium.org, linux-kernel@vger.kernel.org, smbarber@chromium.org, Caesar Wang <wxt@rock-chips.com>

In some cases, some sensors didn't need the trip points, the
set_trips will pass {-INT_MAX, INT_MAX} to trigger tsadc alarm in the end,
ignore this case and disable the high temperature interrupt.

Signed-off-by: Caesar Wang <wxt@rock-chips.com>
Reviewed-by: Brian Norris <briannorris@chromium.org>
---

Changes in v4: None
Changes in v3:
- change the commit.
- Fixes something as Brian comments on

Changes in v2:
- Fixes something as Brian comments on
  https://patchwork.kernel.org/patch/9440989.

Changes in v1: None

 drivers/thermal/rockchip_thermal.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/drivers/thermal/rockchip_thermal.c b/drivers/thermal/rockchip_thermal.c
index cacc12b..cbbf0ce 100644
--- a/drivers/thermal/rockchip_thermal.c
+++ b/drivers/thermal/rockchip_thermal.c
@@ -674,7 +674,21 @@ static int rk_tsadcv2_get_temp(const struct chip_tsadc_table *table,
 static int rk_tsadcv2_alarm_temp(const struct chip_tsadc_table *table,
 				 int chn, void __iomem *regs, int temp)
 {
-	u32 alarm_value, int_en;
+	u32 alarm_value;
+	u32 int_en, int_clr;
+
+	/*
+	 * In some cases, some sensors didn't need the trip points, the
+	 * set_trips will pass {-INT_MAX, INT_MAX} to trigger tsadc alarm
+	 * in the end, ignore this case and disable the high temperature
+	 * interrupt.
+	 */
+	if (temp == INT_MAX) {
+		int_clr = readl_relaxed(regs + TSADCV2_INT_EN);
+		int_clr &= ~TSADCV2_INT_SRC_EN(chn);
+		writel_relaxed(int_clr, regs + TSADCV2_INT_EN);
+		return 0;
+	}
 
 	/* Make sure the value is valid */
 	alarm_value = rk_tsadcv2_temp_to_code(table, temp);
-- 
2.7.4

