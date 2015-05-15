From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH 2/2] PM / sleep: Make ->enter_freeze callbacks depend on CONFIG_SUSPEND
Date: Sat, 16 May 2015 01:38:48 +0200
Message-ID: <2834114.lD6BFXhtqK@vostro.rjw.lan>
References: <7138791.PFSSF2gqXk@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <7138791.PFSSF2gqXk@vostro.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: Linux PM list <linux-pm@vger.kernel.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Peter Zijlstra <peterz@infradead.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, Len Brown <len.brown@intel.com>
List-Id: linux-pm@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

The ->enter_freeze callbacks of cpuidle drivers are only used if
CONFIG_SUSPEND is set, so make them explicitly depend on that
Kconfig option.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/processor_idle.c |   11 ++
 drivers/cpuidle/cpuidle.c     |    2 
 drivers/idle/intel_idle.c     |  186 +++++++++++++++---------------------------
 include/linux/cpuidle.h       |   14 +++
 4 files changed, 93 insertions(+), 120 deletions(-)

Index: linux-pm/include/linux/cpuidle.h
===================================================================
--- linux-pm.orig/include/linux/cpuidle.h
+++ linux-pm/include/linux/cpuidle.h
@@ -51,6 +51,7 @@ struct cpuidle_state {
 
 	int (*enter_dead) (struct cpuidle_device *dev, int index);
 
+#ifdef CONFIG_SUSPEND
 	/*
 	 * CPUs execute ->enter_freeze with the local tick or entire timekeeping
 	 * suspended, so it must not re-enable interrupts at any point (even
@@ -59,6 +60,7 @@ struct cpuidle_state {
 	void (*enter_freeze) (struct cpuidle_device *dev,
 			      struct cpuidle_driver *drv,
 			      int index);
+#endif
 };
 
 /* Idle State Flags */
@@ -67,6 +69,18 @@ struct cpuidle_state {
 
 #define CPUIDLE_DRIVER_FLAGS_MASK (0xFFFF0000)
 
+#ifdef CONFIG_SUSPEND
+static inline bool cpuidle_has_enter_freeze(struct cpuidle_state *state)
+{
+	return !!state->enter_freeze;
+}
+#else
+static inline bool cpuidle_has_enter_freeze(struct cpuidle_state *state)
+{
+	return false;
+}
+#endif
+
 struct cpuidle_device_kobj;
 struct cpuidle_state_kobj;
 struct cpuidle_driver_kobj;
Index: linux-pm/drivers/acpi/processor_idle.c
===================================================================
--- linux-pm.orig/drivers/acpi/processor_idle.c
+++ linux-pm/drivers/acpi/processor_idle.c
@@ -827,6 +827,7 @@ static int acpi_idle_enter(struct cpuidl
 	return index;
 }
 
+#ifdef CONFIG_SUSPEND
 static void acpi_idle_enter_freeze(struct cpuidle_device *dev,
 				   struct cpuidle_driver *drv, int index)
 {
@@ -848,6 +849,14 @@ static void acpi_idle_enter_freeze(struc
 	acpi_idle_do_entry(cx);
 }
 
+static inline void set_enter_freeze(struct cpuidle_state *state)
+{
+	state->enter_freeze = acpi_idle_enter_freeze;
+}
+#else
+static inline void set_enter_freeze(struct cpuidle_state *state) {}
+#endif
+
 struct cpuidle_driver acpi_idle_driver = {
 	.name =		"acpi_idle",
 	.owner =	THIS_MODULE,
@@ -954,7 +963,7 @@ static int acpi_processor_setup_cpuidle_
 		 * to it altogether.
 		 */
 		if (cx->type != ACPI_STATE_C1 && !acpi_idle_fallback_to_c1(pr))
-			state->enter_freeze = acpi_idle_enter_freeze;
+			set_enter_freeze(state);
 
 		count++;
 		if (count == CPUIDLE_STATE_MAX)
Index: linux-pm/drivers/idle/intel_idle.c
===================================================================
--- linux-pm.orig/drivers/idle/intel_idle.c
+++ linux-pm/drivers/idle/intel_idle.c
@@ -97,8 +97,6 @@ static const struct idle_cpu *icpu;
 static struct cpuidle_device __percpu *intel_idle_cpuidle_devices;
 static int intel_idle(struct cpuidle_device *dev,
 			struct cpuidle_driver *drv, int index);
-static void intel_idle_freeze(struct cpuidle_device *dev,
-			      struct cpuidle_driver *drv, int index);
 static int intel_idle_cpu_init(int cpu);
 
 static struct cpuidle_state *cpuidle_state_table;
@@ -133,32 +131,28 @@ static struct cpuidle_state nehalem_csta
 		.flags = MWAIT2flg(0x00),
 		.exit_latency = 3,
 		.target_residency = 6,
-		.enter = &intel_idle,
-		.enter_freeze = intel_idle_freeze, },
+		.enter = &intel_idle, },
 	{
 		.name = "C1E-NHM",
 		.desc = "MWAIT 0x01",
 		.flags = MWAIT2flg(0x01),
 		.exit_latency = 10,
 		.target_residency = 20,
-		.enter = &intel_idle,
-		.enter_freeze = intel_idle_freeze, },
+		.enter = &intel_idle, },
 	{
 		.name = "C3-NHM",
 		.desc = "MWAIT 0x10",
 		.flags = MWAIT2flg(0x10) | CPUIDLE_FLAG_TLB_FLUSHED,
 		.exit_latency = 20,
 		.target_residency = 80,
-		.enter = &intel_idle,
-		.enter_freeze = intel_idle_freeze, },
+		.enter = &intel_idle, },
 	{
 		.name = "C6-NHM",
 		.desc = "MWAIT 0x20",
 		.flags = MWAIT2flg(0x20) | CPUIDLE_FLAG_TLB_FLUSHED,
 		.exit_latency = 200,
 		.target_residency = 800,
-		.enter = &intel_idle,
-		.enter_freeze = intel_idle_freeze, },
+		.enter = &intel_idle, },
 	{
 		.enter = NULL }
 };
@@ -170,40 +164,35 @@ static struct cpuidle_state snb_cstates[
 		.flags = MWAIT2flg(0x00),
 		.exit_latency = 2,
 		.target_residency = 2,
-		.enter = &intel_idle,
-		.enter_freeze = intel_idle_freeze, },
+		.enter = &intel_idle, },
 	{
 		.name = "C1E-SNB",
 		.desc = "MWAIT 0x01",
 		.flags = MWAIT2flg(0x01),
 		.exit_latency = 10,
 		.target_residency = 20,
-		.enter = &intel_idle,
-		.enter_freeze = intel_idle_freeze, },
+		.enter = &intel_idle, },
 	{
 		.name = "C3-SNB",
 		.desc = "MWAIT 0x10",
 		.flags = MWAIT2flg(0x10) | CPUIDLE_FLAG_TLB_FLUSHED,
 		.exit_latency = 80,
 		.target_residency = 211,
-		.enter = &intel_idle,
-		.enter_freeze = intel_idle_freeze, },
+		.enter = &intel_idle, },
 	{
 		.name = "C6-SNB",
 		.desc = "MWAIT 0x20",
 		.flags = MWAIT2flg(0x20) | CPUIDLE_FLAG_TLB_FLUSHED,
 		.exit_latency = 104,
 		.target_residency = 345,
-		.enter = &intel_idle,
-		.enter_freeze = intel_idle_freeze, },
+		.enter = &intel_idle, },
 	{
 		.name = "C7-SNB",
 		.desc = "MWAIT 0x30",
 		.flags = MWAIT2flg(0x30) | CPUIDLE_FLAG_TLB_FLUSHED,
 		.exit_latency = 109,
 		.target_residency = 345,
-		.enter = &intel_idle,
-		.enter_freeze = intel_idle_freeze, },
+		.enter = &intel_idle, },
 	{
 		.enter = NULL }
 };
@@ -215,40 +204,35 @@ static struct cpuidle_state byt_cstates[
 		.flags = MWAIT2flg(0x00),
 		.exit_latency = 1,
 		.target_residency = 1,
-		.enter = &intel_idle,
-		.enter_freeze = intel_idle_freeze, },
+		.enter = &intel_idle, },
 	{
 		.name = "C6N-BYT",
 		.desc = "MWAIT 0x58",
 		.flags = MWAIT2flg(0x58) | CPUIDLE_FLAG_TLB_FLUSHED,
 		.exit_latency = 300,
 		.target_residency = 275,
-		.enter = &intel_idle,
-		.enter_freeze = intel_idle_freeze, },
+		.enter = &intel_idle, },
 	{
 		.name = "C6S-BYT",
 		.desc = "MWAIT 0x52",
 		.flags = MWAIT2flg(0x52) | CPUIDLE_FLAG_TLB_FLUSHED,
 		.exit_latency = 500,
 		.target_residency = 560,
-		.enter = &intel_idle,
-		.enter_freeze = intel_idle_freeze, },
+		.enter = &intel_idle, },
 	{
 		.name = "C7-BYT",
 		.desc = "MWAIT 0x60",
 		.flags = MWAIT2flg(0x60) | CPUIDLE_FLAG_TLB_FLUSHED,
 		.exit_latency = 1200,
 		.target_residency = 4000,
-		.enter = &intel_idle,
-		.enter_freeze = intel_idle_freeze, },
+		.enter = &intel_idle, },
 	{
 		.name = "C7S-BYT",
 		.desc = "MWAIT 0x64",
 		.flags = MWAIT2flg(0x64) | CPUIDLE_FLAG_TLB_FLUSHED,
 		.exit_latency = 10000,
 		.target_residency = 20000,
-		.enter = &intel_idle,
-		.enter_freeze = intel_idle_freeze, },
+		.enter = &intel_idle, },
 	{
 		.enter = NULL }
 };
@@ -260,40 +244,35 @@ static struct cpuidle_state cht_cstates[
 		.flags = MWAIT2flg(0x00),
 		.exit_latency = 1,
 		.target_residency = 1,
-		.enter = &intel_idle,
-		.enter_freeze = intel_idle_freeze, },
+		.enter = &intel_idle, },
 	{
 		.name = "C6N-CHT",
 		.desc = "MWAIT 0x58",
 		.flags = MWAIT2flg(0x58) | CPUIDLE_FLAG_TLB_FLUSHED,
 		.exit_latency = 80,
 		.target_residency = 275,
-		.enter = &intel_idle,
-		.enter_freeze = intel_idle_freeze, },
+		.enter = &intel_idle, },
 	{
 		.name = "C6S-CHT",
 		.desc = "MWAIT 0x52",
 		.flags = MWAIT2flg(0x52) | CPUIDLE_FLAG_TLB_FLUSHED,
 		.exit_latency = 200,
 		.target_residency = 560,
-		.enter = &intel_idle,
-		.enter_freeze = intel_idle_freeze, },
+		.enter = &intel_idle, },
 	{
 		.name = "C7-CHT",
 		.desc = "MWAIT 0x60",
 		.flags = MWAIT2flg(0x60) | CPUIDLE_FLAG_TLB_FLUSHED,
 		.exit_latency = 1200,
 		.target_residency = 4000,
-		.enter = &intel_idle,
-		.enter_freeze = intel_idle_freeze, },
+		.enter = &intel_idle, },
 	{
 		.name = "C7S-CHT",
 		.desc = "MWAIT 0x64",
 		.flags = MWAIT2flg(0x64) | CPUIDLE_FLAG_TLB_FLUSHED,
 		.exit_latency = 10000,
 		.target_residency = 20000,
-		.enter = &intel_idle,
-		.enter_freeze = intel_idle_freeze, },
+		.enter = &intel_idle, },
 	{
 		.enter = NULL }
 };
@@ -305,40 +284,35 @@ static struct cpuidle_state ivb_cstates[
 		.flags = MWAIT2flg(0x00),
 		.exit_latency = 1,
 		.target_residency = 1,
-		.enter = &intel_idle,
-		.enter_freeze = intel_idle_freeze, },
+		.enter = &intel_idle, },
 	{
 		.name = "C1E-IVB",
 		.desc = "MWAIT 0x01",
 		.flags = MWAIT2flg(0x01),
 		.exit_latency = 10,
 		.target_residency = 20,
-		.enter = &intel_idle,
-		.enter_freeze = intel_idle_freeze, },
+		.enter = &intel_idle, },
 	{
 		.name = "C3-IVB",
 		.desc = "MWAIT 0x10",
 		.flags = MWAIT2flg(0x10) | CPUIDLE_FLAG_TLB_FLUSHED,
 		.exit_latency = 59,
 		.target_residency = 156,
-		.enter = &intel_idle,
-		.enter_freeze = intel_idle_freeze, },
+		.enter = &intel_idle, },
 	{
 		.name = "C6-IVB",
 		.desc = "MWAIT 0x20",
 		.flags = MWAIT2flg(0x20) | CPUIDLE_FLAG_TLB_FLUSHED,
 		.exit_latency = 80,
 		.target_residency = 300,
-		.enter = &intel_idle,
-		.enter_freeze = intel_idle_freeze, },
+		.enter = &intel_idle, },
 	{
 		.name = "C7-IVB",
 		.desc = "MWAIT 0x30",
 		.flags = MWAIT2flg(0x30) | CPUIDLE_FLAG_TLB_FLUSHED,
 		.exit_latency = 87,
 		.target_residency = 300,
-		.enter = &intel_idle,
-		.enter_freeze = intel_idle_freeze, },
+		.enter = &intel_idle, },
 	{
 		.enter = NULL }
 };
@@ -350,32 +324,28 @@ static struct cpuidle_state ivt_cstates[
 		.flags = MWAIT2flg(0x00),
 		.exit_latency = 1,
 		.target_residency = 1,
-		.enter = &intel_idle,
-		.enter_freeze = intel_idle_freeze, },
+		.enter = &intel_idle, },
 	{
 		.name = "C1E-IVT",
 		.desc = "MWAIT 0x01",
 		.flags = MWAIT2flg(0x01),
 		.exit_latency = 10,
 		.target_residency = 80,
-		.enter = &intel_idle,
-		.enter_freeze = intel_idle_freeze, },
+		.enter = &intel_idle, },
 	{
 		.name = "C3-IVT",
 		.desc = "MWAIT 0x10",
 		.flags = MWAIT2flg(0x10) | CPUIDLE_FLAG_TLB_FLUSHED,
 		.exit_latency = 59,
 		.target_residency = 156,
-		.enter = &intel_idle,
-		.enter_freeze = intel_idle_freeze, },
+		.enter = &intel_idle, },
 	{
 		.name = "C6-IVT",
 		.desc = "MWAIT 0x20",
 		.flags = MWAIT2flg(0x20) | CPUIDLE_FLAG_TLB_FLUSHED,
 		.exit_latency = 82,
 		.target_residency = 300,
-		.enter = &intel_idle,
-		.enter_freeze = intel_idle_freeze, },
+		.enter = &intel_idle, },
 	{
 		.enter = NULL }
 };
@@ -387,32 +357,28 @@ static struct cpuidle_state ivt_cstates_
 		.flags = MWAIT2flg(0x00),
 		.exit_latency = 1,
 		.target_residency = 1,
-		.enter = &intel_idle,
-		.enter_freeze = intel_idle_freeze, },
+		.enter = &intel_idle, },
 	{
 		.name = "C1E-IVT-4S",
 		.desc = "MWAIT 0x01",
 		.flags = MWAIT2flg(0x01),
 		.exit_latency = 10,
 		.target_residency = 250,
-		.enter = &intel_idle,
-		.enter_freeze = intel_idle_freeze, },
+		.enter = &intel_idle, },
 	{
 		.name = "C3-IVT-4S",
 		.desc = "MWAIT 0x10",
 		.flags = MWAIT2flg(0x10) | CPUIDLE_FLAG_TLB_FLUSHED,
 		.exit_latency = 59,
 		.target_residency = 300,
-		.enter = &intel_idle,
-		.enter_freeze = intel_idle_freeze, },
+		.enter = &intel_idle, },
 	{
 		.name = "C6-IVT-4S",
 		.desc = "MWAIT 0x20",
 		.flags = MWAIT2flg(0x20) | CPUIDLE_FLAG_TLB_FLUSHED,
 		.exit_latency = 84,
 		.target_residency = 400,
-		.enter = &intel_idle,
-		.enter_freeze = intel_idle_freeze, },
+		.enter = &intel_idle, },
 	{
 		.enter = NULL }
 };
@@ -424,32 +390,28 @@ static struct cpuidle_state ivt_cstates_
 		.flags = MWAIT2flg(0x00),
 		.exit_latency = 1,
 		.target_residency = 1,
-		.enter = &intel_idle,
-		.enter_freeze = intel_idle_freeze, },
+		.enter = &intel_idle, },
 	{
 		.name = "C1E-IVT-8S",
 		.desc = "MWAIT 0x01",
 		.flags = MWAIT2flg(0x01),
 		.exit_latency = 10,
 		.target_residency = 500,
-		.enter = &intel_idle,
-		.enter_freeze = intel_idle_freeze, },
+		.enter = &intel_idle, },
 	{
 		.name = "C3-IVT-8S",
 		.desc = "MWAIT 0x10",
 		.flags = MWAIT2flg(0x10) | CPUIDLE_FLAG_TLB_FLUSHED,
 		.exit_latency = 59,
 		.target_residency = 600,
-		.enter = &intel_idle,
-		.enter_freeze = intel_idle_freeze, },
+		.enter = &intel_idle, },
 	{
 		.name = "C6-IVT-8S",
 		.desc = "MWAIT 0x20",
 		.flags = MWAIT2flg(0x20) | CPUIDLE_FLAG_TLB_FLUSHED,
 		.exit_latency = 88,
 		.target_residency = 700,
-		.enter = &intel_idle,
-		.enter_freeze = intel_idle_freeze, },
+		.enter = &intel_idle, },
 	{
 		.enter = NULL }
 };
@@ -461,64 +423,56 @@ static struct cpuidle_state hsw_cstates[
 		.flags = MWAIT2flg(0x00),
 		.exit_latency = 2,
 		.target_residency = 2,
-		.enter = &intel_idle,
-		.enter_freeze = intel_idle_freeze, },
+		.enter = &intel_idle, },
 	{
 		.name = "C1E-HSW",
 		.desc = "MWAIT 0x01",
 		.flags = MWAIT2flg(0x01),
 		.exit_latency = 10,
 		.target_residency = 20,
-		.enter = &intel_idle,
-		.enter_freeze = intel_idle_freeze, },
+		.enter = &intel_idle, },
 	{
 		.name = "C3-HSW",
 		.desc = "MWAIT 0x10",
 		.flags = MWAIT2flg(0x10) | CPUIDLE_FLAG_TLB_FLUSHED,
 		.exit_latency = 33,
 		.target_residency = 100,
-		.enter = &intel_idle,
-		.enter_freeze = intel_idle_freeze, },
+		.enter = &intel_idle, },
 	{
 		.name = "C6-HSW",
 		.desc = "MWAIT 0x20",
 		.flags = MWAIT2flg(0x20) | CPUIDLE_FLAG_TLB_FLUSHED,
 		.exit_latency = 133,
 		.target_residency = 400,
-		.enter = &intel_idle,
-		.enter_freeze = intel_idle_freeze, },
+		.enter = &intel_idle, },
 	{
 		.name = "C7s-HSW",
 		.desc = "MWAIT 0x32",
 		.flags = MWAIT2flg(0x32) | CPUIDLE_FLAG_TLB_FLUSHED,
 		.exit_latency = 166,
 		.target_residency = 500,
-		.enter = &intel_idle,
-		.enter_freeze = intel_idle_freeze, },
+		.enter = &intel_idle, },
 	{
 		.name = "C8-HSW",
 		.desc = "MWAIT 0x40",
 		.flags = MWAIT2flg(0x40) | CPUIDLE_FLAG_TLB_FLUSHED,
 		.exit_latency = 300,
 		.target_residency = 900,
-		.enter = &intel_idle,
-		.enter_freeze = intel_idle_freeze, },
+		.enter = &intel_idle, },
 	{
 		.name = "C9-HSW",
 		.desc = "MWAIT 0x50",
 		.flags = MWAIT2flg(0x50) | CPUIDLE_FLAG_TLB_FLUSHED,
 		.exit_latency = 600,
 		.target_residency = 1800,
-		.enter = &intel_idle,
-		.enter_freeze = intel_idle_freeze, },
+		.enter = &intel_idle, },
 	{
 		.name = "C10-HSW",
 		.desc = "MWAIT 0x60",
 		.flags = MWAIT2flg(0x60) | CPUIDLE_FLAG_TLB_FLUSHED,
 		.exit_latency = 2600,
 		.target_residency = 7700,
-		.enter = &intel_idle,
-		.enter_freeze = intel_idle_freeze, },
+		.enter = &intel_idle, },
 	{
 		.enter = NULL }
 };
@@ -529,64 +483,56 @@ static struct cpuidle_state bdw_cstates[
 		.flags = MWAIT2flg(0x00),
 		.exit_latency = 2,
 		.target_residency = 2,
-		.enter = &intel_idle,
-		.enter_freeze = intel_idle_freeze, },
+		.enter = &intel_idle, },
 	{
 		.name = "C1E-BDW",
 		.desc = "MWAIT 0x01",
 		.flags = MWAIT2flg(0x01),
 		.exit_latency = 10,
 		.target_residency = 20,
-		.enter = &intel_idle,
-		.enter_freeze = intel_idle_freeze, },
+		.enter = &intel_idle, },
 	{
 		.name = "C3-BDW",
 		.desc = "MWAIT 0x10",
 		.flags = MWAIT2flg(0x10) | CPUIDLE_FLAG_TLB_FLUSHED,
 		.exit_latency = 40,
 		.target_residency = 100,
-		.enter = &intel_idle,
-		.enter_freeze = intel_idle_freeze, },
+		.enter = &intel_idle, },
 	{
 		.name = "C6-BDW",
 		.desc = "MWAIT 0x20",
 		.flags = MWAIT2flg(0x20) | CPUIDLE_FLAG_TLB_FLUSHED,
 		.exit_latency = 133,
 		.target_residency = 400,
-		.enter = &intel_idle,
-		.enter_freeze = intel_idle_freeze, },
+		.enter = &intel_idle, },
 	{
 		.name = "C7s-BDW",
 		.desc = "MWAIT 0x32",
 		.flags = MWAIT2flg(0x32) | CPUIDLE_FLAG_TLB_FLUSHED,
 		.exit_latency = 166,
 		.target_residency = 500,
-		.enter = &intel_idle,
-		.enter_freeze = intel_idle_freeze, },
+		.enter = &intel_idle, },
 	{
 		.name = "C8-BDW",
 		.desc = "MWAIT 0x40",
 		.flags = MWAIT2flg(0x40) | CPUIDLE_FLAG_TLB_FLUSHED,
 		.exit_latency = 300,
 		.target_residency = 900,
-		.enter = &intel_idle,
-		.enter_freeze = intel_idle_freeze, },
+		.enter = &intel_idle, },
 	{
 		.name = "C9-BDW",
 		.desc = "MWAIT 0x50",
 		.flags = MWAIT2flg(0x50) | CPUIDLE_FLAG_TLB_FLUSHED,
 		.exit_latency = 600,
 		.target_residency = 1800,
-		.enter = &intel_idle,
-		.enter_freeze = intel_idle_freeze, },
+		.enter = &intel_idle, },
 	{
 		.name = "C10-BDW",
 		.desc = "MWAIT 0x60",
 		.flags = MWAIT2flg(0x60) | CPUIDLE_FLAG_TLB_FLUSHED,
 		.exit_latency = 2600,
 		.target_residency = 7700,
-		.enter = &intel_idle,
-		.enter_freeze = intel_idle_freeze, },
+		.enter = &intel_idle, },
 	{
 		.enter = NULL }
 };
@@ -598,32 +544,28 @@ static struct cpuidle_state atom_cstates
 		.flags = MWAIT2flg(0x00),
 		.exit_latency = 10,
 		.target_residency = 20,
-		.enter = &intel_idle,
-		.enter_freeze = intel_idle_freeze, },
+		.enter = &intel_idle, },
 	{
 		.name = "C2-ATM",
 		.desc = "MWAIT 0x10",
 		.flags = MWAIT2flg(0x10),
 		.exit_latency = 20,
 		.target_residency = 80,
-		.enter = &intel_idle,
-		.enter_freeze = intel_idle_freeze, },
+		.enter = &intel_idle, },
 	{
 		.name = "C4-ATM",
 		.desc = "MWAIT 0x30",
 		.flags = MWAIT2flg(0x30) | CPUIDLE_FLAG_TLB_FLUSHED,
 		.exit_latency = 100,
 		.target_residency = 400,
-		.enter = &intel_idle,
-		.enter_freeze = intel_idle_freeze, },
+		.enter = &intel_idle, },
 	{
 		.name = "C6-ATM",
 		.desc = "MWAIT 0x52",
 		.flags = MWAIT2flg(0x52) | CPUIDLE_FLAG_TLB_FLUSHED,
 		.exit_latency = 140,
 		.target_residency = 560,
-		.enter = &intel_idle,
-		.enter_freeze = intel_idle_freeze, },
+		.enter = &intel_idle, },
 	{
 		.enter = NULL }
 };
@@ -634,16 +576,14 @@ static struct cpuidle_state avn_cstates[
 		.flags = MWAIT2flg(0x00),
 		.exit_latency = 2,
 		.target_residency = 2,
-		.enter = &intel_idle,
-		.enter_freeze = intel_idle_freeze, },
+		.enter = &intel_idle, },
 	{
 		.name = "C6-AVN",
 		.desc = "MWAIT 0x51",
 		.flags = MWAIT2flg(0x51) | CPUIDLE_FLAG_TLB_FLUSHED,
 		.exit_latency = 15,
 		.target_residency = 45,
-		.enter = &intel_idle,
-		.enter_freeze = intel_idle_freeze, },
+		.enter = &intel_idle, },
 	{
 		.enter = NULL }
 };
@@ -685,6 +625,7 @@ static int intel_idle(struct cpuidle_dev
 	return index;
 }
 
+#ifdef CONFIG_SUSPEND
 /**
  * intel_idle_freeze - simplified "enter" callback routine for suspend-to-idle
  * @dev: cpuidle_device
@@ -700,6 +641,14 @@ static void intel_idle_freeze(struct cpu
 	mwait_idle_with_hints(eax, ecx);
 }
 
+static inline void set_enter_freeze(struct cpuidle_state *state)
+{
+	state->enter_freeze = intel_idle_freeze;
+}
+#else
+static inline void set_enter_freeze(struct cpuidle_state *state) {}
+#endif
+
 static void __setup_broadcast_timer(void *arg)
 {
 	unsigned long on = (unsigned long)arg;
@@ -992,6 +941,7 @@ static int __init intel_idle_cpuidle_dri
 
 		drv->states[drv->state_count] =	/* structure copy */
 			cpuidle_state_table[cstate];
+		set_enter_freeze(&drv->states[drv->state_count]);
 
 		drv->state_count += 1;
 	}
Index: linux-pm/drivers/cpuidle/cpuidle.c
===================================================================
--- linux-pm.orig/drivers/cpuidle/cpuidle.c
+++ linux-pm/drivers/cpuidle/cpuidle.c
@@ -88,7 +88,7 @@ static int find_deepest_state(struct cpu
 		if (s->disabled || su->disable || s->exit_latency <= latency_req
 		    || s->exit_latency > max_latency
 		    || (s->flags & forbidden_flags)
-		    || (freeze && !s->enter_freeze))
+		    || (freeze && !cpuidle_has_enter_freeze(s)))
 			continue;
 
 		latency_req = s->exit_latency;
