From: Baole Ni <baolex.ni@intel.com>
Subject: [PATCH 1069/1285] Replace numeric parameter like 0444 with macro
Date: Tue,  2 Aug 2016 20:13:37 +0800
Message-ID: <20160802121337.21389-1-baolex.ni@intel.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:64591 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965226AbcHBMwG (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Tue, 2 Aug 2016 08:52:06 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rjw@rjwysocki.net, len.brown@intel.com, pavel@ucw.cz, tony.luck@intel.com, tomi.valkeinen@ti.com, m.chehab@samsung.com, gregkh@linuxfoundation.org, m.szyprowski@samsung.com, kyungmin.park@samsung.com, k.kozlowski@samsung.com
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, chuansheng.liu@intel.com, baolex.ni@intel.com, mhocko@suse.com, tglx@linutronix.de, vkuznets@redhat.com, pmladek@suse.com, tj@kernel.org, jpoimboe@redhat.com

I find that the developers often just specified the numeric value
when calling a macro which is defined with a parameter for access permission.
As we know, these numeric value for access permission have had the corresponding macro,
and that using macro can improve the robustness and readability of the code,
thus, I suggest replacing the numeric parameter with the macro.

Signed-off-by: Chuansheng Liu <chuansheng.liu@intel.com>
Signed-off-by: Baole Ni <baolex.ni@intel.com>
---
 kernel/power/suspend.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/power/suspend.c b/kernel/power/suspend.c
index 5b70d64..513e9d4 100644
--- a/kernel/power/suspend.c
+++ b/kernel/power/suspend.c
@@ -239,7 +239,7 @@ static bool platform_suspend_again(suspend_state_t state)
 
 #ifdef CONFIG_PM_DEBUG
 static unsigned int pm_test_delay = 5;
-module_param(pm_test_delay, uint, 0644);
+module_param(pm_test_delay, uint, S_IRUSR | S_IWUSR | S_IRGRP | S_IROTH);
 MODULE_PARM_DESC(pm_test_delay,
 		 "Number of seconds to wait before resuming from suspend test");
 #endif
-- 
2.9.2

