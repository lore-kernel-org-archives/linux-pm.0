From: Chen Yu <yu.c.chen@intel.com>
Subject: [PATCH][v2] PM / sleep: Increase default DPM watchdog timeout to 120
Date: Fri, 19 Aug 2016 12:37:23 +0800
Message-ID: <1471581443-22184-1-git-send-email-yu.c.chen@intel.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:55001 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751701AbcHSE3X (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 19 Aug 2016 00:29:23 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Pavel Machek <pavel@ucw.cz>, linux-kernel@vger.kernel.org, Chen Yu <yu.c.chen@intel.com>

Recently we have a new report that, the harddisk can not
resume on time due to firmware issues, and got a kernel
panic because of DPM watchdog timeout. So adjust the
default timeout from 60 to 120 to survive on this platform,
and make DPM_WATCHDOG depending on EXPERT.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=117971
Suggested-by: Pavel Machek <pavel@ucw.cz>
Suggested-by: Rafael J. Wysocki <rafael@kernel.org>
Reported-by: Higuita <higuita@gmx.net>
Signed-off-by: Chen Yu <yu.c.chen@intel.com>
---
 kernel/power/Kconfig | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/power/Kconfig b/kernel/power/Kconfig
index 68d3ebc..e8517b6 100644
--- a/kernel/power/Kconfig
+++ b/kernel/power/Kconfig
@@ -186,7 +186,7 @@ config PM_SLEEP_DEBUG
 
 config DPM_WATCHDOG
 	bool "Device suspend/resume watchdog"
-	depends on PM_DEBUG && PSTORE
+	depends on PM_DEBUG && PSTORE && EXPERT
 	---help---
 	  Sets up a watchdog timer to capture drivers that are
 	  locked up attempting to suspend/resume a device.
@@ -197,7 +197,7 @@ config DPM_WATCHDOG
 config DPM_WATCHDOG_TIMEOUT
 	int "Watchdog timeout in seconds"
 	range 1 120
-	default 60
+	default 120
 	depends on DPM_WATCHDOG
 
 config PM_TRACE
-- 
2.7.4

