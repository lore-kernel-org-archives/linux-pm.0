From: Zhang Rui <rui.zhang@intel.com>
Subject: [PATCH RESEND 2/2] PM: invalidate TEST_CPUS and TEST_CORE support
 for freeze state
Date: Tue, 12 Mar 2013 09:21:49 +0800
Message-ID: <1363051309.2291.101.camel@rzhang1-mobl4>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:16784 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754591Ab3CLBV4 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Mon, 11 Mar 2013 21:21:56 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Linux PM list <linux-pm@vger.kernel.org>, Kristen Carlson Accardi <kristen.c.accardi@intel.com>

>From 0777c83233875e2f84c21f76145058f513894abd Mon Sep 17 00:00:00 2001
From: Zhang Rui <rui.zhang@intel.com>
Date: Wed, 6 Mar 2013 21:22:21 +0800
Subject: [PATCH RESEND 2/2] PM: invalidate TEST_CPUS and TEST_CORE support for
 freeze state

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
 kernel/power/suspend.c |   12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/kernel/power/suspend.c b/kernel/power/suspend.c
index 5eb30aa..e29909a 100644
--- a/kernel/power/suspend.c
+++ b/kernel/power/suspend.c
@@ -76,8 +76,16 @@ EXPORT_SYMBOL_GPL(suspend_set_ops);
 
 bool valid_state(suspend_state_t state)
 {
-	if (state == PM_SUSPEND_FREEZE)
-		return true;
+	if (state == PM_SUSPEND_FREEZE) {
+		if (pm_test_level == TEST_NONE ||
+		    pm_test_level == TEST_FREEZER ||
+		    pm_test_level == TEST_DEVICES ||
+		    pm_test_level == TEST_PLATFORM)
+			return true;
+		printk(KERN_WARNING "Unsupported pm_test mode for freeze state,"
+			" please choose none/freezer/devices/platform.\n");
+		return false;
+	}
 	/*
 	 * PM_SUSPEND_STANDBY and PM_SUSPEND_MEMORY states need lowlevel
 	 * support and need to be valid to the lowlevel
-- 
1.7.9.5



