From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [v2][PATCH 18/21] clockevents: Remove broadcast oneshot control leftovers
Date: Fri, 03 Apr 2015 02:36:10 +0200
Message-ID: <14018863.NQUzkFuafr@vostro.rjw.lan>
References: <2112147.0kYCHhbEJT@vostro.rjw.lan> <2186067.gb1n6y4Zoc@vostro.rjw.lan> <3410621.5uMny9y0B7@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:64454 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1752428AbbDCAQN (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 2 Apr 2015 20:16:13 -0400
In-Reply-To: <3410621.5uMny9y0B7@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>, Linux PM list <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

All users converted. Remove the notify leftovers.

Original-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 include/linux/clockchips.h |    2 --
 kernel/time/clockevents.c  |    7 -------
 2 files changed, 9 deletions(-)

Index: linux-pm/include/linux/clockchips.h
===================================================================
--- linux-pm.orig/include/linux/clockchips.h
+++ linux-pm/include/linux/clockchips.h
@@ -11,8 +11,6 @@
 /* Clock event notification values */
 enum clock_event_nofitiers {
 	CLOCK_EVT_NOTIFY_ADD,
-	CLOCK_EVT_NOTIFY_BROADCAST_ENTER,
-	CLOCK_EVT_NOTIFY_BROADCAST_EXIT,
 	CLOCK_EVT_NOTIFY_CPU_DYING,
 	CLOCK_EVT_NOTIFY_CPU_DEAD,
 };
Index: linux-pm/kernel/time/clockevents.c
===================================================================
--- linux-pm.orig/kernel/time/clockevents.c
+++ linux-pm/kernel/time/clockevents.c
@@ -655,13 +655,6 @@ int clockevents_notify(unsigned long rea
 	raw_spin_lock_irqsave(&clockevents_lock, flags);
 
 	switch (reason) {
-	case CLOCK_EVT_NOTIFY_BROADCAST_ENTER:
-		tick_broadcast_enter();
-		break;
-	case CLOCK_EVT_NOTIFY_BROADCAST_EXIT:
-		tick_broadcast_exit();
-		break;
-
 	case CLOCK_EVT_NOTIFY_CPU_DYING:
 		tick_handover_do_timer(arg);
 		break;

