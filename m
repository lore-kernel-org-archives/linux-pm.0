From: Zhang Rui <rui.zhang@intel.com>
Subject: [PATCH RESEND 1/2] PM: add TEST_PLATFORM support for freeze state
Date: Tue, 12 Mar 2013 09:21:39 +0800
Message-ID: <1363051299.2291.100.camel@rzhang1-mobl4>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:32015 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754591Ab3CLBVp (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Mon, 11 Mar 2013 21:21:45 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Linux PM list <linux-pm@vger.kernel.org>, Kristen Carlson Accardi <kristen.c.accardi@intel.com>

>From 148f7df1678d8b017bff32197c8ef378dbd97531 Mon Sep 17 00:00:00 2001
From: Zhang Rui <rui.zhang@intel.com>
Date: Tue, 12 Mar 2013 08:43:11 +0800
Subject: [PATCH RESEND 1/2] PM: add TEST_PLATFORM support for freeze state

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



