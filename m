From: Thomas Gleixner <tglx@linutronix.de>
Subject: [patch V2 02/12] thermal/x86_pkg_temp: Remove redundant package search
Date: Tue, 22 Nov 2016 17:57:05 -0000
Message-ID: <20161122175357.029139356@linutronix.de>
References: <20161122175256.922158782@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline;
 filename=thermalx86_pkg_temp_Remove_redundant_package_search.patch
Sender: linux-kernel-owner@vger.kernel.org
To: LKML <linux-kernel@vger.kernel.org>
Cc: Rui Zhang <rui.zhang@intel.com>, edubezval@gmail.com, Peter Zijlstra <peterz@infradead.org>, Borislav Petkov <bp@alien8.de>, linux-pm@vger.kernel.org, x86@kernel.org, rt@linutronix.de, Srinivas Pandruvada <srinivas.pandruvada@intel.com>
List-Id: linux-pm@vger.kernel.org

In pkg_temp_thermal_device_remove() the package device is searched at the
beginning of the function. When the device refcount becomes zero another
search for the same device is conducted. Remove the pointless loop and use
the device pointer which was retrieved at the beginning of the function.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

---
 drivers/thermal/x86_pkg_temp_thermal.c |   33 ++++++++++++++-------------------
 1 file changed, 14 insertions(+), 19 deletions(-)

--- a/drivers/thermal/x86_pkg_temp_thermal.c
+++ b/drivers/thermal/x86_pkg_temp_thermal.c
@@ -479,10 +479,8 @@ static int pkg_temp_thermal_device_add(u
 
 static int pkg_temp_thermal_device_remove(unsigned int cpu)
 {
-	struct phy_dev_entry *n;
+	struct phy_dev_entry *phdev = pkg_temp_thermal_get_phy_entry(cpu);
 	u16 phys_proc_id = topology_physical_package_id(cpu);
-	struct phy_dev_entry *phdev =
-			pkg_temp_thermal_get_phy_entry(cpu);
 
 	if (!phdev)
 		return -ENODEV;
@@ -503,22 +501,19 @@ static int pkg_temp_thermal_device_remov
 	--phdev->ref_cnt;
 	pr_debug("thermal_device_remove: pkg: %d cpu %d ref_cnt %d\n",
 					phys_proc_id, cpu, phdev->ref_cnt);
-	if (!phdev->ref_cnt)
-		list_for_each_entry_safe(phdev, n, &phy_dev_list, list) {
-			if (phdev->phys_proc_id == phys_proc_id) {
-				thermal_zone_device_unregister(phdev->tzone);
-				/*
-				 * Restore original MSR value for package
-				 * thermal interrupt.
-				 */
-				wrmsr_on_cpu(cpu, MSR_IA32_PACKAGE_THERM_INTERRUPT,
-					     phdev->start_pkg_therm_low,
-					     phdev->start_pkg_therm_high);
-				list_del(&phdev->list);
-				kfree(phdev);
-				break;
-			}
-		}
+
+	if (!phdev->ref_cnt) {
+		thermal_zone_device_unregister(phdev->tzone);
+		/*
+		 * Restore original MSR value for package thermal
+		 * interrupt.
+		 */
+		wrmsr_on_cpu(cpu, MSR_IA32_PACKAGE_THERM_INTERRUPT,
+			     phdev->start_pkg_therm_low,
+			     phdev->start_pkg_therm_high);
+		list_del(&phdev->list);
+		kfree(phdev);
+	}
 	mutex_unlock(&phy_dev_list_mutex);
 
 	return 0;
