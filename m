From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH 2/5] ACPI / cpuidle: Clean up fallback to C1 checks
Date: Thu, 29 Jan 2015 19:27:50 +0100
Message-ID: <3686267.GOVk0HSzaS@vostro.rjw.lan>
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

acpi_idle_enter_simple() and acpi_idle_enter_bm() both check
if C2/C3 type entry is supported on MP in the same way, so move
those checks to a separate function and call it from both
places (and it doesn't need to check if the state type is not
C1, because the functions in question won't be called otherwise).

While at it, use IS_ENABLED() for the CONFIG_HOTPLUG_CPU check.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/processor_idle.c |   19 +++++++++----------
 1 file changed, 9 insertions(+), 10 deletions(-)

Index: linux-pm/drivers/acpi/processor_idle.c
===================================================================
--- linux-pm.orig/drivers/acpi/processor_idle.c
+++ linux-pm/drivers/acpi/processor_idle.c
@@ -758,6 +758,13 @@ static int acpi_idle_play_dead(struct cp
 	return 0;
 }
 
+static bool acpi_idle_fallback_to_c1(struct acpi_processor *pr)
+{
+	return IS_ENABLED(CONFIG_HOTPLUG_CPU) && num_online_cpus() > 1 &&
+		!(acpi_gbl_FADT.flags & ACPI_FADT_C2_MP_SUPPORTED) &&
+		!pr->flags.has_cst;
+}
+
 /**
  * acpi_idle_enter_simple - enters an ACPI state without BM handling
  * @dev: the target CPU
@@ -775,12 +782,8 @@ static int acpi_idle_enter_simple(struct
 	if (unlikely(!pr))
 		return -EINVAL;
 
-#ifdef CONFIG_HOTPLUG_CPU
-	if ((cx->type != ACPI_STATE_C1) && (num_online_cpus() > 1) &&
-	    !pr->flags.has_cst &&
-	    !(acpi_gbl_FADT.flags & ACPI_FADT_C2_MP_SUPPORTED))
+	if (acpi_idle_fallback_to_c1(pr))
 		return acpi_idle_enter_c1(dev, drv, CPUIDLE_DRIVER_STATE_START);
-#endif
 
 	/*
 	 * Must be done before busmaster disable as we might need to
@@ -819,12 +822,8 @@ static int acpi_idle_enter_bm(struct cpu
 	if (unlikely(!pr))
 		return -EINVAL;
 
-#ifdef CONFIG_HOTPLUG_CPU
-	if ((cx->type != ACPI_STATE_C1) && (num_online_cpus() > 1) &&
-	    !pr->flags.has_cst &&
-	    !(acpi_gbl_FADT.flags & ACPI_FADT_C2_MP_SUPPORTED))
+	if (acpi_idle_fallback_to_c1(pr))
 		return acpi_idle_enter_c1(dev, drv, CPUIDLE_DRIVER_STATE_START);
-#endif
 
 	if (!cx->bm_sts_skip && acpi_idle_bm_check()) {
 		if (drv->safe_state_index >= 0) {
