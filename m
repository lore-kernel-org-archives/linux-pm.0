From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH 06/20] intel_idle: Use explicit broadcast control function
Date: Thu, 02 Apr 2015 00:09:08 +0200
Message-ID: <3382562.F0MqkLYgXp@vostro.rjw.lan>
References: <2112147.0kYCHhbEJT@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <2112147.0kYCHhbEJT@vostro.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Len Brown <lenb@kernel.org>
List-Id: linux-pm@vger.kernel.org

From: Thomas Gleixner <tglx@linutronix.de>

Replace the clockevents_notify() call with an explicit function call.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Len Brown <lenb@kernel.org>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/idle/intel_idle.c |   13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

Index: linux-pm/drivers/idle/intel_idle.c
===================================================================
--- linux-pm.orig/drivers/idle/intel_idle.c
+++ linux-pm/drivers/idle/intel_idle.c
@@ -55,7 +55,7 @@
 
 #include <linux/kernel.h>
 #include <linux/cpuidle.h>
-#include <linux/clockchips.h>
+#include <linux/tick.h>
 #include <trace/events/power.h>
 #include <linux/sched.h>
 #include <linux/notifier.h>
@@ -668,13 +668,12 @@ static void intel_idle_freeze(struct cpu
 
 static void __setup_broadcast_timer(void *arg)
 {
-	unsigned long reason = (unsigned long)arg;
-	int cpu = smp_processor_id();
-
-	reason = reason ?
-		CLOCK_EVT_NOTIFY_BROADCAST_ON : CLOCK_EVT_NOTIFY_BROADCAST_OFF;
+	unsigned long on = (unsigned long)arg;
 
-	clockevents_notify(reason, &cpu);
+	if (on)
+		tick_broadcast_enable();
+	else
+		tick_broadcast_disable();
 }
 
 static int cpu_hotplug_notify(struct notifier_block *n,
