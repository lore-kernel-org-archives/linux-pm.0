From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH 07/09] tick: Make tick_resume_broadcast_oneshot static
Date: Wed, 25 Mar 2015 13:09:55 +0100
Message-ID: <1689058.QkHYDJSRKu@vostro.rjw.lan>
References: <20150216121435.203983131@infradead.org> <4241632.Wi7SZdKMQs@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:63675 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1752072AbbCYLtz (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 25 Mar 2015 07:49:55 -0400
In-Reply-To: <4241632.Wi7SZdKMQs@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>
Cc: linux-kernel@vger.kernel.org, mingo@kernel.org, tglx@linutronix.de, Linux PM list <linux-pm@vger.kernel.org>

From: Thomas Gleixner <tglx@linutronix.de>

Solely used in tick-broadcast.c and the return value is hardcoded 0.
Make it static and void.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 kernel/time/tick-broadcast.c |    7 ++++---
 kernel/time/tick-internal.h  |    2 --
 2 files changed, 4 insertions(+), 5 deletions(-)

Index: linux-pm/kernel/time/tick-broadcast.c
===================================================================
--- linux-pm.orig/kernel/time/tick-broadcast.c
+++ linux-pm/kernel/time/tick-broadcast.c
@@ -37,8 +37,10 @@ static int tick_broadcast_force;
 
 #ifdef CONFIG_TICK_ONESHOT
 static void tick_broadcast_clear_oneshot(int cpu);
+static void tick_resume_broadcast_oneshot(struct clock_event_device *bc);
 #else
 static inline void tick_broadcast_clear_oneshot(int cpu) { }
+static inline void tick_resume_broadcast_oneshot(struct clock_event_device *bc) { }
 #endif
 
 /*
@@ -475,7 +477,7 @@ int tick_resume_broadcast(void)
 			break;
 		case TICKDEV_MODE_ONESHOT:
 			if (!cpumask_empty(tick_broadcast_mask))
-				broadcast = tick_resume_broadcast_oneshot(bc);
+				tick_resume_broadcast_oneshot(bc);
 			break;
 		}
 	}
@@ -541,10 +543,9 @@ static int tick_broadcast_set_event(stru
 	return ret;
 }
 
-int tick_resume_broadcast_oneshot(struct clock_event_device *bc)
+static void tick_resume_broadcast_oneshot(struct clock_event_device *bc)
 {
 	clockevents_set_mode(bc, CLOCK_EVT_MODE_ONESHOT);
-	return 0;
 }
 
 /*
Index: linux-pm/kernel/time/tick-internal.h
===================================================================
--- linux-pm.orig/kernel/time/tick-internal.h
+++ linux-pm/kernel/time/tick-internal.h
@@ -111,7 +111,6 @@ extern void tick_broadcast_setup_oneshot
 extern int tick_broadcast_oneshot_control(unsigned long reason);
 extern void tick_broadcast_switch_to_oneshot(void);
 extern void tick_shutdown_broadcast_oneshot(unsigned int *cpup);
-extern int tick_resume_broadcast_oneshot(struct clock_event_device *bc);
 extern int tick_broadcast_oneshot_active(void);
 extern void tick_check_oneshot_broadcast_this_cpu(void);
 bool tick_broadcast_oneshot_available(void);
@@ -121,7 +120,6 @@ static inline void tick_broadcast_setup_
 static inline int tick_broadcast_oneshot_control(unsigned long reason) { return 0; }
 static inline void tick_broadcast_switch_to_oneshot(void) { }
 static inline void tick_shutdown_broadcast_oneshot(unsigned int *cpup) { }
-static inline int tick_resume_broadcast_oneshot(struct clock_event_device *bc) { return 0; }
 static inline int tick_broadcast_oneshot_active(void) { return 0; }
 static inline void tick_check_oneshot_broadcast_this_cpu(void) { }
 static inline bool tick_broadcast_oneshot_available(void) { return tick_oneshot_possible(); }

