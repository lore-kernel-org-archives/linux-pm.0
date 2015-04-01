From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH 11/20] ACPI / PAD: Use explicit broadcast oneshot control function
Date: Thu, 02 Apr 2015 00:16:33 +0200
Message-ID: <3739523.xDQFFKjDq1@vostro.rjw.lan>
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
Cc: Len Brown <lenb@kernel.org>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/acpi_pad.c |    6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

Index: linux-pm/drivers/acpi/acpi_pad.c
===================================================================
--- linux-pm.orig/drivers/acpi/acpi_pad.c
+++ linux-pm/drivers/acpi/acpi_pad.c
@@ -150,7 +150,6 @@ static int power_saving_thread(void *dat
 	sched_setscheduler(current, SCHED_RR, &param);
 
 	while (!kthread_should_stop()) {
-		int cpu;
 		unsigned long expire_time;
 
 		try_to_freeze();
@@ -174,14 +173,13 @@ static int power_saving_thread(void *dat
 			}
 			local_irq_disable();
 			tick_broadcast_enable();
-			cpu = smp_processor_id();
-			clockevents_notify(CLOCK_EVT_NOTIFY_BROADCAST_ENTER, &cpu);
+			tick_broadcast_enter();
 			stop_critical_timings();
 
 			mwait_idle_with_hints(power_saving_mwait_eax, 1);
 
 			start_critical_timings();
-			clockevents_notify(CLOCK_EVT_NOTIFY_BROADCAST_EXIT, &cpu);
+			tick_broadcast_exit();
 			local_irq_enable();
 
 			if (time_before(expire_time, jiffies)) {
