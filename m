From: Javi Merino <javi.merino@arm.com>
Subject: [PATCH] thermal: remove stale THERMAL_POWER_ACTOR select
Date: Wed,  4 Mar 2015 17:57:29 +0000
Message-ID: <1425491849-31721-1-git-send-email-javi.merino@arm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: edubezval@gmail.com
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, valentinrothberg@gmail.com, Javi Merino <javi.merino@arm.com>, Zhang Rui <rui.zhang@intel.com>
List-Id: linux-pm@vger.kernel.org

A previous version of this patch had a config for THERMAL_POWER_ACTOR
but it was dropped.  Remove the select as it is not doing anything.

Cc: Zhang Rui <rui.zhang@intel.com>
Cc: Eduardo Valentin <edubezval@gmail.com>
Reported-by: Valentin Rothberg <valentinrothberg@gmail.com>
Signed-off-by: Javi Merino <javi.merino@arm.com>
---

This issue was detected by Valentin Rothberg, running
undertaker-checkpatch on linux-next.  This patch is based on the
"linus" branch of Eduardo's tree.

Eduardo, can you queue it please?

 drivers/thermal/Kconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/thermal/Kconfig b/drivers/thermal/Kconfig
index 46bdecf260e5..3379beeed109 100644
--- a/drivers/thermal/Kconfig
+++ b/drivers/thermal/Kconfig
@@ -120,7 +120,6 @@ config THERMAL_GOV_USER_SPACE
 
 config THERMAL_GOV_POWER_ALLOCATOR
 	bool "Power allocator thermal governor"
-	select THERMAL_POWER_ACTOR
 	help
 	  Enable this to manage platform thermals by dynamically
 	  allocating and limiting power to devices.
-- 
1.9.1
