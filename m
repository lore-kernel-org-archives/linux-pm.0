From: Caesar Wang <wxt@rock-chips.com>
Subject: [PATCH 5/5] thermal: rockchip: handle the set_trips without the trip points.
Date: Tue, 22 Nov 2016 20:34:48 +0800
Message-ID: <1479818088-6007-6-git-send-email-wxt@rock-chips.com>
References: <1479818088-6007-1-git-send-email-wxt@rock-chips.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1479818088-6007-1-git-send-email-wxt@rock-chips.com>
Sender: linux-kernel-owner@vger.kernel.org
To: edubezval@gmail.com, rui.zhang@intel.com
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, linux-rockchip@lists.infradead.org, briannorris@chromium.org, heiko@sntech.de, smbarber@chromium.org, Caesar Wang <wxt@rock-chips.com>
List-Id: linux-pm@vger.kernel.org

In some cases, some sensors didn't need the trip points, the
set_trips will return {-INT_MAX, INT_MAX} to trigger thermal alarm.

Signed-off-by: Caesar Wang <wxt@rock-chips.com>
---

 drivers/thermal/rockchip_thermal.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/thermal/rockchip_thermal.c b/drivers/thermal/rockchip_thermal.c
index f4d4be9..5b9c346 100644
--- a/drivers/thermal/rockchip_thermal.c
+++ b/drivers/thermal/rockchip_thermal.c
@@ -200,6 +200,7 @@ struct rockchip_thermal_data {
 #define TSADCV3_AUTO_Q_SEL_EN			BIT(1)
 
 #define TSADCV2_INT_SRC_EN(chn)			BIT(chn)
+#define TSADCV2_INT_SRC_SHIFT(chn)		chn
 #define TSADCV2_SHUT_2GPIO_SRC_EN(chn)		BIT(4 + (chn))
 #define TSADCV2_SHUT_2CRU_SRC_EN(chn)		BIT(8 + (chn))
 
@@ -903,10 +904,22 @@ static int rockchip_thermal_set_trips(void *_sensor, int low, int high)
 	struct rockchip_thermal_sensor *sensor = _sensor;
 	struct rockchip_thermal_data *thermal = sensor->thermal;
 	const struct rockchip_tsadc_chip *tsadc = thermal->chip;
+	u32 int_clr;
 
 	dev_dbg(&thermal->pdev->dev, "%s: sensor %d: low: %d, high %d\n",
 		__func__, sensor->id, low, high);
 
+	/*
+	 * In some cases, some sensors didn't need the trip points, the
+	 * set_trips will return {-INT_MAX, INT_MAX} to trigger thermal alarm.
+	 */
+	if (high == INT_MAX) {
+		int_clr = readl_relaxed(thermal->regs + TSADCV2_INT_EN);
+		int_clr |= 0 << TSADCV2_INT_SRC_SHIFT(sensor->id);
+		writel_relaxed(int_clr, thermal->regs + TSADCV2_INT_EN);
+		return 0;
+	}
+
 	tsadc->set_alarm_temp(&tsadc->table,
 			      sensor->id, thermal->regs, high);
 
-- 
2.7.4
