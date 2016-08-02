From: Baole Ni <baolex.ni@intel.com>
Subject: [PATCH 0862/1285] Replace numeric parameter like 0444 with macro
Date: Tue,  2 Aug 2016 19:53:11 +0800
Message-ID: <20160802115311.7450-1-baolex.ni@intel.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:6327 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S964912AbcHBMeu (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Tue, 2 Aug 2016 08:34:50 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: sre@kernel.org, dbaryshkov@gmail.com, dwmw2@infradead.org, m.chehab@samsung.com, pawel@osciak.com, m.szyprowski@samsung.com, kyungmin.park@samsung.com, k.kozlowski@samsung.com
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, chuansheng.liu@intel.com, baolex.ni@intel.com

I find that the developers often just specified the numeric value
when calling a macro which is defined with a parameter for access permission.
As we know, these numeric value for access permission have had the corresponding macro,
and that using macro can improve the robustness and readability of the code,
thus, I suggest replacing the numeric parameter with the macro.

Signed-off-by: Chuansheng Liu <chuansheng.liu@intel.com>
Signed-off-by: Baole Ni <baolex.ni@intel.com>
---
 drivers/power/ds2760_battery.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/power/ds2760_battery.c b/drivers/power/ds2760_battery.c
index 80f73cc..37b1097 100644
--- a/drivers/power/ds2760_battery.c
+++ b/drivers/power/ds2760_battery.c
@@ -62,19 +62,19 @@ struct ds2760_device_info {
 };
 
 static unsigned int cache_time = 1000;
-module_param(cache_time, uint, 0644);
+module_param(cache_time, uint, S_IRUSR | S_IWUSR | S_IRGRP | S_IROTH);
 MODULE_PARM_DESC(cache_time, "cache time in milliseconds");
 
 static bool pmod_enabled;
-module_param(pmod_enabled, bool, 0644);
+module_param(pmod_enabled, bool, S_IRUSR | S_IWUSR | S_IRGRP | S_IROTH);
 MODULE_PARM_DESC(pmod_enabled, "PMOD enable bit");
 
 static unsigned int rated_capacity;
-module_param(rated_capacity, uint, 0644);
+module_param(rated_capacity, uint, S_IRUSR | S_IWUSR | S_IRGRP | S_IROTH);
 MODULE_PARM_DESC(rated_capacity, "rated battery capacity, 10*mAh or index");
 
 static unsigned int current_accum;
-module_param(current_accum, uint, 0644);
+module_param(current_accum, uint, S_IRUSR | S_IWUSR | S_IRGRP | S_IROTH);
 MODULE_PARM_DESC(current_accum, "current accumulator value");
 
 /* Some batteries have their rated capacity stored a N * 10 mAh, while
-- 
2.9.2

