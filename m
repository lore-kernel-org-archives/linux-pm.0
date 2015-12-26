From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH 3/3] cpufreq: Simplify core code related to boost support
Date: Sun, 27 Dec 2015 00:27:38 +0100
Message-ID: <2445772.lclmJ5R52X@vostro.rjw.lan>
References: <2196419.fjWAQbI2Nm@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:47043 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751277AbbLZW5T (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sat, 26 Dec 2015 17:57:19 -0500
In-Reply-To: <2196419.fjWAQbI2Nm@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Linux PM list <linux-pm@vger.kernel.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Notice that the boost_supported field in struct cpufreq_driver is
redundant, because the driver's ->set_boost callback may be left
unset if "boost" is not supported.  Moreover, the only driver
populating the ->set_boost callback is acpi_cpufreq, so make it
avoid populating that callback if "boost" is not supported, rework
the core to check ->set_boost instead of boost_supported to
verify "boost" support and drop boost_supported which isn't
used any more.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/cpufreq/acpi-cpufreq.c |    5 ++---
 drivers/cpufreq/cpufreq.c      |   22 +++++++---------------
 include/linux/cpufreq.h        |    1 -
 3 files changed, 9 insertions(+), 19 deletions(-)

Index: linux-pm/drivers/cpufreq/acpi-cpufreq.c
===================================================================
--- linux-pm.orig/drivers/cpufreq/acpi-cpufreq.c
+++ linux-pm/drivers/cpufreq/acpi-cpufreq.c
@@ -164,7 +164,7 @@ static ssize_t store_cpb(struct cpufreq_
 	int ret;
 	unsigned int val = 0;
 
-	if (!acpi_cpufreq_driver.boost_supported)
+	if (!acpi_cpufreq_driver.set_boost)
 		return -EINVAL;
 
 	ret = kstrtouint(buf, 10, &val);
@@ -900,7 +900,6 @@ static struct cpufreq_driver acpi_cpufre
 	.resume		= acpi_cpufreq_resume,
 	.name		= "acpi-cpufreq",
 	.attr		= acpi_cpufreq_attr,
-	.set_boost      = set_boost,
 };
 
 static void __init acpi_cpufreq_boost_init(void)
@@ -911,7 +910,7 @@ static void __init acpi_cpufreq_boost_in
 		if (!msrs)
 			return;
 
-		acpi_cpufreq_driver.boost_supported = true;
+		acpi_cpufreq_driver.set_boost = set_boost;
 		acpi_cpufreq_driver.boost_enabled = boost_state(0);
 
 		cpu_notifier_register_begin();
Index: linux-pm/drivers/cpufreq/cpufreq.c
===================================================================
--- linux-pm.orig/drivers/cpufreq/cpufreq.c
+++ linux-pm/drivers/cpufreq/cpufreq.c
@@ -2332,23 +2332,13 @@ int cpufreq_boost_trigger_state(int stat
 
 static bool cpufreq_boost_supported(void)
 {
-	return likely(cpufreq_driver) && cpufreq_driver->boost_supported;
+	return likely(cpufreq_driver) && cpufreq_driver->set_boost;
 }
 
 static int create_boost_sysfs_file(void)
 {
 	int ret;
 
-	if (!cpufreq_boost_supported())
-		return 0;
-
-	/*
-	 * Check if driver provides function to enable boost -
-	 * if not, use cpufreq_boost_set_sw as default
-	 */
-	if (!cpufreq_driver->set_boost)
-		cpufreq_driver->set_boost = cpufreq_boost_set_sw;
-
 	ret = sysfs_create_file(cpufreq_global_kobject, &boost.attr);
 	if (ret)
 		pr_err("%s: cannot register global BOOST sysfs file\n",
@@ -2371,7 +2361,7 @@ int cpufreq_enable_boost_support(void)
 	if (cpufreq_boost_supported())
 		return 0;
 
-	cpufreq_driver->boost_supported = true;
+	cpufreq_driver->set_boost = cpufreq_boost_set_sw;
 
 	/* This will get removed on driver unregister */
 	return create_boost_sysfs_file();
@@ -2431,9 +2421,11 @@ int cpufreq_register_driver(struct cpufr
 	if (driver_data->setpolicy)
 		driver_data->flags |= CPUFREQ_CONST_LOOPS;
 
-	ret = create_boost_sysfs_file();
-	if (ret)
-		goto err_null_driver;
+	if (cpufreq_boost_supported()) {
+		ret = create_boost_sysfs_file();
+		if (ret)
+			goto err_null_driver;
+	}
 
 	ret = subsys_interface_register(&cpufreq_interface);
 	if (ret)
Index: linux-pm/include/linux/cpufreq.h
===================================================================
--- linux-pm.orig/include/linux/cpufreq.h
+++ linux-pm/include/linux/cpufreq.h
@@ -278,7 +278,6 @@ struct cpufreq_driver {
 	struct freq_attr **attr;
 
 	/* platform specific boost support code */
-	bool		boost_supported;
 	bool		boost_enabled;
 	int		(*set_boost)(int state);
 };

