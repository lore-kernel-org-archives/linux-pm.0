From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH 5/6] intel_idle: Add ->enter_freeze callbacks
Date: Wed, 11 Feb 2015 05:04:17 +0100
Message-ID: <2407992.WHaFxrNaoa@vostro.rjw.lan>
References: <8292243.ibkmfVtXac@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <8292243.ibkmfVtXac@vostro.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Peter Zijlstra <peterz@infradead.org>, Alan Cox <alan@linux.intel.com>, "Li, Aubrey" <aubrey.li@linux.intel.com>, LKML <linux-kernel@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Kristen Carlson Accardi <kristen@linux.intel.com>, John Stultz <john.stultz@linaro.org>, Len Brown <len.brown@intel.com>
List-Id: linux-pm@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Add an ->enter_freeze callback routine, intel_idle_freeze(), to
the intel_idle driver and point the ->enter_freeze callback
pointers of all of the driver's state objects to it.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/idle/intel_idle.c |  179 ++++++++++++++++++++++++++++++++--------------
 1 file changed, 125 insertions(+), 54 deletions(-)

Index: linux-pm/drivers/idle/intel_idle.c
===================================================================
--- linux-pm.orig/drivers/idle/intel_idle.c
+++ linux-pm/drivers/idle/intel_idle.c
@@ -97,6 +97,8 @@ static const struct idle_cpu *icpu;
 static struct cpuidle_device __percpu *intel_idle_cpuidle_devices;
 static int intel_idle(struct cpuidle_device *dev,
 			struct cpuidle_driver *drv, int index);
+static void intel_idle_freeze(struct cpuidle_device *dev,
+			      struct cpuidle_driver *drv, int index);
 static int intel_idle_cpu_init(int cpu);
 
 static struct cpuidle_state *cpuidle_state_table;
@@ -131,28 +133,32 @@ static struct cpuidle_state nehalem_csta
 		.flags = MWAIT2flg(0x00),
 		.exit_latency = 3,
 		.target_residency = 6,
-		.enter = &intel_idle },
+		.enter = &intel_idle,
+		.enter_freeze = intel_idle_freeze, },
 	{
 		.name = "C1E-NHM",
 		.desc = "MWAIT 0x01",
 		.flags = MWAIT2flg(0x01),
 		.exit_latency = 10,
 		.target_residency = 20,
-		.enter = &intel_idle },
+		.enter = &intel_idle,
+		.enter_freeze = intel_idle_freeze, },
 	{
 		.name = "C3-NHM",
 		.desc = "MWAIT 0x10",
 		.flags = MWAIT2flg(0x10) | CPUIDLE_FLAG_TLB_FLUSHED,
 		.exit_latency = 20,
 		.target_residency = 80,
-		.enter = &intel_idle },
+		.enter = &intel_idle,
+		.enter_freeze = intel_idle_freeze, },
 	{
 		.name = "C6-NHM",
 		.desc = "MWAIT 0x20",
 		.flags = MWAIT2flg(0x20) | CPUIDLE_FLAG_TLB_FLUSHED,
 		.exit_latency = 200,
 		.target_residency = 800,
-		.enter = &intel_idle },
+		.enter = &intel_idle,
+		.enter_freeze = intel_idle_freeze, },
 	{
 		.enter = NULL }
 };
@@ -164,35 +170,40 @@ static struct cpuidle_state snb_cstates[
 		.flags = MWAIT2flg(0x00),
 		.exit_latency = 2,
 		.target_residency = 2,
-		.enter = &intel_idle },
+		.enter = &intel_idle,
+		.enter_freeze = intel_idle_freeze, },
 	{
 		.name = "C1E-SNB",
 		.desc = "MWAIT 0x01",
 		.flags = MWAIT2flg(0x01),
 		.exit_latency = 10,
 		.target_residency = 20,
-		.enter = &intel_idle },
+		.enter = &intel_idle,
+		.enter_freeze = intel_idle_freeze, },
 	{
 		.name = "C3-SNB",
 		.desc = "MWAIT 0x10",
 		.flags = MWAIT2flg(0x10) | CPUIDLE_FLAG_TLB_FLUSHED,
 		.exit_latency = 80,
 		.target_residency = 211,
-		.enter = &intel_idle },
+		.enter = &intel_idle,
+		.enter_freeze = intel_idle_freeze, },
 	{
 		.name = "C6-SNB",
 		.desc = "MWAIT 0x20",
 		.flags = MWAIT2flg(0x20) | CPUIDLE_FLAG_TLB_FLUSHED,
 		.exit_latency = 104,
 		.target_residency = 345,
-		.enter = &intel_idle },
+		.enter = &intel_idle,
+		.enter_freeze = intel_idle_freeze, },
 	{
 		.name = "C7-SNB",
 		.desc = "MWAIT 0x30",
 		.flags = MWAIT2flg(0x30) | CPUIDLE_FLAG_TLB_FLUSHED,
 		.exit_latency = 109,
 		.target_residency = 345,
-		.enter = &intel_idle },
+		.enter = &intel_idle,
+		.enter_freeze = intel_idle_freeze, },
 	{
 		.enter = NULL }
 };
@@ -204,42 +215,48 @@ static struct cpuidle_state byt_cstates[
 		.flags = MWAIT2flg(0x00),
 		.exit_latency = 1,
 		.target_residency = 1,
-		.enter = &intel_idle },
+		.enter = &intel_idle,
+		.enter_freeze = intel_idle_freeze, },
 	{
 		.name = "C1E-BYT",
 		.desc = "MWAIT 0x01",
 		.flags = MWAIT2flg(0x01),
 		.exit_latency = 15,
 		.target_residency = 30,
-		.enter = &intel_idle },
+		.enter = &intel_idle,
+		.enter_freeze = intel_idle_freeze, },
 	{
 		.name = "C6N-BYT",
 		.desc = "MWAIT 0x58",
 		.flags = MWAIT2flg(0x58) | CPUIDLE_FLAG_TLB_FLUSHED,
 		.exit_latency = 40,
 		.target_residency = 275,
-		.enter = &intel_idle },
+		.enter = &intel_idle,
+		.enter_freeze = intel_idle_freeze, },
 	{
 		.name = "C6S-BYT",
 		.desc = "MWAIT 0x52",
 		.flags = MWAIT2flg(0x52) | CPUIDLE_FLAG_TLB_FLUSHED,
 		.exit_latency = 140,
 		.target_residency = 560,
-		.enter = &intel_idle },
+		.enter = &intel_idle,
+		.enter_freeze = intel_idle_freeze, },
 	{
 		.name = "C7-BYT",
 		.desc = "MWAIT 0x60",
 		.flags = MWAIT2flg(0x60) | CPUIDLE_FLAG_TLB_FLUSHED,
 		.exit_latency = 1200,
 		.target_residency = 1500,
-		.enter = &intel_idle },
+		.enter = &intel_idle,
+		.enter_freeze = intel_idle_freeze, },
 	{
 		.name = "C7S-BYT",
 		.desc = "MWAIT 0x64",
 		.flags = MWAIT2flg(0x64) | CPUIDLE_FLAG_TLB_FLUSHED,
 		.exit_latency = 10000,
 		.target_residency = 20000,
-		.enter = &intel_idle },
+		.enter = &intel_idle,
+		.enter_freeze = intel_idle_freeze, },
 	{
 		.enter = NULL }
 };
@@ -251,35 +268,40 @@ static struct cpuidle_state ivb_cstates[
 		.flags = MWAIT2flg(0x00),
 		.exit_latency = 1,
 		.target_residency = 1,
-		.enter = &intel_idle },
+		.enter = &intel_idle,
+		.enter_freeze = intel_idle_freeze, },
 	{
 		.name = "C1E-IVB",
 		.desc = "MWAIT 0x01",
 		.flags = MWAIT2flg(0x01),
 		.exit_latency = 10,
 		.target_residency = 20,
-		.enter = &intel_idle },
+		.enter = &intel_idle,
+		.enter_freeze = intel_idle_freeze, },
 	{
 		.name = "C3-IVB",
 		.desc = "MWAIT 0x10",
 		.flags = MWAIT2flg(0x10) | CPUIDLE_FLAG_TLB_FLUSHED,
 		.exit_latency = 59,
 		.target_residency = 156,
-		.enter = &intel_idle },
+		.enter = &intel_idle,
+		.enter_freeze = intel_idle_freeze, },
 	{
 		.name = "C6-IVB",
 		.desc = "MWAIT 0x20",
 		.flags = MWAIT2flg(0x20) | CPUIDLE_FLAG_TLB_FLUSHED,
 		.exit_latency = 80,
 		.target_residency = 300,
-		.enter = &intel_idle },
+		.enter = &intel_idle,
+		.enter_freeze = intel_idle_freeze, },
 	{
 		.name = "C7-IVB",
 		.desc = "MWAIT 0x30",
 		.flags = MWAIT2flg(0x30) | CPUIDLE_FLAG_TLB_FLUSHED,
 		.exit_latency = 87,
 		.target_residency = 300,
-		.enter = &intel_idle },
+		.enter = &intel_idle,
+		.enter_freeze = intel_idle_freeze, },
 	{
 		.enter = NULL }
 };
@@ -291,28 +313,32 @@ static struct cpuidle_state ivt_cstates[
 		.flags = MWAIT2flg(0x00),
 		.exit_latency = 1,
 		.target_residency = 1,
-		.enter = &intel_idle },
+		.enter = &intel_idle,
+		.enter_freeze = intel_idle_freeze, },
 	{
 		.name = "C1E-IVT",
 		.desc = "MWAIT 0x01",
 		.flags = MWAIT2flg(0x01),
 		.exit_latency = 10,
 		.target_residency = 80,
-		.enter = &intel_idle },
+		.enter = &intel_idle,
+		.enter_freeze = intel_idle_freeze, },
 	{
 		.name = "C3-IVT",
 		.desc = "MWAIT 0x10",
 		.flags = MWAIT2flg(0x10) | CPUIDLE_FLAG_TLB_FLUSHED,
 		.exit_latency = 59,
 		.target_residency = 156,
-		.enter = &intel_idle },
+		.enter = &intel_idle,
+		.enter_freeze = intel_idle_freeze, },
 	{
 		.name = "C6-IVT",
 		.desc = "MWAIT 0x20",
 		.flags = MWAIT2flg(0x20) | CPUIDLE_FLAG_TLB_FLUSHED,
 		.exit_latency = 82,
 		.target_residency = 300,
-		.enter = &intel_idle },
+		.enter = &intel_idle,
+		.enter_freeze = intel_idle_freeze, },
 	{
 		.enter = NULL }
 };
@@ -324,28 +350,32 @@ static struct cpuidle_state ivt_cstates_
 		.flags = MWAIT2flg(0x00),
 		.exit_latency = 1,
 		.target_residency = 1,
-		.enter = &intel_idle },
+		.enter = &intel_idle,
+		.enter_freeze = intel_idle_freeze, },
 	{
 		.name = "C1E-IVT-4S",
 		.desc = "MWAIT 0x01",
 		.flags = MWAIT2flg(0x01),
 		.exit_latency = 10,
 		.target_residency = 250,
-		.enter = &intel_idle },
+		.enter = &intel_idle,
+		.enter_freeze = intel_idle_freeze, },
 	{
 		.name = "C3-IVT-4S",
 		.desc = "MWAIT 0x10",
 		.flags = MWAIT2flg(0x10) | CPUIDLE_FLAG_TLB_FLUSHED,
 		.exit_latency = 59,
 		.target_residency = 300,
-		.enter = &intel_idle },
+		.enter = &intel_idle,
+		.enter_freeze = intel_idle_freeze, },
 	{
 		.name = "C6-IVT-4S",
 		.desc = "MWAIT 0x20",
 		.flags = MWAIT2flg(0x20) | CPUIDLE_FLAG_TLB_FLUSHED,
 		.exit_latency = 84,
 		.target_residency = 400,
-		.enter = &intel_idle },
+		.enter = &intel_idle,
+		.enter_freeze = intel_idle_freeze, },
 	{
 		.enter = NULL }
 };
@@ -357,28 +387,32 @@ static struct cpuidle_state ivt_cstates_
 		.flags = MWAIT2flg(0x00),
 		.exit_latency = 1,
 		.target_residency = 1,
-		.enter = &intel_idle },
+		.enter = &intel_idle,
+		.enter_freeze = intel_idle_freeze, },
 	{
 		.name = "C1E-IVT-8S",
 		.desc = "MWAIT 0x01",
 		.flags = MWAIT2flg(0x01),
 		.exit_latency = 10,
 		.target_residency = 500,
-		.enter = &intel_idle },
+		.enter = &intel_idle,
+		.enter_freeze = intel_idle_freeze, },
 	{
 		.name = "C3-IVT-8S",
 		.desc = "MWAIT 0x10",
 		.flags = MWAIT2flg(0x10) | CPUIDLE_FLAG_TLB_FLUSHED,
 		.exit_latency = 59,
 		.target_residency = 600,
-		.enter = &intel_idle },
+		.enter = &intel_idle,
+		.enter_freeze = intel_idle_freeze, },
 	{
 		.name = "C6-IVT-8S",
 		.desc = "MWAIT 0x20",
 		.flags = MWAIT2flg(0x20) | CPUIDLE_FLAG_TLB_FLUSHED,
 		.exit_latency = 88,
 		.target_residency = 700,
-		.enter = &intel_idle },
+		.enter = &intel_idle,
+		.enter_freeze = intel_idle_freeze, },
 	{
 		.enter = NULL }
 };
@@ -390,56 +424,64 @@ static struct cpuidle_state hsw_cstates[
 		.flags = MWAIT2flg(0x00),
 		.exit_latency = 2,
 		.target_residency = 2,
-		.enter = &intel_idle },
+		.enter = &intel_idle,
+		.enter_freeze = intel_idle_freeze, },
 	{
 		.name = "C1E-HSW",
 		.desc = "MWAIT 0x01",
 		.flags = MWAIT2flg(0x01),
 		.exit_latency = 10,
 		.target_residency = 20,
-		.enter = &intel_idle },
+		.enter = &intel_idle,
+		.enter_freeze = intel_idle_freeze, },
 	{
 		.name = "C3-HSW",
 		.desc = "MWAIT 0x10",
 		.flags = MWAIT2flg(0x10) | CPUIDLE_FLAG_TLB_FLUSHED,
 		.exit_latency = 33,
 		.target_residency = 100,
-		.enter = &intel_idle },
+		.enter = &intel_idle,
+		.enter_freeze = intel_idle_freeze, },
 	{
 		.name = "C6-HSW",
 		.desc = "MWAIT 0x20",
 		.flags = MWAIT2flg(0x20) | CPUIDLE_FLAG_TLB_FLUSHED,
 		.exit_latency = 133,
 		.target_residency = 400,
-		.enter = &intel_idle },
+		.enter = &intel_idle,
+		.enter_freeze = intel_idle_freeze, },
 	{
 		.name = "C7s-HSW",
 		.desc = "MWAIT 0x32",
 		.flags = MWAIT2flg(0x32) | CPUIDLE_FLAG_TLB_FLUSHED,
 		.exit_latency = 166,
 		.target_residency = 500,
-		.enter = &intel_idle },
+		.enter = &intel_idle,
+		.enter_freeze = intel_idle_freeze, },
 	{
 		.name = "C8-HSW",
 		.desc = "MWAIT 0x40",
 		.flags = MWAIT2flg(0x40) | CPUIDLE_FLAG_TLB_FLUSHED,
 		.exit_latency = 300,
 		.target_residency = 900,
-		.enter = &intel_idle },
+		.enter = &intel_idle,
+		.enter_freeze = intel_idle_freeze, },
 	{
 		.name = "C9-HSW",
 		.desc = "MWAIT 0x50",
 		.flags = MWAIT2flg(0x50) | CPUIDLE_FLAG_TLB_FLUSHED,
 		.exit_latency = 600,
 		.target_residency = 1800,
-		.enter = &intel_idle },
+		.enter = &intel_idle,
+		.enter_freeze = intel_idle_freeze, },
 	{
 		.name = "C10-HSW",
 		.desc = "MWAIT 0x60",
 		.flags = MWAIT2flg(0x60) | CPUIDLE_FLAG_TLB_FLUSHED,
 		.exit_latency = 2600,
 		.target_residency = 7700,
-		.enter = &intel_idle },
+		.enter = &intel_idle,
+		.enter_freeze = intel_idle_freeze, },
 	{
 		.enter = NULL }
 };
@@ -450,56 +492,64 @@ static struct cpuidle_state bdw_cstates[
 		.flags = MWAIT2flg(0x00),
 		.exit_latency = 2,
 		.target_residency = 2,
-		.enter = &intel_idle },
+		.enter = &intel_idle,
+		.enter_freeze = intel_idle_freeze, },
 	{
 		.name = "C1E-BDW",
 		.desc = "MWAIT 0x01",
 		.flags = MWAIT2flg(0x01),
 		.exit_latency = 10,
 		.target_residency = 20,
-		.enter = &intel_idle },
+		.enter = &intel_idle,
+		.enter_freeze = intel_idle_freeze, },
 	{
 		.name = "C3-BDW",
 		.desc = "MWAIT 0x10",
 		.flags = MWAIT2flg(0x10) | CPUIDLE_FLAG_TLB_FLUSHED,
 		.exit_latency = 40,
 		.target_residency = 100,
-		.enter = &intel_idle },
+		.enter = &intel_idle,
+		.enter_freeze = intel_idle_freeze, },
 	{
 		.name = "C6-BDW",
 		.desc = "MWAIT 0x20",
 		.flags = MWAIT2flg(0x20) | CPUIDLE_FLAG_TLB_FLUSHED,
 		.exit_latency = 133,
 		.target_residency = 400,
-		.enter = &intel_idle },
+		.enter = &intel_idle,
+		.enter_freeze = intel_idle_freeze, },
 	{
 		.name = "C7s-BDW",
 		.desc = "MWAIT 0x32",
 		.flags = MWAIT2flg(0x32) | CPUIDLE_FLAG_TLB_FLUSHED,
 		.exit_latency = 166,
 		.target_residency = 500,
-		.enter = &intel_idle },
+		.enter = &intel_idle,
+		.enter_freeze = intel_idle_freeze, },
 	{
 		.name = "C8-BDW",
 		.desc = "MWAIT 0x40",
 		.flags = MWAIT2flg(0x40) | CPUIDLE_FLAG_TLB_FLUSHED,
 		.exit_latency = 300,
 		.target_residency = 900,
-		.enter = &intel_idle },
+		.enter = &intel_idle,
+		.enter_freeze = intel_idle_freeze, },
 	{
 		.name = "C9-BDW",
 		.desc = "MWAIT 0x50",
 		.flags = MWAIT2flg(0x50) | CPUIDLE_FLAG_TLB_FLUSHED,
 		.exit_latency = 600,
 		.target_residency = 1800,
-		.enter = &intel_idle },
+		.enter = &intel_idle,
+		.enter_freeze = intel_idle_freeze, },
 	{
 		.name = "C10-BDW",
 		.desc = "MWAIT 0x60",
 		.flags = MWAIT2flg(0x60) | CPUIDLE_FLAG_TLB_FLUSHED,
 		.exit_latency = 2600,
 		.target_residency = 7700,
-		.enter = &intel_idle },
+		.enter = &intel_idle,
+		.enter_freeze = intel_idle_freeze, },
 	{
 		.enter = NULL }
 };
@@ -511,28 +561,32 @@ static struct cpuidle_state atom_cstates
 		.flags = MWAIT2flg(0x00),
 		.exit_latency = 10,
 		.target_residency = 20,
-		.enter = &intel_idle },
+		.enter = &intel_idle,
+		.enter_freeze = intel_idle_freeze, },
 	{
 		.name = "C2-ATM",
 		.desc = "MWAIT 0x10",
 		.flags = MWAIT2flg(0x10),
 		.exit_latency = 20,
 		.target_residency = 80,
-		.enter = &intel_idle },
+		.enter = &intel_idle,
+		.enter_freeze = intel_idle_freeze, },
 	{
 		.name = "C4-ATM",
 		.desc = "MWAIT 0x30",
 		.flags = MWAIT2flg(0x30) | CPUIDLE_FLAG_TLB_FLUSHED,
 		.exit_latency = 100,
 		.target_residency = 400,
-		.enter = &intel_idle },
+		.enter = &intel_idle,
+		.enter_freeze = intel_idle_freeze, },
 	{
 		.name = "C6-ATM",
 		.desc = "MWAIT 0x52",
 		.flags = MWAIT2flg(0x52) | CPUIDLE_FLAG_TLB_FLUSHED,
 		.exit_latency = 140,
 		.target_residency = 560,
-		.enter = &intel_idle },
+		.enter = &intel_idle,
+		.enter_freeze = intel_idle_freeze, },
 	{
 		.enter = NULL }
 };
@@ -543,14 +597,16 @@ static struct cpuidle_state avn_cstates[
 		.flags = MWAIT2flg(0x00),
 		.exit_latency = 2,
 		.target_residency = 2,
-		.enter = &intel_idle },
+		.enter = &intel_idle,
+		.enter_freeze = intel_idle_freeze, },
 	{
 		.name = "C6-AVN",
 		.desc = "MWAIT 0x51",
 		.flags = MWAIT2flg(0x51) | CPUIDLE_FLAG_TLB_FLUSHED,
 		.exit_latency = 15,
 		.target_residency = 45,
-		.enter = &intel_idle },
+		.enter = &intel_idle,
+		.enter_freeze = intel_idle_freeze, },
 	{
 		.enter = NULL }
 };
@@ -592,6 +648,21 @@ static int intel_idle(struct cpuidle_dev
 	return index;
 }
 
+/**
+ * intel_idle_freeze - simplified "enter" callback routine for suspend-to-idle
+ * @dev: cpuidle_device
+ * @drv: cpuidle driver
+ * @index: state index
+ */
+static void intel_idle_freeze(struct cpuidle_device *dev,
+			     struct cpuidle_driver *drv, int index)
+{
+	unsigned long ecx = 1; /* break on interrupt flag */
+	unsigned long eax = flg2MWAIT(drv->states[index].flags);
+
+	mwait_idle_with_hints(eax, ecx);
+}
+
 static void __setup_broadcast_timer(void *arg)
 {
 	unsigned long reason = (unsigned long)arg;

