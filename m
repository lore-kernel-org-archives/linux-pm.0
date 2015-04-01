From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH 02/20] x86, amd_idle: Use explicit broadcast control function
Date: Thu, 02 Apr 2015 00:04:17 +0200
Message-ID: <1505753.vVVd1XGdGi@vostro.rjw.lan>
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
 arch/x86/kernel/process.c |    9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

Index: linux-pm/arch/x86/kernel/process.c
===================================================================
--- linux-pm.orig/arch/x86/kernel/process.c
+++ linux-pm/arch/x86/kernel/process.c
@@ -9,7 +9,7 @@
 #include <linux/sched.h>
 #include <linux/module.h>
 #include <linux/pm.h>
-#include <linux/clockchips.h>
+#include <linux/tick.h>
 #include <linux/random.h>
 #include <linux/user-return-notifier.h>
 #include <linux/dmi.h>
@@ -377,11 +377,8 @@ static void amd_e400_idle(void)
 
 		if (!cpumask_test_cpu(cpu, amd_e400_c1e_mask)) {
 			cpumask_set_cpu(cpu, amd_e400_c1e_mask);
-			/*
-			 * Force broadcast so ACPI can not interfere.
-			 */
-			clockevents_notify(CLOCK_EVT_NOTIFY_BROADCAST_FORCE,
-					   &cpu);
+			/* Force broadcast so ACPI can not interfere. */
+			tick_broadcast_force();
 			pr_info("Switch to broadcast mode on CPU%d\n", cpu);
 		}
 		clockevents_notify(CLOCK_EVT_NOTIFY_BROADCAST_ENTER, &cpu);
