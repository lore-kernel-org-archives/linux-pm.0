From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH 1/5] ACPI / cpuidle: Drop unnecessary calls from ->enter callback routines
Date: Thu, 29 Jan 2015 19:26:40 +0100
Message-ID: <5308198.07iHoh2qOo@vostro.rjw.lan>
References: <8966777.6Ih8y2AWPy@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <8966777.6Ih8y2AWPy@vostro.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: Linux PM list <linux-pm@vger.kernel.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Len Brown <len.brown@intel.com>, Peter Zijlstra <peterz@infradead.org>
List-Id: linux-pm@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

acpi_idle_enter_simple() and acpi_idle_enter_bm() don't need to
call sched_clock_idle_sleep/wakeup_event(), because that's taken
care of by the core already.  Namely, sched_clock_idle_sleep_event()
is called by tick_nohz_start_idle() called by __tick_nohz_idle_enter()
which in turn is called by tick_nohz_idle_enter() and that is called
by cpu_idle_loop().  Analogously for sched_clock_idle_wakeup_event().

For this reason, drop those calls from the ACPI cpuidle driver's
->enter callback routines.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/processor_idle.c |    8 --------
 1 file changed, 8 deletions(-)

Index: linux-pm/drivers/acpi/processor_idle.c
===================================================================
--- linux-pm.orig/drivers/acpi/processor_idle.c
+++ linux-pm/drivers/acpi/processor_idle.c
@@ -791,12 +791,8 @@ static int acpi_idle_enter_simple(struct
 	if (cx->type == ACPI_STATE_C3)
 		ACPI_FLUSH_CPU_CACHE();
 
-	/* Tell the scheduler that we are going deep-idle: */
-	sched_clock_idle_sleep_event();
 	acpi_idle_do_entry(cx);
 
-	sched_clock_idle_wakeup_event(0);
-
 	lapic_timer_state_broadcast(pr, cx, 0);
 	return index;
 }
@@ -842,8 +838,6 @@ static int acpi_idle_enter_bm(struct cpu
 
 	acpi_unlazy_tlb(smp_processor_id());
 
-	/* Tell the scheduler that we are going deep-idle: */
-	sched_clock_idle_sleep_event();
 	/*
 	 * Must be done before busmaster disable as we might need to
 	 * access HPET !
@@ -881,8 +875,6 @@ static int acpi_idle_enter_bm(struct cpu
 		raw_spin_unlock(&c3_lock);
 	}
 
-	sched_clock_idle_wakeup_event(0);
-
 	lapic_timer_state_broadcast(pr, cx, 0);
 	return index;
 }
