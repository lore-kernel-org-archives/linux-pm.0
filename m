From: Baole Ni <baolex.ni@intel.com>
Subject: [PATCH 0958/1285] Replace numeric parameter like 0444 with macro
Date: Tue,  2 Aug 2016 20:02:48 +0800
Message-ID: <20160802120249.13924-1-baolex.ni@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: rui.zhang@intel.com, edubezval@gmail.com, gregkh@linuxfoundation.org, m.chehab@samsung.com, m.szyprowski@samsung.com, kyungmin.park@samsung.com, k.kozlowski@samsung.com
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, l.majewski@samsung.com, geert+renesas@glider.be, heiko@sntech.de, s.hauer@pengutronix.de, chuansheng.liu@intel.com, baolex.ni@intel.com
List-Id: linux-pm@vger.kernel.org

I find that the developers often just specified the numeric value
when calling a macro which is defined with a parameter for access permission.
As we know, these numeric value for access permission have had the corresponding macro,
and that using macro can improve the robustness and readability of the code,
thus, I suggest replacing the numeric parameter with the macro.

Signed-off-by: Chuansheng Liu <chuansheng.liu@intel.com>
Signed-off-by: Baole Ni <baolex.ni@intel.com>
---
 drivers/thermal/int340x_thermal/int3400_thermal.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/thermal/int340x_thermal/int3400_thermal.c b/drivers/thermal/int340x_thermal/int3400_thermal.c
index 5836e55..9bff7be 100644
--- a/drivers/thermal/int340x_thermal/int3400_thermal.c
+++ b/drivers/thermal/int340x_thermal/int3400_thermal.c
@@ -96,7 +96,7 @@ static ssize_t current_uuid_store(struct device *dev,
 	return -EINVAL;
 }
 
-static DEVICE_ATTR(current_uuid, 0644, current_uuid_show, current_uuid_store);
+static DEVICE_ATTR(current_uuid, S_IRUSR | S_IWUSR | S_IRGRP | S_IROTH, current_uuid_show, current_uuid_store);
 static DEVICE_ATTR_RO(available_uuids);
 static struct attribute *uuid_attrs[] = {
 	&dev_attr_available_uuids.attr,
-- 
2.9.2
