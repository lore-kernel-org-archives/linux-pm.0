From: Zhang Rui <rui.zhang@intel.com>
Subject: [PATCH RESEND 2/2] PM: invalidate TEST_CPUS and TEST_CORE support for freeze state
Date: Wed, 27 Mar 2013 11:36:11 +0800
Message-ID: <1364355371-2518-2-git-send-email-rui.zhang@intel.com>
References: <1364355371-2518-1-git-send-email-rui.zhang@intel.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:60731 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756260Ab3C0DgR (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Tue, 26 Mar 2013 23:36:17 -0400
In-Reply-To: <1364355371-2518-1-git-send-email-rui.zhang@intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rjw@sisk.pl
Cc: linux-pm@vger.kernel.org, Zhang Rui <rui.zhang@intel.com>

freeze state is a software suspend state that does not run into
low-level platform callbacks which may interact with BIOS.
And freeze state does not need to disable the processors.

But the current pm_test support misleads users because users
can enter freeze state with pm_test set to TEST_CPUS/TEST_CORE,
while this pm_test setting never takes actions.

So, invalidate TEST_CPUS/TEST_CORE for freeze state in this patch.
Then users will get an error instead, when trying to
enter freeze state with pm_test mode set to TEST_CPUS/TEST_CORE.

Signed-off-by: Zhang Rui <rui.zhang@intel.com>
---
 kernel/power/suspend.c |   16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/kernel/power/suspend.c b/kernel/power/suspend.c
index 5eb30aa..bef86d1 100644
--- a/kernel/power/suspend.c
+++ b/kernel/power/suspend.c
@@ -76,8 +76,20 @@ EXPORT_SYMBOL_GPL(suspend_set_ops);
 
 bool valid_state(suspend_state_t state)
 {
-	if (state == PM_SUSPEND_FREEZE)
-		return true;
+	if (state == PM_SUSPEND_FREEZE) {
+#ifdef CONFIG_PM_DEBUG
+		if (pm_test_level != TEST_NONE &&
+		    pm_test_level != TEST_FREEZER &&
+		    pm_test_level != TEST_DEVICES &&
+		    pm_test_level != TEST_PLATFORM) {
+			printk(KERN_WARNING "Unsupported pm_test mode for "
+					"freeze state, please choose "
+					"none/freezer/devices/platform.\n");
+			return false;
+		}
+#endif
+			return true;
+	}
 	/*
 	 * PM_SUSPEND_STANDBY and PM_SUSPEND_MEMORY states need lowlevel
 	 * support and need to be valid to the lowlevel
-- 
1.7.9.5

