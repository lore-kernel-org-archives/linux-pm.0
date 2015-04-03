From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [v2][PATCH 12/21] ACPI / PAD: Use explicit broadcast oneshot control function
Date: Fri, 03 Apr 2015 02:06:37 +0200
Message-ID: <1552509.UntNmyqF5v@vostro.rjw.lan>
References: <2112147.0kYCHhbEJT@vostro.rjw.lan> <2186067.gb1n6y4Zoc@vostro.rjw.lan> <3410621.5uMny9y0B7@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:59042 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1752818AbbDCAQR (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 2 Apr 2015 20:16:17 -0400
In-Reply-To: <3410621.5uMny9y0B7@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>, Linux PM list <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Len Brown <lenb@kernel.org>

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

