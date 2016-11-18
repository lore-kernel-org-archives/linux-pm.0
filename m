From: Thomas Gleixner <tglx@linutronix.de>
Subject: [patch 04/12] thermal/x86_pkg_temp: Sanitize callback
 (de)initialization
Date: Fri, 18 Nov 2016 00:03:26 -0000
Message-ID: <20161117234810.192106647@linutronix.de>
References: <20161117231435.891545908@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline;
 filename=thermal-x86_pkg_temp--Sanitize-callback--de-initialization.patch
Sender: linux-kernel-owner@vger.kernel.org
To: LKML <linux-kernel@vger.kernel.org>
Cc: Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, linux-pm@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, x86@kernel.org, rt@linutronix.de, Borislav Petkov <bp@alien8.de>
List-Id: linux-pm@vger.kernel.org

The threshold callbacks are installed before the initialization of the
online cpus has succeeded and removed after the teardown has been
done. That's both wrong as callbacks might be invoked into a half
initialized or torn down state.

Move them to the proper places: Last in init() and first in exit().

While at it shorten the insane long and horrible named function names.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 drivers/thermal/x86_pkg_temp_thermal.c |   19 ++++++++-----------
 1 file changed, 8 insertions(+), 11 deletions(-)

--- a/drivers/thermal/x86_pkg_temp_thermal.c
+++ b/drivers/thermal/x86_pkg_temp_thermal.c
@@ -281,7 +281,7 @@ static struct thermal_zone_device_ops tz
 	.set_trip_temp = sys_set_trip_temp,
 };
 
-static bool pkg_temp_thermal_platform_thermal_rate_control(void)
+static bool pkg_thermal_rate_control(void)
 {
 	return true;
 }
@@ -355,7 +355,7 @@ static void pkg_temp_thermal_threshold_w
 	}
 }
 
-static int pkg_temp_thermal_platform_thermal_notify(__u64 msr_val)
+static int pkg_thermal_notify(__u64 msr_val)
 {
 	unsigned long flags;
 	int cpu = smp_processor_id();
@@ -579,10 +579,6 @@ static int __init pkg_temp_thermal_init(
 		return -ENODEV;
 
 	spin_lock_init(&pkg_work_lock);
-	platform_thermal_package_notify =
-			pkg_temp_thermal_platform_thermal_notify;
-	platform_thermal_package_rate_control =
-			pkg_temp_thermal_platform_thermal_rate_control;
 
 	cpu_notifier_register_begin();
 	for_each_online_cpu(i)
@@ -591,6 +587,9 @@ static int __init pkg_temp_thermal_init(
 	__register_hotcpu_notifier(&pkg_temp_thermal_notifier);
 	cpu_notifier_register_done();
 
+	platform_thermal_package_notify = pkg_thermal_notify;
+	platform_thermal_package_rate_control = pkg_thermal_rate_control;
+
 	pkg_temp_debugfs_init(); /* Don't care if fails */
 
 	return 0;
@@ -600,9 +599,6 @@ static int __init pkg_temp_thermal_init(
 		put_core_offline(i);
 	cpu_notifier_register_done();
 	kfree(pkg_work_scheduled);
-	platform_thermal_package_notify = NULL;
-	platform_thermal_package_rate_control = NULL;
-
 	return -ENODEV;
 }
 
@@ -611,6 +607,9 @@ static void __exit pkg_temp_thermal_exit
 	struct phy_dev_entry *phdev, *n;
 	int i;
 
+	platform_thermal_package_notify = NULL;
+	platform_thermal_package_rate_control = NULL;
+
 	cpu_notifier_register_begin();
 	__unregister_hotcpu_notifier(&pkg_temp_thermal_notifier);
 	mutex_lock(&phy_dev_list_mutex);
@@ -625,8 +624,6 @@ static void __exit pkg_temp_thermal_exit
 		kfree(phdev);
 	}
 	mutex_unlock(&phy_dev_list_mutex);
-	platform_thermal_package_notify = NULL;
-	platform_thermal_package_rate_control = NULL;
 	for_each_online_cpu(i)
 		cancel_delayed_work_sync(
 			&per_cpu(pkg_temp_thermal_threshold_work, i));
