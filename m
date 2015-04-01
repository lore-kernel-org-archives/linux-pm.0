From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH 14/20] ARM: OMAP: Use explicit broadcast oneshot control function
Date: Thu, 02 Apr 2015 00:20:22 +0200
Message-ID: <1538465.2kJSbeWq7A@vostro.rjw.lan>
References: <2112147.0kYCHhbEJT@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <2112147.0kYCHhbEJT@vostro.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Tony Lindgren <tony@atomide.com>
List-Id: linux-pm@vger.kernel.org

From: Thomas Gleixner <tglx@linutronix.de>

Replace the clockevents_notify() call with an explicit function call.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Tony Lindgren <tony@atomide.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 arch/arm/mach-omap2/cpuidle44xx.c |    5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

Index: linux-pm/arch/arm/mach-omap2/cpuidle44xx.c
===================================================================
--- linux-pm.orig/arch/arm/mach-omap2/cpuidle44xx.c
+++ linux-pm/arch/arm/mach-omap2/cpuidle44xx.c
@@ -83,7 +83,6 @@ static int omap_enter_idle_coupled(struc
 {
 	struct idle_statedata *cx = state_ptr + index;
 	u32 mpuss_can_lose_context = 0;
-	int cpu_id = smp_processor_id();
 
 	/*
 	 * CPU0 has to wait and stay ON until CPU1 is OFF state.
@@ -111,7 +110,7 @@ static int omap_enter_idle_coupled(struc
 	mpuss_can_lose_context = (cx->mpu_state == PWRDM_POWER_RET) &&
 				 (cx->mpu_logic_state == PWRDM_POWER_OFF);
 
-	clockevents_notify(CLOCK_EVT_NOTIFY_BROADCAST_ENTER, &cpu_id);
+	tick_broadcast_enter();
 
 	/*
 	 * Call idle CPU PM enter notifier chain so that
@@ -168,7 +167,7 @@ static int omap_enter_idle_coupled(struc
 	if (dev->cpu == 0 && mpuss_can_lose_context)
 		cpu_cluster_pm_exit();
 
-	clockevents_notify(CLOCK_EVT_NOTIFY_BROADCAST_EXIT, &cpu_id);
+	tick_broadcast_exit();
 
 fail:
 	cpuidle_coupled_parallel_barrier(dev, &abort_barrier);
