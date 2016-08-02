From: Baole Ni <baolex.ni@intel.com>
Subject: [PATCH 0964/1285] Replace numeric parameter like 0444 with macro
Date: Tue,  2 Aug 2016 20:03:15 +0800
Message-ID: <20160802120315.14325-1-baolex.ni@intel.com>
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
 drivers/thermal/x86_pkg_temp_thermal.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/thermal/x86_pkg_temp_thermal.c b/drivers/thermal/x86_pkg_temp_thermal.c
index 97f0a2b..336a2902 100644
--- a/drivers/thermal/x86_pkg_temp_thermal.c
+++ b/drivers/thermal/x86_pkg_temp_thermal.c
@@ -44,7 +44,7 @@
 */
 #define PKG_TEMP_THERMAL_NOTIFY_DELAY	5000
 static int notify_delay_ms = PKG_TEMP_THERMAL_NOTIFY_DELAY;
-module_param(notify_delay_ms, int, 0644);
+module_param(notify_delay_ms, int, S_IRUSR | S_IWUSR | S_IRGRP | S_IROTH);
 MODULE_PARM_DESC(notify_delay_ms,
 	"User space notification delay in milli seconds.");
 
-- 
2.9.2
