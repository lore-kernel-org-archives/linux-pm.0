From: Ville Syrjala <ville.syrjala@linux.intel.com>
Subject: [PATCH] Revert "cpuidle: Make drivers initialize polling state"
Date: Mon, 22 Jan 2018 18:27:47 +0200
Message-ID: <20180122162747.19103-1-ville.syrjala@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, Sudeep Holla <sudeep.holla@arm.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, =?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= <ville.syrjala@linux.intel.com>
List-Id: linux-pm@vger.kernel.org

From: Ville Syrjälä <ville.syrjala@linux.intel.com>

This reverts commit 1b39e3f813b4685c7a30ae964d5529a1b0e3a286.

Makes my P3 machine oops somewhere in cpuidle. I suspect
CONFIG_ACPI=n may have something to do with this.

Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Cc: Sudeep Holla <sudeep.holla@arm.com>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
Signed-off-by: Ville Syrjälä <ville.syrjala@linux.intel.com>
---
 drivers/acpi/processor_idle.c | 9 +--------
 drivers/cpuidle/driver.c      | 2 ++
 drivers/cpuidle/poll_state.c  | 3 +--
 drivers/idle/intel_idle.c     | 1 -
 include/linux/cpuidle.h       | 4 ++--
 5 files changed, 6 insertions(+), 13 deletions(-)

diff --git a/drivers/acpi/processor_idle.c b/drivers/acpi/processor_idle.c
index d50a7b6ccddd..cb1c7634e2ca 100644
--- a/drivers/acpi/processor_idle.c
+++ b/drivers/acpi/processor_idle.c
@@ -842,7 +842,7 @@ static int acpi_processor_setup_cpuidle_cx(struct acpi_processor *pr,
 
 static int acpi_processor_setup_cstates(struct acpi_processor *pr)
 {
-	int i, count;
+	int i, count = ACPI_IDLE_STATE_START;
 	struct acpi_processor_cx *cx;
 	struct cpuidle_state *state;
 	struct cpuidle_driver *drv = &acpi_idle_driver;
@@ -850,13 +850,6 @@ static int acpi_processor_setup_cstates(struct acpi_processor *pr)
 	if (max_cstate == 0)
 		max_cstate = 1;
 
-	if (IS_ENABLED(CONFIG_ARCH_HAS_CPU_RELAX)) {
-		cpuidle_poll_state_init(drv);
-		count = 1;
-	} else {
-		count = 0;
-	}
-
 	for (i = 1; i < ACPI_PROCESSOR_MAX_POWER && i <= max_cstate; i++) {
 		cx = &pr->power.states[i];
 
diff --git a/drivers/cpuidle/driver.c b/drivers/cpuidle/driver.c
index dc32f34e68d9..6f694c86f3fa 100644
--- a/drivers/cpuidle/driver.c
+++ b/drivers/cpuidle/driver.c
@@ -216,6 +216,8 @@ static int __cpuidle_register_driver(struct cpuidle_driver *drv)
 		on_each_cpu_mask(drv->cpumask, cpuidle_setup_broadcast_timer,
 				 (void *)1, 1);
 
+	poll_idle_init(drv);
+
 	return 0;
 }
 
diff --git a/drivers/cpuidle/poll_state.c b/drivers/cpuidle/poll_state.c
index 7416b16287de..0db4f7273952 100644
--- a/drivers/cpuidle/poll_state.c
+++ b/drivers/cpuidle/poll_state.c
@@ -21,7 +21,7 @@ static int __cpuidle poll_idle(struct cpuidle_device *dev,
 	return index;
 }
 
-void cpuidle_poll_state_init(struct cpuidle_driver *drv)
+void poll_idle_init(struct cpuidle_driver *drv)
 {
 	struct cpuidle_state *state = &drv->states[0];
 
@@ -34,4 +34,3 @@ void cpuidle_poll_state_init(struct cpuidle_driver *drv)
 	state->disabled = false;
 	state->flags = CPUIDLE_FLAG_POLLING;
 }
-EXPORT_SYMBOL_GPL(cpuidle_poll_state_init);
diff --git a/drivers/idle/intel_idle.c b/drivers/idle/intel_idle.c
index b2ccce5fb071..6d8a4b87e4d5 100644
--- a/drivers/idle/intel_idle.c
+++ b/drivers/idle/intel_idle.c
@@ -1342,7 +1342,6 @@ static void __init intel_idle_cpuidle_driver_init(void)
 
 	intel_idle_state_table_update();
 
-	cpuidle_poll_state_init(drv);
 	drv->state_count = 1;
 
 	for (cstate = 0; cstate < CPUIDLE_STATE_MAX; ++cstate) {
diff --git a/include/linux/cpuidle.h b/include/linux/cpuidle.h
index 8f7788d23b57..bc9f2603fe10 100644
--- a/include/linux/cpuidle.h
+++ b/include/linux/cpuidle.h
@@ -226,9 +226,9 @@ static inline void cpuidle_coupled_parallel_barrier(struct cpuidle_device *dev,
 #endif
 
 #ifdef CONFIG_ARCH_HAS_CPU_RELAX
-void cpuidle_poll_state_init(struct cpuidle_driver *drv);
+void poll_idle_init(struct cpuidle_driver *drv);
 #else
-static inline void cpuidle_poll_state_init(struct cpuidle_driver *drv) {}
+static void poll_idle_init(struct cpuidle_driver *drv) {}
 #endif
 
 /******************************
-- 
2.13.6
