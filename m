From: Baole Ni <baolex.ni@intel.com>
Subject: [PATCH 0863/1285] Replace numeric parameter like 0444 with macro
Date: Tue,  2 Aug 2016 19:53:16 +0800
Message-ID: <20160802115316.7516-1-baolex.ni@intel.com>
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
 drivers/power/intel_mid_battery.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/power/intel_mid_battery.c b/drivers/power/intel_mid_battery.c
index 9fa4acc..a9de393 100644
--- a/drivers/power/intel_mid_battery.c
+++ b/drivers/power/intel_mid_battery.c
@@ -43,7 +43,7 @@
  *********************************************************************/
 
 static int debug;
-module_param(debug, int, 0444);
+module_param(debug, int, S_IRUSR | S_IRGRP | S_IROTH);
 MODULE_PARM_DESC(debug, "Flag to enable PMIC Battery debug messages.");
 
 #define PMIC_BATT_DRV_INFO_UPDATED	1
-- 
2.9.2
