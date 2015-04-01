From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH 04/20] ACPI / processor: Use explicit broadcast control function
Date: Thu, 02 Apr 2015 00:06:38 +0200
Message-ID: <44653310.4pTCfhm0vM@vostro.rjw.lan>
References: <2112147.0kYCHhbEJT@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <2112147.0kYCHhbEJT@vostro.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

From: Thomas Gleixner <tglx@linutronix.de>

Replace the clockevents_notify() call with an explicit function call.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/processor_idle.c |   11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

Index: linux-pm/drivers/acpi/processor_idle.c
===================================================================
--- linux-pm.orig/drivers/acpi/processor_idle.c
+++ linux-pm/drivers/acpi/processor_idle.c
@@ -32,7 +32,7 @@
 #include <linux/acpi.h>
 #include <linux/dmi.h>
 #include <linux/sched.h>       /* need_resched() */
-#include <linux/clockchips.h>
+#include <linux/tick.h>
 #include <linux/cpuidle.h>
 #include <linux/syscore_ops.h>
 #include <acpi/processor.h>
@@ -157,12 +157,11 @@ static void lapic_timer_check_state(int
 static void __lapic_timer_propagate_broadcast(void *arg)
 {
 	struct acpi_processor *pr = (struct acpi_processor *) arg;
-	unsigned long reason;
 
-	reason = pr->power.timer_broadcast_on_state < INT_MAX ?
-		CLOCK_EVT_NOTIFY_BROADCAST_ON : CLOCK_EVT_NOTIFY_BROADCAST_OFF;
-
-	clockevents_notify(reason, &pr->id);
+	if (pr->power.timer_broadcast_on_state < INT_MAX)
+		tick_broadcast_enable();
+	else
+		tick_broadcast_disable();
 }
 
 static void lapic_timer_propagate_broadcast(struct acpi_processor *pr)
