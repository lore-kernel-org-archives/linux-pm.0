From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH 07/20] ARM: OMAP: Use explicit broadcast control function
Date: Thu, 02 Apr 2015 00:10:32 +0200
Message-ID: <2612768.U6WULGdneK@vostro.rjw.lan>
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
@@ -14,7 +14,7 @@
 #include <linux/cpuidle.h>
 #include <linux/cpu_pm.h>
 #include <linux/export.h>
-#include <linux/clockchips.h>
+#include <linux/tick.h>
 
 #include <asm/cpuidle.h>
 
@@ -183,8 +183,7 @@ fail:
  */
 static void omap_setup_broadcast_timer(void *arg)
 {
-	int cpu = smp_processor_id();
-	clockevents_notify(CLOCK_EVT_NOTIFY_BROADCAST_ON, &cpu);
+	tick_broadcast_enable();
 }
 
 static struct cpuidle_driver omap4_idle_driver = {
