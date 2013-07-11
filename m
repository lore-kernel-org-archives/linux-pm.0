From: "Brandt, Todd E" <todd.e.brandt@intel.com>
Subject: [PATCH] increase ftrace coverage in suspend/resume
Date: Thu, 11 Jul 2013 07:44:35 +0000
Message-ID: <11E08D716F0541429B7042699DD5C1A17064F086@FMSMSX103.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:16961 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755835Ab3GKHoh convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 11 Jul 2013 03:44:37 -0400
Content-Language: en-US
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
Cc: "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>

This new patch changes where ftrace is disabled and re-enabled during a 
suspend/resume to allow tracing of device driver pm callbacks. Ftrace 
is turned off when suspend reaches the disable_nonboot_cpus instead of
at the very beginning of system suspend.

Ftrace was disabled during suspend/resume back in 2008 by Steven Rostedt
as he discovered there was a conflict in the enable_nonboot_cpus call
(see commit f42ac38c59e0a03d6da0c24a63fb211393f484b0). This patch preserves 
his fix by disabling ftrace, but only at the function where it is known
to cause problems. I think the first patch might have been a bit 
overzealous in disabling all of suspend/resume ftrace, but please correct
me if I'm wrong. 

The new patch allows tracing of the device level code for better debug. 

Signed-off-by: Todd Brandt <todd.e.brandt@intel.com>
---
 kernel/power/suspend.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/power/suspend.c b/kernel/power/suspend.c
index bef86d1..6c23af7 100644
--- a/kernel/power/suspend.c
+++ b/kernel/power/suspend.c
@@ -210,6 +210,7 @@ static int suspend_enter(suspend_state_t state, bool *wakeup)
 		goto Platform_wake;
 	}
 
+	ftrace_stop();
 	error = disable_nonboot_cpus();
 	if (error || suspend_test(TEST_CPUS))
 		goto Enable_cpus;
@@ -232,6 +233,7 @@ static int suspend_enter(suspend_state_t state, bool *wakeup)
 
  Enable_cpus:
 	enable_nonboot_cpus();
+	ftrace_start();
 
  Platform_wake:
 	if (need_suspend_ops(state) && suspend_ops->wake)
@@ -265,7 +267,6 @@ int suspend_devices_and_enter(suspend_state_t state)
 			goto Close;
 	}
 	suspend_console();
-	ftrace_stop();
 	suspend_test_start();
 	error = dpm_suspend_start(PMSG_SUSPEND);
 	if (error) {
@@ -285,7 +286,6 @@ int suspend_devices_and_enter(suspend_state_t state)
 	suspend_test_start();
 	dpm_resume_end(PMSG_RESUME);
 	suspend_test_finish("resume devices");
-	ftrace_start();
 	resume_console();
  Close:
 	if (need_suspend_ops(state) && suspend_ops->end)

--
Todd Brandt
Linux Kernel Developer OTC, Hillsboro OR
