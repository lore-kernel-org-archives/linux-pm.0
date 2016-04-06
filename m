From: Len Brown <lenb@kernel.org>
Subject: [PATCH 03/13] intel_idle: Fix a helper function's return value.
Date: Wed,  6 Apr 2016 17:00:49 -0400
Message-ID: <ce8bc1e734d1f907c4df1b75e38a1f288b58c5c3.1459975717.git.len.brown@intel.com>
References: <1459976459-2532-1-git-send-email-lenb@kernel.org>
Reply-To: Len Brown <lenb@kernel.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-yw0-f195.google.com ([209.85.161.195]:36367 "EHLO
	mail-yw0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753051AbcDFVBh (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 6 Apr 2016 17:01:37 -0400
In-Reply-To: <1459976459-2532-1-git-send-email-lenb@kernel.org>
In-Reply-To: <6513da0f2332d2333848af18e374b99f77c124aa.1459975717.git.len.brown@intel.com>
References: <6513da0f2332d2333848af18e374b99f77c124aa.1459975717.git.len.brown@intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Richard Cochran <rcochran@linutronix.de>, Len Brown <len.brown@intel.com>

From: Richard Cochran <rcochran@linutronix.de>

The function, intel_idle_cpuidle_driver_init, delivers no error codes
at all.  This patch changes the function to return 'void' instead of
returning zero.

Signed-off-by: Richard Cochran <rcochran@linutronix.de>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/idle/intel_idle.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/idle/intel_idle.c b/drivers/idle/intel_idle.c
index 6638a80..d2e7baf 100644
--- a/drivers/idle/intel_idle.c
+++ b/drivers/idle/intel_idle.c
@@ -1248,7 +1248,7 @@ static void intel_idle_state_table_update(void)
  * intel_idle_cpuidle_driver_init()
  * allocate, initialize cpuidle_states
  */
-static int __init intel_idle_cpuidle_driver_init(void)
+static void __init intel_idle_cpuidle_driver_init(void)
 {
 	int cstate;
 	struct cpuidle_driver *drv = &intel_idle_driver;
@@ -1310,8 +1310,6 @@ static int __init intel_idle_cpuidle_driver_init(void)
 
 	if (icpu->disable_promotion_to_c1e)	/* each-cpu is redundant */
 		on_each_cpu(c1e_promotion_disable, NULL, 1);
-
-	return 0;
 }
 
 
-- 
2.8.0.rc4.16.g56331f8

