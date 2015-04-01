From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH 03/20] ACPI / PAD: Use explicit broadcast control function
Date: Thu, 02 Apr 2015 00:05:38 +0200
Message-ID: <4790376.h4quxo3KjU@vostro.rjw.lan>
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
 drivers/acpi/acpi_pad.c |    5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

Index: linux-pm/drivers/acpi/acpi_pad.c
===================================================================
--- linux-pm.orig/drivers/acpi/acpi_pad.c
+++ linux-pm/drivers/acpi/acpi_pad.c
@@ -26,7 +26,7 @@
 #include <linux/kthread.h>
 #include <linux/freezer.h>
 #include <linux/cpu.h>
-#include <linux/clockchips.h>
+#include <linux/tick.h>
 #include <linux/slab.h>
 #include <linux/acpi.h>
 #include <asm/mwait.h>
@@ -172,9 +172,8 @@ static int power_saving_thread(void *dat
 				mark_tsc_unstable("TSC halts in idle");
 				tsc_marked_unstable = 1;
 			}
-			clockevents_notify(CLOCK_EVT_NOTIFY_BROADCAST_ON, &cpu);
-
 			local_irq_disable();
+			tick_broadcast_enable();
 			cpu = smp_processor_id();
 			clockevents_notify(CLOCK_EVT_NOTIFY_BROADCAST_ENTER, &cpu);
 			stop_critical_timings();
