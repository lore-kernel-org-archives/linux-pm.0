From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH V3 14/16] cpufreq: Allow drivers to enable boost support after registering driver
Date: Wed, 29 Jul 2015 16:23:09 +0530
Message-ID: <98379f9625b9cc8ade2e052c29e86c29e11cea5e.1438166099.git.viresh.kumar@linaro.org>
References: <cover.1438166099.git.viresh.kumar@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1438166099.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1438166099.git.viresh.kumar@linaro.org>
References: <cover.1438166099.git.viresh.kumar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>, sboyd@codeaurora.org
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, rob.herring@linaro.org, arnd.bergmann@linaro.org, nm@ti.com, broonie@kernel.org, mturquette@baylibre.com, Sudeep.Holla@arm.com, viswanath.puttagunta@linaro.org, l.stach@pengutronix.de, thomas.petazzoni@free-electrons.com, linux-arm-kernel@lists.infradead.org, ta.omasab@gmail.com, kesavan.abhilash@gmail.com, khilman@linaro.org, santosh.shilimkar@oracle.com, b.zolnierkie@samsung.com, Viresh Kumar <viresh.kumar@linaro.org>, open list <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

In some cases it wouldn't be known at time of driver registration, if
the driver needs to support boost frequencies.

For example, while getting boost information from DT with opp-v2
bindings, we need to parse the bindings for all the CPUs to know if
turbo/boost OPPs are supported or not.

One way out to do that efficiently is to delay supporting boost mode
(i.e. creating /sys/devices/system/cpu/cpufreq/boost file), until the
time OPP bindings are parsed.

At that point, the driver can enable boost support. This can be done at
->init(), where the frequency table is created.

To do that, the driver requires few APIs from cpufreq core that let him
do this. This patch provides these APIs.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/cpufreq.c    | 68 +++++++++++++++++++++++++++++++-------------
 drivers/cpufreq/freq_table.c | 15 ++++++++++
 include/linux/cpufreq.h      | 12 ++++++++
 3 files changed, 75 insertions(+), 20 deletions(-)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index 46251e8d30f2..db4390ca5243 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -2459,6 +2459,49 @@ int cpufreq_boost_supported(void)
 }
 EXPORT_SYMBOL_GPL(cpufreq_boost_supported);
 
+static int create_boost_sysfs_file(void)
+{
+	int ret;
+
+	if (!cpufreq_boost_supported())
+		return 0;
+
+	/*
+	 * Check if driver provides function to enable boost -
+	 * if not, use cpufreq_boost_set_sw as default
+	 */
+	if (!cpufreq_driver->set_boost)
+		cpufreq_driver->set_boost = cpufreq_boost_set_sw;
+
+	ret = cpufreq_sysfs_create_file(&boost.attr);
+	if (ret)
+		pr_err("%s: cannot register global BOOST sysfs file\n",
+		       __func__);
+
+	return ret;
+}
+
+static void remove_boost_sysfs_file(void)
+{
+	if (cpufreq_boost_supported())
+		cpufreq_sysfs_remove_file(&boost.attr);
+}
+
+int cpufreq_enable_boost_support(void)
+{
+	if (!cpufreq_driver)
+		return -EINVAL;
+
+	if (cpufreq_boost_supported())
+		return 0;
+
+	cpufreq_driver->boost_supported = true;
+
+	/* This will get removed on driver unregister */
+	return create_boost_sysfs_file();
+}
+EXPORT_SYMBOL_GPL(cpufreq_enable_boost_support);
+
 int cpufreq_boost_enabled(void)
 {
 	return cpufreq_driver->boost_enabled;
@@ -2508,21 +2551,9 @@ int cpufreq_register_driver(struct cpufreq_driver *driver_data)
 	if (driver_data->setpolicy)
 		driver_data->flags |= CPUFREQ_CONST_LOOPS;
 
-	if (cpufreq_boost_supported()) {
-		/*
-		 * Check if driver provides function to enable boost -
-		 * if not, use cpufreq_boost_set_sw as default
-		 */
-		if (!cpufreq_driver->set_boost)
-			cpufreq_driver->set_boost = cpufreq_boost_set_sw;
-
-		ret = cpufreq_sysfs_create_file(&boost.attr);
-		if (ret) {
-			pr_err("%s: cannot register global BOOST sysfs file\n",
-			       __func__);
-			goto err_null_driver;
-		}
-	}
+	ret = create_boost_sysfs_file();
+	if (ret)
+		goto err_null_driver;
 
 	ret = subsys_interface_register(&cpufreq_interface);
 	if (ret)
@@ -2543,8 +2574,7 @@ int cpufreq_register_driver(struct cpufreq_driver *driver_data)
 err_if_unreg:
 	subsys_interface_unregister(&cpufreq_interface);
 err_boost_unreg:
-	if (cpufreq_boost_supported())
-		cpufreq_sysfs_remove_file(&boost.attr);
+	remove_boost_sysfs_file();
 err_null_driver:
 	write_lock_irqsave(&cpufreq_driver_lock, flags);
 	cpufreq_driver = NULL;
@@ -2573,9 +2603,7 @@ int cpufreq_unregister_driver(struct cpufreq_driver *driver)
 	/* Protect against concurrent cpu hotplug */
 	get_online_cpus();
 	subsys_interface_unregister(&cpufreq_interface);
-	if (cpufreq_boost_supported())
-		cpufreq_sysfs_remove_file(&boost.attr);
-
+	remove_boost_sysfs_file();
 	unregister_hotcpu_notifier(&cpufreq_cpu_notifier);
 
 	write_lock_irqsave(&cpufreq_driver_lock, flags);
diff --git a/drivers/cpufreq/freq_table.c b/drivers/cpufreq/freq_table.c
index dfbbf981ed56..a8f1daffc9bc 100644
--- a/drivers/cpufreq/freq_table.c
+++ b/drivers/cpufreq/freq_table.c
@@ -18,6 +18,21 @@
  *                     FREQUENCY TABLE HELPERS                       *
  *********************************************************************/
 
+bool policy_has_boost_freq(struct cpufreq_policy *policy)
+{
+	struct cpufreq_frequency_table *pos, *table = policy->freq_table;
+
+	if (!table)
+		return false;
+
+	cpufreq_for_each_valid_entry(pos, table)
+		if (pos->flags & CPUFREQ_BOOST_FREQ)
+			return true;
+
+	return false;
+}
+EXPORT_SYMBOL_GPL(policy_has_boost_freq);
+
 int cpufreq_frequency_table_cpuinfo(struct cpufreq_policy *policy,
 				    struct cpufreq_frequency_table *table)
 {
diff --git a/include/linux/cpufreq.h b/include/linux/cpufreq.h
index bde1e567b3a9..95f018649abf 100644
--- a/include/linux/cpufreq.h
+++ b/include/linux/cpufreq.h
@@ -578,6 +578,8 @@ ssize_t cpufreq_show_cpus(const struct cpumask *mask, char *buf);
 int cpufreq_boost_trigger_state(int state);
 int cpufreq_boost_supported(void);
 int cpufreq_boost_enabled(void);
+int cpufreq_enable_boost_support(void);
+bool policy_has_boost_freq(struct cpufreq_policy *policy);
 #else
 static inline int cpufreq_boost_trigger_state(int state)
 {
@@ -591,6 +593,16 @@ static inline int cpufreq_boost_enabled(void)
 {
 	return 0;
 }
+
+static inline int cpufreq_enable_boost_support(void)
+{
+	return -EINVAL;
+}
+
+static inline bool policy_has_boost_freq(struct cpufreq_policy *policy)
+{
+	return false;
+}
 #endif
 /* the following funtion is for cpufreq core use only */
 struct cpufreq_frequency_table *cpufreq_frequency_get_table(unsigned int cpu);
-- 
2.4.0
