From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH 08/20] clockevents: Remove the broadcast control leftovers
Date: Thu, 02 Apr 2015 00:11:35 +0200
Message-ID: <1738668.OC3r2H2Jb9@vostro.rjw.lan>
References: <2112147.0kYCHhbEJT@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:57652 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1753067AbbDAWDd (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 1 Apr 2015 18:03:33 -0400
In-Reply-To: <2112147.0kYCHhbEJT@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>

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

