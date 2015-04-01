From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH 16/20] sched/idle: Use explicit broadcast oneshot control function
Date: Thu, 02 Apr 2015 00:22:19 +0200
Message-ID: <18575128.8R6Lp68k0Q@vostro.rjw.lan>
References: <2112147.0kYCHhbEJT@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:64014 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1752688AbbDAWD1 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 1 Apr 2015 18:03:27 -0400
In-Reply-To: <2112147.0kYCHhbEJT@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>

From: Thomas Gleixner <tglx@linutronix.de>

Replace the clockevents_notify() call with an explicit function call.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 kernel/sched/idle.c |    5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

Index: linux-pm/kernel/sched/idle.c
===================================================================
--- linux-pm.orig/kernel/sched/idle.c
+++ linux-pm/kernel/sched/idle.c
@@ -158,8 +158,7 @@ static void cpuidle_idle_call(void)
 	 * is used from another cpu as a broadcast timer, this call may
 	 * fail if it is not available
 	 */
-	if (broadcast &&
-	    clockevents_notify(CLOCK_EVT_NOTIFY_BROADCAST_ENTER, &dev->cpu))
+	if (broadcast && tick_broadcast_enter())
 		goto use_default;
 
 	/* Take note of the planned idle state. */
@@ -176,7 +175,7 @@ static void cpuidle_idle_call(void)
 	idle_set_state(this_rq(), NULL);
 
 	if (broadcast)
-		clockevents_notify(CLOCK_EVT_NOTIFY_BROADCAST_EXIT, &dev->cpu);
+		tick_broadcast_exit();
 
 	/*
 	 * Give the governor an opportunity to reflect on the outcome

