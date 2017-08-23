From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH 3/3] cpuidle: Make drivers initialize polling state
Date: Wed, 23 Aug 2017 23:22:20 +0200
Message-ID: <3097942.7PMynB0Xpq@aspire.rjw.lan>
References: <21794463.WNaOdcSnfv@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:50548 "EHLO
        cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750715AbdHWVb2 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 23 Aug 2017 17:31:28 -0400
In-Reply-To: <21794463.WNaOdcSnfv@aspire.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Len Brown <len.brown@intel.com>, Linux ACPI <linux-acpi@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, Jacob Pan <jacob.jun.pan@linux.intel.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Sudeep Holla <sudeep.holla@arm.com>

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Make the drivers that want to include the polling state into their
states table initialize it explicitly and drop the initialization of
it (which in fact is conditional, but that is not obvious from the
code) from the core.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/processor_idle.c |    9 ++++++++-
 drivers/cpuidle/driver.c      |    2 --
 drivers/cpuidle/poll_state.c  |    3 ++-
 drivers/idle/intel_idle.c     |    1 +
 include/linux/cpuidle.h       |    4 +---
 5 files changed, 12 insertions(+), 7 deletions(-)

Index: linux-pm/drivers/acpi/processor_idle.c
===================================================================
--- linux-pm.orig/drivers/acpi/processor_idle.c
+++ linux-pm/drivers/acpi/processor_idle.c
@@ -842,7 +842,7 @@ static int acpi_processor_setup_cpuidle_
 
 static int acpi_processor_setup_cstates(struct acpi_processor *pr)
 {
-	int i, count = ACPI_IDLE_STATE_START;
+	int i, count;
 	struct acpi_processor_cx *cx;
 	struct cpuidle_state *state;
 	struct cpuidle_driver *drv = &acpi_idle_driver;
@@ -850,6 +850,13 @@ static int acpi_processor_setup_cstates(
 	if (max_cstate == 0)
 		max_cstate = 1;
 
+	if (IS_ENABLED(CONFIG_ARCH_HAS_CPU_RELAX)) {
+		cpuidle_poll_state_init(drv);
+		count = 1;
+	} else {
+		count = 0;
+	}
+
 	for (i = 1; i < ACPI_PROCESSOR_MAX_POWER && i <= max_cstate; i++) {
 		cx = &pr->power.states[i];
 
Index: linux-pm/drivers/cpuidle/driver.c
===================================================================
--- linux-pm.orig/drivers/cpuidle/driver.c
+++ linux-pm/drivers/cpuidle/driver.c
@@ -216,8 +216,6 @@ static int __cpuidle_register_driver(str
 		on_each_cpu_mask(drv->cpumask, cpuidle_setup_broadcast_timer,
 				 (void *)1, 1);
 
-	poll_idle_init(drv);
-
 	return 0;
 }
 
Index: linux-pm/drivers/cpuidle/poll_state.c
===================================================================
--- linux-pm.orig/drivers/cpuidle/poll_state.c
+++ linux-pm/drivers/cpuidle/poll_state.c
@@ -21,7 +21,7 @@ static int __cpuidle poll_idle(struct cp
 	return index;
 }
 
-void poll_idle_init(struct cpuidle_driver *drv)
+void cpuidle_poll_state_init(struct cpuidle_driver *drv)
 {
 	struct cpuidle_state *state = &drv->states[0];
 
@@ -34,3 +34,4 @@ void poll_idle_init(struct cpuidle_drive
 	state->disabled = false;
 	state->flags = CPUIDLE_FLAG_POLLING;
 }
+EXPORT_SYMBOL_GPL(cpuidle_poll_state_init);
Index: linux-pm/include/linux/cpuidle.h
===================================================================
--- linux-pm.orig/include/linux/cpuidle.h
+++ linux-pm/include/linux/cpuidle.h
@@ -226,9 +226,7 @@ static inline void cpuidle_coupled_paral
 #endif
 
 #ifdef CONFIG_ARCH_HAS_CPU_RELAX
-void poll_idle_init(struct cpuidle_driver *drv);
-#else
-static void poll_idle_init(struct cpuidle_driver *drv) {}
+void cpuidle_poll_state_init(struct cpuidle_driver *drv);
 #endif
 
 /******************************
Index: linux-pm/drivers/idle/intel_idle.c
===================================================================
--- linux-pm.orig/drivers/idle/intel_idle.c
+++ linux-pm/drivers/idle/intel_idle.c
@@ -1331,6 +1331,7 @@ static void __init intel_idle_cpuidle_dr
 
 	intel_idle_state_table_update();
 
+	cpuidle_poll_state_init(drv);
 	drv->state_count = 1;
 
 	for (cstate = 0; cstate < CPUIDLE_STATE_MAX; ++cstate) {
