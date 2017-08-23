From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH 2/3] cpuidle: Move polling state initialization code to separate file
Date: Wed, 23 Aug 2017 23:21:07 +0200
Message-ID: <1851353.ppnzGx1n5b@aspire.rjw.lan>
References: <21794463.WNaOdcSnfv@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <21794463.WNaOdcSnfv@aspire.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Len Brown <len.brown@intel.com>, Linux ACPI <linux-acpi@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, Jacob Pan <jacob.jun.pan@linux.intel.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Sudeep Holla <sudeep.holla@arm.com>
List-Id: linux-pm@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Move the polling state initialization code to a separate file built
conditionally on CONFIG_ARCH_HAS_CPU_RELAX to get rid of the #ifdef
in driver.c.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/cpuidle/Makefile     |    1 +
 drivers/cpuidle/driver.c     |   31 -------------------------------
 drivers/cpuidle/poll_state.c |   36 ++++++++++++++++++++++++++++++++++++
 include/linux/cpuidle.h      |    6 ++++++
 4 files changed, 43 insertions(+), 31 deletions(-)

Index: linux-pm/drivers/cpuidle/Makefile
===================================================================
--- linux-pm.orig/drivers/cpuidle/Makefile
+++ linux-pm/drivers/cpuidle/Makefile
@@ -5,6 +5,7 @@
 obj-y += cpuidle.o driver.o governor.o sysfs.o governors/
 obj-$(CONFIG_ARCH_NEEDS_CPU_IDLE_COUPLED) += coupled.o
 obj-$(CONFIG_DT_IDLE_STATES)		  += dt_idle_states.o
+obj-$(CONFIG_ARCH_HAS_CPU_RELAX)	  += poll_state.o
 
 ##################################################################################
 # ARM SoC drivers
Index: linux-pm/drivers/cpuidle/poll_state.c
===================================================================
--- /dev/null
+++ linux-pm/drivers/cpuidle/poll_state.c
@@ -0,0 +1,36 @@
+/*
+ * poll_state.c - Polling idle state
+ *
+ * This file is released under the GPLv2.
+ */
+
+#include <linux/cpuidle.h>
+#include <linux/sched.h>
+#include <linux/sched/idle.h>
+
+static int __cpuidle poll_idle(struct cpuidle_device *dev,
+			       struct cpuidle_driver *drv, int index)
+{
+	local_irq_enable();
+	if (!current_set_polling_and_test()) {
+		while (!need_resched())
+			cpu_relax();
+	}
+	current_clr_polling();
+
+	return index;
+}
+
+void poll_idle_init(struct cpuidle_driver *drv)
+{
+	struct cpuidle_state *state = &drv->states[0];
+
+	snprintf(state->name, CPUIDLE_NAME_LEN, "POLL");
+	snprintf(state->desc, CPUIDLE_DESC_LEN, "CPUIDLE CORE POLL IDLE");
+	state->exit_latency = 0;
+	state->target_residency = 0;
+	state->power_usage = -1;
+	state->enter = poll_idle;
+	state->disabled = false;
+	state->flags = CPUIDLE_FLAG_POLLING;
+}
Index: linux-pm/include/linux/cpuidle.h
===================================================================
--- linux-pm.orig/include/linux/cpuidle.h
+++ linux-pm/include/linux/cpuidle.h
@@ -225,6 +225,12 @@ static inline void cpuidle_coupled_paral
 }
 #endif
 
+#ifdef CONFIG_ARCH_HAS_CPU_RELAX
+void poll_idle_init(struct cpuidle_driver *drv);
+#else
+static void poll_idle_init(struct cpuidle_driver *drv) {}
+#endif
+
 /******************************
  * CPUIDLE GOVERNOR INTERFACE *
  ******************************/
Index: linux-pm/drivers/cpuidle/driver.c
===================================================================
--- linux-pm.orig/drivers/cpuidle/driver.c
+++ linux-pm/drivers/cpuidle/driver.c
@@ -179,37 +179,6 @@ static void __cpuidle_driver_init(struct
 	}
 }
 
-#ifdef CONFIG_ARCH_HAS_CPU_RELAX
-static int __cpuidle poll_idle(struct cpuidle_device *dev,
-			       struct cpuidle_driver *drv, int index)
-{
-	local_irq_enable();
-	if (!current_set_polling_and_test()) {
-		while (!need_resched())
-			cpu_relax();
-	}
-	current_clr_polling();
-
-	return index;
-}
-
-static void poll_idle_init(struct cpuidle_driver *drv)
-{
-	struct cpuidle_state *state = &drv->states[0];
-
-	snprintf(state->name, CPUIDLE_NAME_LEN, "POLL");
-	snprintf(state->desc, CPUIDLE_DESC_LEN, "CPUIDLE CORE POLL IDLE");
-	state->exit_latency = 0;
-	state->target_residency = 0;
-	state->power_usage = -1;
-	state->enter = poll_idle;
-	state->disabled = false;
-	state->flags = CPUIDLE_FLAG_POLLING;
-}
-#else
-static void poll_idle_init(struct cpuidle_driver *drv) {}
-#endif /* !CONFIG_ARCH_HAS_CPU_RELAX */
-
 /**
  * __cpuidle_register_driver: register the driver
  * @drv: a valid pointer to a struct cpuidle_driver


