From: Baole Ni <baolex.ni@intel.com>
Subject: [PATCH 0963/1285] Replace numeric parameter like 0444 with macro
Date: Tue,  2 Aug 2016 20:03:11 +0800
Message-ID: <20160802120311.14259-1-baolex.ni@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: rui.zhang@intel.com, edubezval@gmail.com, gregkh@linuxfoundation.org, m.chehab@samsung.com, m.szyprowski@samsung.com, kyungmin.park@samsung.com, k.kozlowski@samsung.com
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, chuansheng.liu@intel.com, baolex.ni@intel.com, heiko@sntech.de, s.hauer@pengutronix.de
List-Id: linux-pm@vger.kernel.org

I find that the developers often just specified the numeric value
when calling a macro which is defined with a parameter for access permission.
As we know, these numeric value for access permission have had the corresponding macro,
and that using macro can improve the robustness and readability of the code,
thus, I suggest replacing the numeric parameter with the macro.

Signed-off-by: Chuansheng Liu <chuansheng.liu@intel.com>
Signed-off-by: Baole Ni <baolex.ni@intel.com>
---
 drivers/thermal/thermal_hwmon.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/thermal/thermal_hwmon.c b/drivers/thermal/thermal_hwmon.c
index 06fd2ed9..c678ac4 100644
--- a/drivers/thermal/thermal_hwmon.c
+++ b/drivers/thermal/thermal_hwmon.c
@@ -64,7 +64,7 @@ name_show(struct device *dev, struct device_attribute *attr, char *buf)
 	struct thermal_hwmon_device *hwmon = dev_get_drvdata(dev);
 	return sprintf(buf, "%s\n", hwmon->type);
 }
-static DEVICE_ATTR(name, 0444, name_show, NULL);
+static DEVICE_ATTR(name, S_IRUSR | S_IRGRP | S_IROTH, name_show, NULL);
 
 static ssize_t
 temp_input_show(struct device *dev, struct device_attribute *attr, char *buf)
-- 
2.9.2
