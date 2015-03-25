From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH 02/09] tick: Move clocksource related stuff to timekeeping.h
Date: Wed, 25 Mar 2015 13:06:04 +0100
Message-ID: <2714218.nM5AEfAHj0@vostro.rjw.lan>
References: <20150216121435.203983131@infradead.org> <4241632.Wi7SZdKMQs@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:55718 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1752456AbbCYLuB (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 25 Mar 2015 07:50:01 -0400
In-Reply-To: <4241632.Wi7SZdKMQs@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>
Cc: linux-kernel@vger.kernel.org, mingo@kernel.org, tglx@linutronix.de, Linux PM list <linux-pm@vger.kernel.org>

From: Thomas Gleixner <tglx@linutronix.de>

Move clocksource related stuff to timekeeping.h and remove the
pointless include from ntp.c

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
[ rjw: Subject ]
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 kernel/time/clocksource.c   |    2 +-
 kernel/time/jiffies.c       |    2 +-
 kernel/time/ntp.c           |    1 -
 kernel/time/tick-internal.h |    6 ------
 kernel/time/timekeeping.h   |    7 +++++++
 5 files changed, 9 insertions(+), 9 deletions(-)

Index: linux-pm/kernel/time/clocksource.c
===================================================================
--- linux-pm.orig/kernel/time/clocksource.c
+++ linux-pm/kernel/time/clocksource.c
@@ -31,7 +31,7 @@
 #include <linux/tick.h>
 #include <linux/kthread.h>
 
-#include "tick-internal.h"
+#include "timekeeping.h"
 #include "timekeeping_internal.h"
 
 /**
Index: linux-pm/kernel/time/jiffies.c
===================================================================
--- linux-pm.orig/kernel/time/jiffies.c
+++ linux-pm/kernel/time/jiffies.c
@@ -25,7 +25,7 @@
 #include <linux/module.h>
 #include <linux/init.h>
 
-#include "tick-internal.h"
+#include "timekeeping.h"
 
 /* The Jiffies based clocksource is the lowest common
  * denominator clock source which should function on
Index: linux-pm/kernel/time/ntp.c
===================================================================
--- linux-pm.orig/kernel/time/ntp.c
+++ linux-pm/kernel/time/ntp.c
@@ -17,7 +17,6 @@
 #include <linux/module.h>
 #include <linux/rtc.h>
 
-#include "tick-internal.h"
 #include "ntp_internal.h"
 
 /*
Index: linux-pm/kernel/time/tick-internal.h
===================================================================
--- linux-pm.orig/kernel/time/tick-internal.h
+++ linux-pm/kernel/time/tick-internal.h
@@ -6,10 +6,6 @@
 
 #include "timekeeping.h"
 
-extern seqlock_t jiffies_lock;
-
-#define CS_NAME_LEN	32
-
 #ifdef CONFIG_GENERIC_CLOCKEVENTS
 
 #define TICK_DO_TIMER_NONE	-1
@@ -168,5 +164,3 @@ int __clockevents_update_freq(struct clo
 
 #endif /* GENERIC_CLOCKEVENTS */
 
-extern void do_timer(unsigned long ticks);
-extern void update_wall_time(void);
Index: linux-pm/kernel/time/timekeeping.h
===================================================================
--- linux-pm.orig/kernel/time/timekeeping.h
+++ linux-pm/kernel/time/timekeeping.h
@@ -19,4 +19,11 @@ extern void timekeeping_clocktai(struct
 extern int timekeeping_suspend(void);
 extern void timekeeping_resume(void);
 
+extern void do_timer(unsigned long ticks);
+extern void update_wall_time(void);
+
+extern seqlock_t jiffies_lock;
+
+#define CS_NAME_LEN	32
+
 #endif

