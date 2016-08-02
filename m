From: Baole Ni <baolex.ni@intel.com>
Subject: [PATCH 0864/1285] Replace numeric parameter like 0444 with macro
Date: Tue,  2 Aug 2016 19:53:20 +0800
Message-ID: <20160802115320.7582-1-baolex.ni@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: sre@kernel.org, dbaryshkov@gmail.com, dwmw2@infradead.org, m.chehab@samsung.com, pawel@osciak.com, m.szyprowski@samsung.com, kyungmin.park@samsung.com, k.kozlowski@samsung.com
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, chuansheng.liu@intel.com, baolex.ni@intel.com
List-Id: linux-pm@vger.kernel.org

I find that the developers often just specified the numeric value
when calling a macro which is defined with a parameter for access permission.
As we know, these numeric value for access permission have had the corresponding macro,
and that using macro can improve the robustness and readability of the code,
thus, I suggest replacing the numeric parameter with the macro.

Signed-off-by: Chuansheng Liu <chuansheng.liu@intel.com>
Signed-off-by: Baole Ni <baolex.ni@intel.com>
---
 drivers/power/test_power.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/power/test_power.c b/drivers/power/test_power.c
index 57246cd..ef97fe1 100644
--- a/drivers/power/test_power.c
+++ b/drivers/power/test_power.c
@@ -500,32 +500,32 @@ static const struct kernel_param_ops param_ops_battery_voltage = {
 #define param_check_battery_voltage(name, p) __param_check(name, p, void);
 
 
-module_param(ac_online, ac_online, 0644);
+module_param(ac_online, ac_online, S_IRUSR | S_IWUSR | S_IRGRP | S_IROTH);
 MODULE_PARM_DESC(ac_online, "AC charging state <on|off>");
 
-module_param(usb_online, usb_online, 0644);
+module_param(usb_online, usb_online, S_IRUSR | S_IWUSR | S_IRGRP | S_IROTH);
 MODULE_PARM_DESC(usb_online, "USB charging state <on|off>");
 
-module_param(battery_status, battery_status, 0644);
+module_param(battery_status, battery_status, S_IRUSR | S_IWUSR | S_IRGRP | S_IROTH);
 MODULE_PARM_DESC(battery_status,
 	"battery status <charging|discharging|not-charging|full>");
 
-module_param(battery_present, battery_present, 0644);
+module_param(battery_present, battery_present, S_IRUSR | S_IWUSR | S_IRGRP | S_IROTH);
 MODULE_PARM_DESC(battery_present,
 	"battery presence state <good|overheat|dead|overvoltage|failure>");
 
-module_param(battery_technology, battery_technology, 0644);
+module_param(battery_technology, battery_technology, S_IRUSR | S_IWUSR | S_IRGRP | S_IROTH);
 MODULE_PARM_DESC(battery_technology,
 	"battery technology <NiMH|LION|LIPO|LiFe|NiCd|LiMn>");
 
-module_param(battery_health, battery_health, 0644);
+module_param(battery_health, battery_health, S_IRUSR | S_IWUSR | S_IRGRP | S_IROTH);
 MODULE_PARM_DESC(battery_health,
 	"battery health state <good|overheat|dead|overvoltage|failure>");
 
-module_param(battery_capacity, battery_capacity, 0644);
+module_param(battery_capacity, battery_capacity, S_IRUSR | S_IWUSR | S_IRGRP | S_IROTH);
 MODULE_PARM_DESC(battery_capacity, "battery capacity (percentage)");
 
-module_param(battery_voltage, battery_voltage, 0644);
+module_param(battery_voltage, battery_voltage, S_IRUSR | S_IWUSR | S_IRGRP | S_IROTH);
 MODULE_PARM_DESC(battery_voltage, "battery voltage (millivolts)");
 
 MODULE_DESCRIPTION("Power supply driver for testing");
-- 
2.9.2
