From: Zhang Rui <rui.zhang@intel.com>
Subject: [PATCH RESEND 1/2] PM: add TEST_PLATFORM support for freeze state
Date: Wed, 27 Mar 2013 11:36:10 +0800
Message-ID: <1364355371-2518-1-git-send-email-rui.zhang@intel.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:60731 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756260Ab3C0DgP (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Tue, 26 Mar 2013 23:36:15 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rjw@sisk.pl
Cc: linux-pm@vger.kernel.org, Zhang Rui <rui.zhang@intel.com>

Invoke freeze_enter() after suspend_test(TEST_PLATFORM) being invoked.

So when setting /sys/power/pm_test to "platform", it can be used to
check if freeze state is working well after all devices are suspended
and before processors are blocked,

Signed-off-by: Zhang Rui <rui.zhang@intel.com>
---
 kernel/power/suspend.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/kernel/power/suspend.c b/kernel/power/suspend.c
index d4feda0..5eb30aa 100644
--- a/kernel/power/suspend.c
+++ b/kernel/power/suspend.c
@@ -184,6 +184,9 @@ static int suspend_enter(suspend_state_t state, bool *wakeup)
 			goto Platform_wake;
 	}
 
+	if (suspend_test(TEST_PLATFORM))
+		goto Platform_wake;
+
 	/*
 	 * PM_SUSPEND_FREEZE equals
 	 * frozen processes + suspended devices + idle processors.
@@ -195,9 +198,6 @@ static int suspend_enter(suspend_state_t state, bool *wakeup)
 		goto Platform_wake;
 	}
 
-	if (suspend_test(TEST_PLATFORM))
-		goto Platform_wake;
-
 	error = disable_nonboot_cpus();
 	if (error || suspend_test(TEST_CPUS))
 		goto Enable_cpus;
-- 
1.7.9.5

