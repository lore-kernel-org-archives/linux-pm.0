From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [v2][PATCH 09/21] clockevents: Remove the broadcast control leftovers
Date: Fri, 03 Apr 2015 02:03:42 +0200
Message-ID: <2076318.76XJZ8QYP3@vostro.rjw.lan>
References: <2112147.0kYCHhbEJT@vostro.rjw.lan> <2186067.gb1n6y4Zoc@vostro.rjw.lan> <3410621.5uMny9y0B7@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <3410621.5uMny9y0B7@vostro.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>, Linux PM list <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

From: Thomas Gleixner <tglx@linutronix.de>

All users converted. Remove the notify leftovers.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 include/linux/clockchips.h |    3 ---
 kernel/time/clockevents.c  |   10 ----------
 2 files changed, 13 deletions(-)

Index: linux-pm/include/linux/clockchips.h
===================================================================
--- linux-pm.orig/include/linux/clockchips.h
+++ linux-pm/include/linux/clockchips.h
@@ -11,9 +11,6 @@
 /* Clock event notification values */
 enum clock_event_nofitiers {
 	CLOCK_EVT_NOTIFY_ADD,
-	CLOCK_EVT_NOTIFY_BROADCAST_ON,
-	CLOCK_EVT_NOTIFY_BROADCAST_OFF,
-	CLOCK_EVT_NOTIFY_BROADCAST_FORCE,
 	CLOCK_EVT_NOTIFY_BROADCAST_ENTER,
 	CLOCK_EVT_NOTIFY_BROADCAST_EXIT,
 	CLOCK_EVT_NOTIFY_CPU_DYING,
Index: linux-pm/kernel/time/clockevents.c
===================================================================
--- linux-pm.orig/kernel/time/clockevents.c
+++ linux-pm/kernel/time/clockevents.c
@@ -655,16 +655,6 @@ int clockevents_notify(unsigned long rea
 	raw_spin_lock_irqsave(&clockevents_lock, flags);
 
 	switch (reason) {
-	case CLOCK_EVT_NOTIFY_BROADCAST_ON:
-		tick_broadcast_enable();
-		break;
-	case CLOCK_EVT_NOTIFY_BROADCAST_OFF:
-		tick_broadcast_disable();
-		break;
-	case CLOCK_EVT_NOTIFY_BROADCAST_FORCE:
-		tick_broadcast_force();
-		break;
-
 	case CLOCK_EVT_NOTIFY_BROADCAST_ENTER:
 	case CLOCK_EVT_NOTIFY_BROADCAST_EXIT:
 		ret = tick_broadcast_oneshot_control(reason);
