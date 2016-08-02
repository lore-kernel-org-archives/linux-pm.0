From: Baole Ni <baolex.ni@intel.com>
Subject: [PATCH 0250/1285] Replace numeric parameter like 0444 with macro
Date: Tue,  2 Aug 2016 18:53:15 +0800
Message-ID: <20160802105315.30405-1-baolex.ni@intel.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:45444 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754254AbcHBLgZ (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Tue, 2 Aug 2016 07:36:25 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: andrew.d.henroid@intel.com, davem@davemloft.net, linux@roeck-us.net, airlied@linux.ie, kgene@kernel.org, k.kozlowski@samsung.com, dougthompson@xmission.com, bp@alien8.de
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, chuansheng.liu@intel.com, baolex.ni@intel.com, aduggan@synaptics.com, dianders@chromium.org

I find that the developers often just specified the numeric value
when calling a macro which is defined with a parameter for access permission.
As we know, these numeric value for access permission have had the corresponding macro,
and that using macro can improve the robustness and readability of the code,
thus, I suggest replacing the numeric parameter with the macro.

Signed-off-by: Chuansheng Liu <chuansheng.liu@intel.com>
Signed-off-by: Baole Ni <baolex.ni@intel.com>
---
 drivers/idle/i7300_idle.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/idle/i7300_idle.c b/drivers/idle/i7300_idle.c
index ffeebc7..26d3e66 100644
--- a/drivers/idle/i7300_idle.c
+++ b/drivers/idle/i7300_idle.c
@@ -39,11 +39,11 @@
 #define MAX_STOP_RETRIES	10
 
 static int debug;
-module_param_named(debug, debug, uint, 0644);
+module_param_named(debug, debug, uint, S_IRUSR | S_IWUSR | S_IRGRP | S_IROTH);
 MODULE_PARM_DESC(debug, "Enable debug printks in this driver");
 
 static int forceload;
-module_param_named(forceload, forceload, uint, 0644);
+module_param_named(forceload, forceload, uint, S_IRUSR | S_IWUSR | S_IRGRP | S_IROTH);
 MODULE_PARM_DESC(debug, "Enable driver testing on unvalidated i5000");
 
 #define dprintk(fmt, arg...) \
@@ -58,7 +58,7 @@ MODULE_PARM_DESC(debug, "Enable driver testing on unvalidated i5000");
  */
 #define MAX_THROTTLE_LOW_LIMIT		168
 static uint throttle_low_limit = 1;
-module_param_named(throttle_low_limit, throttle_low_limit, uint, 0644);
+module_param_named(throttle_low_limit, throttle_low_limit, uint, S_IRUSR | S_IWUSR | S_IRGRP | S_IROTH);
 MODULE_PARM_DESC(throttle_low_limit,
 		"Value for THRTLOWLM activation field "
 		"(0 = disable throttle, 1 = Max throttle, 168 = Min throttle)");
-- 
2.9.2

