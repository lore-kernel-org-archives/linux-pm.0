From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH 15/20] ARM: tegra: Use explicit broadcast oneshot control function
Date: Thu, 02 Apr 2015 00:21:28 +0200
Message-ID: <1478824.iDGgpniXH1@vostro.rjw.lan>
References: <2112147.0kYCHhbEJT@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <2112147.0kYCHhbEJT@vostro.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Stephen Warren <swarren@wwwdotorg.org>, Thierry Reding <thierry.reding@gmail.com>, Alexandre Courbot <gnurou@gmail.com>
List-Id: linux-pm@vger.kernel.org

From: Thomas Gleixner <tglx@linutronix.de>

Replace the clockevents_notify() call with an explicit function call.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Stephen Warren <swarren@wwwdotorg.org>
Cc: Thierry Reding <thierry.reding@gmail.com>
Cc: Alexandre Courbot <gnurou@gmail.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 arch/arm/mach-tegra/cpuidle-tegra114.c |    6 +++---
 arch/arm/mach-tegra/cpuidle-tegra20.c  |   10 +++++-----
 arch/arm/mach-tegra/cpuidle-tegra30.c  |   10 +++++-----
 3 files changed, 13 insertions(+), 13 deletions(-)

Index: linux-pm/arch/arm/mach-tegra/cpuidle-tegra114.c
===================================================================
--- linux-pm.orig/arch/arm/mach-tegra/cpuidle-tegra114.c
+++ linux-pm/arch/arm/mach-tegra/cpuidle-tegra114.c
@@ -15,7 +15,7 @@
  */
 
 #include <asm/firmware.h>
-#include <linux/clockchips.h>
+#include <linux/tick.h>
 #include <linux/cpuidle.h>
 #include <linux/cpu_pm.h>
 #include <linux/kernel.h>
@@ -44,7 +44,7 @@ static int tegra114_idle_power_down(stru
 	tegra_set_cpu_in_lp2();
 	cpu_pm_enter();
 
-	clockevents_notify(CLOCK_EVT_NOTIFY_BROADCAST_ENTER, &dev->cpu);
+	tick_broadcast_enter();
 
 	call_firmware_op(prepare_idle);
 
@@ -52,7 +52,7 @@ static int tegra114_idle_power_down(stru
 	if (call_firmware_op(do_idle, 0) == -ENOSYS)
 		cpu_suspend(0, tegra30_sleep_cpu_secondary_finish);
 
-	clockevents_notify(CLOCK_EVT_NOTIFY_BROADCAST_EXIT, &dev->cpu);
+	tick_broadcast_exit();
 
 	cpu_pm_exit();
 	tegra_clear_cpu_in_lp2();
Index: linux-pm/arch/arm/mach-tegra/cpuidle-tegra20.c
===================================================================
--- linux-pm.orig/arch/arm/mach-tegra/cpuidle-tegra20.c
+++ linux-pm/arch/arm/mach-tegra/cpuidle-tegra20.c
@@ -20,7 +20,7 @@
  */
 
 #include <linux/clk/tegra.h>
-#include <linux/clockchips.h>
+#include <linux/tick.h>
 #include <linux/cpuidle.h>
 #include <linux/cpu_pm.h>
 #include <linux/kernel.h>
@@ -135,11 +135,11 @@ static bool tegra20_cpu_cluster_power_do
 	if (tegra20_reset_cpu_1() || !tegra_cpu_rail_off_ready())
 		return false;
 
-	clockevents_notify(CLOCK_EVT_NOTIFY_BROADCAST_ENTER, &dev->cpu);
+	tick_broadcast_enter();
 
 	tegra_idle_lp2_last();
 
-	clockevents_notify(CLOCK_EVT_NOTIFY_BROADCAST_EXIT, &dev->cpu);
+	tick_broadcast_exit();
 
 	if (cpu_online(1))
 		tegra20_wake_cpu1_from_reset();
@@ -152,13 +152,13 @@ static bool tegra20_idle_enter_lp2_cpu_1
 					 struct cpuidle_driver *drv,
 					 int index)
 {
-	clockevents_notify(CLOCK_EVT_NOTIFY_BROADCAST_ENTER, &dev->cpu);
+	tick_broadcast_enter();
 
 	cpu_suspend(0, tegra20_sleep_cpu_secondary_finish);
 
 	tegra20_cpu_clear_resettable();
 
-	clockevents_notify(CLOCK_EVT_NOTIFY_BROADCAST_EXIT, &dev->cpu);
+	tick_broadcast_exit();
 
 	return true;
 }
Index: linux-pm/arch/arm/mach-tegra/cpuidle-tegra30.c
===================================================================
--- linux-pm.orig/arch/arm/mach-tegra/cpuidle-tegra30.c
+++ linux-pm/arch/arm/mach-tegra/cpuidle-tegra30.c
@@ -20,7 +20,7 @@
  */
 
 #include <linux/clk/tegra.h>
-#include <linux/clockchips.h>
+#include <linux/tick.h>
 #include <linux/cpuidle.h>
 #include <linux/cpu_pm.h>
 #include <linux/kernel.h>
@@ -75,11 +75,11 @@ static bool tegra30_cpu_cluster_power_do
 		return false;
 	}
 
-	clockevents_notify(CLOCK_EVT_NOTIFY_BROADCAST_ENTER, &dev->cpu);
+	tick_broadcast_enter();
 
 	tegra_idle_lp2_last();
 
-	clockevents_notify(CLOCK_EVT_NOTIFY_BROADCAST_EXIT, &dev->cpu);
+	tick_broadcast_exit();
 
 	return true;
 }
@@ -89,13 +89,13 @@ static bool tegra30_cpu_core_power_down(
 					struct cpuidle_driver *drv,
 					int index)
 {
-	clockevents_notify(CLOCK_EVT_NOTIFY_BROADCAST_ENTER, &dev->cpu);
+	tick_broadcast_enter();
 
 	smp_wmb();
 
 	cpu_suspend(0, tegra30_sleep_cpu_secondary_finish);
 
-	clockevents_notify(CLOCK_EVT_NOTIFY_BROADCAST_EXIT, &dev->cpu);
+	tick_broadcast_exit();
 
 	return true;
 }
