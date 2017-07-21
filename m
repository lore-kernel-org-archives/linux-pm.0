From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH 1/2] PM / suspend: Use mem_sleep_labels[] strings in messages
Date: Fri, 21 Jul 2017 14:49:51 +0200
Message-ID: <1847613.AjVCE2oNWh@aspire.rjw.lan>
References: <1714767.SyJDFOT8Lq@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:42767 "EHLO
        cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751464AbdGUM6y (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 21 Jul 2017 08:58:54 -0400
In-Reply-To: <1714767.SyJDFOT8Lq@aspire.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Some messages in suspend.c currently print state names from
pm_states[], but that may be confusing if the mem_sleep sysfs
attribute is changed to anything different from "mem", because
in those cases the messages will say either "freeze" or "standby"
after writing "mem" to /sys/power/state.

To avoid the confusion, use mem_sleep_labels[] strings in those
messages instead.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 kernel/power/suspend.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

Index: linux-pm/kernel/power/suspend.c
===================================================================
--- linux-pm.orig/kernel/power/suspend.c
+++ linux-pm/kernel/power/suspend.c
@@ -555,7 +555,7 @@ static int enter_state(suspend_state_t s
 	trace_suspend_resume(TPS("sync_filesystems"), 0, false);
 #endif
 
-	pm_pr_dbg("Preparing system for sleep (%s)\n", pm_states[state]);
+	pm_pr_dbg("Preparing system for sleep (%s)\n", mem_sleep_labels[state]);
 	pm_suspend_clear_flags();
 	error = suspend_prepare(state);
 	if (error)
@@ -565,7 +565,7 @@ static int enter_state(suspend_state_t s
 		goto Finish;
 
 	trace_suspend_resume(TPS("suspend_enter"), state, false);
-	pm_pr_dbg("Suspending system (%s)\n", pm_states[state]);
+	pm_pr_dbg("Suspending system (%s)\n", mem_sleep_labels[state]);
 	pm_restrict_gfp_mask();
 	error = suspend_devices_and_enter(state);
 	pm_restore_gfp_mask();
@@ -592,7 +592,7 @@ int pm_suspend(suspend_state_t state)
 	if (state <= PM_SUSPEND_ON || state >= PM_SUSPEND_MAX)
 		return -EINVAL;
 
-	pr_info("PM: suspend entry (%s)\n", pm_states[state]);
+	pr_info("PM: suspend entry (%s)\n", mem_sleep_labels[state]);
 	error = enter_state(state);
 	if (error) {
 		suspend_stats.fail++;
