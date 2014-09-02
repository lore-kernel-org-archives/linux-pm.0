From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH 1/3] PM / sleep: Support freeze as test_suspend option
Date: Tue,  2 Sep 2014 11:54:39 -0700
Message-ID: <1409684081-9659-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:59716 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751850AbaIBSyc (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Tue, 2 Sep 2014 14:54:32 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rafael.j.wysocki@intel.com
Cc: linux-pm@vger.kernel.org, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

Added freeze as one of the option for test_suspend boot param.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 kernel/power/suspend_test.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/kernel/power/suspend_test.c b/kernel/power/suspend_test.c
index fe3239b..ede39c8 100644
--- a/kernel/power/suspend_test.c
+++ b/kernel/power/suspend_test.c
@@ -100,7 +100,14 @@ static void __init test_wakealarm(struct rtc_device *rtc, suspend_state_t state)
 	if (state == PM_SUSPEND_STANDBY) {
 		printk(info_test, pm_states[state]);
 		status = pm_suspend(state);
+		if (status < 0)
+			state = PM_SUSPEND_FREEZE;
 	}
+	if (state == PM_SUSPEND_FREEZE) {
+		printk(info_test, pm_states[state]);
+		status = pm_suspend(state);
+	}
+
 	if (status < 0)
 		printk(err_suspend, status);
 
-- 
1.9.1

