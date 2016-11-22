From: Thomas Gleixner <tglx@linutronix.de>
Subject: [patch V2 01/12] thermal/x86_pkg_temp: Cleanup thermal interrupt
 handling
Date: Tue, 22 Nov 2016 17:57:04 -0000
Message-ID: <20161122175356.944467397@linutronix.de>
References: <20161122175256.922158782@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline;
 filename=thermalx86_pkg_temp_Cleanup_thermal_interrupt_handling.patch
Sender: linux-kernel-owner@vger.kernel.org
To: LKML <linux-kernel@vger.kernel.org>
Cc: Rui Zhang <rui.zhang@intel.com>, edubezval@gmail.com, Peter Zijlstra <peterz@infradead.org>, Borislav Petkov <bp@alien8.de>, linux-pm@vger.kernel.org, x86@kernel.org, rt@linutronix.de, Srinivas Pandruvada <srinivas.pandruvada@intel.com>
List-Id: linux-pm@vger.kernel.org

Wenn a package is removed nothing restores the thermal interrupt MSR so
the content will be stale when a CPU of that package becomes online again.

Aside of that the work function reenables interrupts before acknowledging
the current one, which is the wrong order to begin with.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

---
 drivers/thermal/x86_pkg_temp_thermal.c |   11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

--- a/drivers/thermal/x86_pkg_temp_thermal.c
+++ b/drivers/thermal/x86_pkg_temp_thermal.c
@@ -334,7 +334,6 @@ static void pkg_temp_thermal_threshold_w
 	pkg_work_scheduled[phy_id] = 0;
 	spin_unlock_irqrestore(&pkg_work_lock, flags);
 
-	enable_pkg_thres_interrupt();
 	rdmsrl(MSR_IA32_PACKAGE_THERM_STATUS, msr_val);
 	if (msr_val & THERM_LOG_THRESHOLD0) {
 		wrmsrl(MSR_IA32_PACKAGE_THERM_STATUS,
@@ -346,6 +345,9 @@ static void pkg_temp_thermal_threshold_w
 				msr_val & ~THERM_LOG_THRESHOLD1);
 		notify = true;
 	}
+
+	enable_pkg_thres_interrupt();
+
 	if (notify) {
 		pr_debug("thermal_zone_device_update\n");
 		thermal_zone_device_update(phdev->tzone,
@@ -505,6 +507,13 @@ static int pkg_temp_thermal_device_remov
 		list_for_each_entry_safe(phdev, n, &phy_dev_list, list) {
 			if (phdev->phys_proc_id == phys_proc_id) {
 				thermal_zone_device_unregister(phdev->tzone);
+				/*
+				 * Restore original MSR value for package
+				 * thermal interrupt.
+				 */
+				wrmsr_on_cpu(cpu, MSR_IA32_PACKAGE_THERM_INTERRUPT,
+					     phdev->start_pkg_therm_low,
+					     phdev->start_pkg_therm_high);
 				list_del(&phdev->list);
 				kfree(phdev);
 				break;
