From: Baole Ni <baolex.ni@intel.com>
Subject: [PATCH 0866/1285] Replace numeric parameter like 0444 with macro
Date: Tue,  2 Aug 2016 19:53:29 +0800
Message-ID: <20160802115329.7714-1-baolex.ni@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: sre@kernel.org, dbaryshkov@gmail.com, dwmw2@infradead.org, m.chehab@samsung.com, pawel@osciak.com, m.szyprowski@samsung.com, kyungmin.park@samsung.com, k.kozlowski@samsung.com
Cc: patches@opensource.wolfsonmicro.com, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, chuansheng.liu@intel.com, baolex.ni@intel.com
List-Id: linux-pm@vger.kernel.org

I find that the developers often just specified the numeric value
when calling a macro which is defined with a parameter for access permission.
As we know, these numeric value for access permission have had the corresponding macro,
and that using macro can improve the robustness and readability of the code,
thus, I suggest replacing the numeric parameter with the macro.

Signed-off-by: Chuansheng Liu <chuansheng.liu@intel.com>
Signed-off-by: Baole Ni <baolex.ni@intel.com>
---
 drivers/power/wm8350_power.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/power/wm8350_power.c b/drivers/power/wm8350_power.c
index 5c58806..f3e00c54 100644
--- a/drivers/power/wm8350_power.c
+++ b/drivers/power/wm8350_power.c
@@ -182,7 +182,7 @@ static ssize_t charger_state_show(struct device *dev,
 	return sprintf(buf, "%s\n", charge);
 }
 
-static DEVICE_ATTR(charger_state, 0444, charger_state_show, NULL);
+static DEVICE_ATTR(charger_state, S_IRUSR | S_IRGRP | S_IROTH, charger_state_show, NULL);
 
 static irqreturn_t wm8350_charger_handler(int irq, void *data)
 {
-- 
2.9.2
