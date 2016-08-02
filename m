From: Baole Ni <baolex.ni@intel.com>
Subject: [PATCH 0960/1285] Replace numeric parameter like 0444 with macro
Date: Tue,  2 Aug 2016 20:02:57 +0800
Message-ID: <20160802120257.14058-1-baolex.ni@intel.com>
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
 drivers/thermal/intel_quark_dts_thermal.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/thermal/intel_quark_dts_thermal.c b/drivers/thermal/intel_quark_dts_thermal.c
index 5d33b35..4f4b51c 100644
--- a/drivers/thermal/intel_quark_dts_thermal.c
+++ b/drivers/thermal/intel_quark_dts_thermal.c
@@ -113,7 +113,7 @@ struct soc_sensor_entry {
 static struct soc_sensor_entry *soc_dts;
 
 static int polling_delay = DEFAULT_POLL_DELAY;
-module_param(polling_delay, int, 0644);
+module_param(polling_delay, int, S_IRUSR | S_IWUSR | S_IRGRP | S_IROTH);
 MODULE_PARM_DESC(polling_delay,
 	"Polling interval for checking trip points (in milliseconds)");
 
-- 
2.9.2
