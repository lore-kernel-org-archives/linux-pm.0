From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [v2][PATCH 17/21] sched/idle: Use explicit broadcast oneshot control function
Date: Fri, 03 Apr 2015 02:34:49 +0200
Message-ID: <6422336.RMm7oUHcXh@vostro.rjw.lan>
References: <2112147.0kYCHhbEJT@vostro.rjw.lan> <2186067.gb1n6y4Zoc@vostro.rjw.lan> <3410621.5uMny9y0B7@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <3410621.5uMny9y0B7@vostro.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>, Linux PM list <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

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

