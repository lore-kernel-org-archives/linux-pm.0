From: Baole Ni <baolex.ni@intel.com>
Subject: [PATCH 0962/1285] Replace numeric parameter like 0444 with macro
Date: Tue,  2 Aug 2016 20:03:06 +0800
Message-ID: <20160802120306.14192-1-baolex.ni@intel.com>
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
 drivers/thermal/thermal_core.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
index 5133cd1..de6d349 100644
--- a/drivers/thermal/thermal_core.c
+++ b/drivers/thermal/thermal_core.c
@@ -1099,9 +1099,9 @@ int power_actor_set_power(struct thermal_cooling_device *cdev,
 	return 0;
 }
 
-static DEVICE_ATTR(type, 0444, type_show, NULL);
-static DEVICE_ATTR(temp, 0444, temp_show, NULL);
-static DEVICE_ATTR(mode, 0644, mode_show, mode_store);
+static DEVICE_ATTR(type, S_IRUSR | S_IRGRP | S_IROTH, type_show, NULL);
+static DEVICE_ATTR(temp, S_IRUSR | S_IRGRP | S_IROTH, temp_show, NULL);
+static DEVICE_ATTR(mode, S_IRUSR | S_IWUSR | S_IRGRP | S_IROTH, mode_show, mode_store);
 static DEVICE_ATTR(passive, S_IRUGO | S_IWUSR, passive_show, passive_store);
 static DEVICE_ATTR(policy, S_IRUGO | S_IWUSR, policy_show, policy_store);
 static DEVICE_ATTR(available_policies, S_IRUGO, available_policies_show, NULL);
@@ -1170,9 +1170,9 @@ thermal_cooling_device_cur_state_store(struct device *dev,
 
 static struct device_attribute dev_attr_cdev_type =
 __ATTR(type, 0444, thermal_cooling_device_type_show, NULL);
-static DEVICE_ATTR(max_state, 0444,
+static DEVICE_ATTR(max_state, S_IRUSR | S_IRGRP | S_IROTH,
 		   thermal_cooling_device_max_state_show, NULL);
-static DEVICE_ATTR(cur_state, 0644,
+static DEVICE_ATTR(cur_state, S_IRUSR | S_IWUSR | S_IRGRP | S_IROTH,
 		   thermal_cooling_device_cur_state_show,
 		   thermal_cooling_device_cur_state_store);
 
-- 
2.9.2
