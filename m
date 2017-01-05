From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [RFC][PATCH 2/2] cpufreq: intel_pstate: Operation mode control from sysfs
Date: Thu, 05 Jan 2017 02:53:12 +0100
Message-ID: <5692697.SDQbsNS8pc@aspire.rjw.lan>
References: <21825845.nN3skUNMsO@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <21825845.nN3skUNMsO@aspire.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: Linux PM <linux-pm@vger.kernel.org>
Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Make it possible to change the operation mode of intel_pstate with
the help of a new sysfs attribute called "status".

There are three possible configurations that can be selected using
this attribute:

 "off"     - The driver is not in use at this time.
 "active"  - The driver works as a P-state governor (default).
 "passive" - The driver works as a regular cpufreq one and collaborates
             with the generic cpufreq governors (it sets P-states as
             requested by those governors).  [This is the same mode
             the driver can be started in by passing intel_pstate=passive
             in the kernel command line.]

The current setting is returned by reads from this attribute.  Writing
one of the above strings to it changes the operation mode as indicated
by that string, if possible.

If HW-managed P-states (HWP) feature is enabled, it is not possible
to change the driver's operation mode and attempts to write to this
attribute will fail.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 Documentation/cpu-freq/intel-pstate.txt |   15 ++
 drivers/cpufreq/intel_pstate.c          |  224 +++++++++++++++++++++++++-------
 2 files changed, 195 insertions(+), 44 deletions(-)

Index: linux-pm/drivers/cpufreq/intel_pstate.c
===================================================================
--- linux-pm.orig/drivers/cpufreq/intel_pstate.c
+++ linux-pm/drivers/cpufreq/intel_pstate.c
@@ -541,7 +541,6 @@ static void intel_pstate_exit_perf_limit
 
 	acpi_processor_unregister_performance(policy->cpu);
 }
-
 #else
 static inline void intel_pstate_init_acpi_perf_limits(struct cpufreq_policy *policy)
 {
@@ -1010,35 +1009,57 @@ static int pid_param_get(void *data, u64
 }
 DEFINE_SIMPLE_ATTRIBUTE(fops_pid_param, pid_param_get, pid_param_set, "%llu\n");
 
+static struct dentry *debugfs_parent;
+
 struct pid_param {
 	char *name;
 	void *value;
+	struct dentry *dentry;
 };
 
 static struct pid_param pid_files[] = {
-	{"sample_rate_ms", &pid_params.sample_rate_ms},
-	{"d_gain_pct", &pid_params.d_gain_pct},
-	{"i_gain_pct", &pid_params.i_gain_pct},
-	{"deadband", &pid_params.deadband},
-	{"setpoint", &pid_params.setpoint},
-	{"p_gain_pct", &pid_params.p_gain_pct},
-	{NULL, NULL}
+	{"sample_rate_ms", &pid_params.sample_rate_ms, },
+	{"d_gain_pct", &pid_params.d_gain_pct, },
+	{"i_gain_pct", &pid_params.i_gain_pct, },
+	{"deadband", &pid_params.deadband, },
+	{"setpoint", &pid_params.setpoint, },
+	{"p_gain_pct", &pid_params.p_gain_pct, },
+	{NULL, NULL, }
 };
 
-static void __init intel_pstate_debug_expose_params(void)
+static void intel_pstate_debug_expose_params(void)
 {
-	struct dentry *debugfs_parent;
-	int i = 0;
+	int i;
 
 	debugfs_parent = debugfs_create_dir("pstate_snb", NULL);
 	if (IS_ERR_OR_NULL(debugfs_parent))
 		return;
-	while (pid_files[i].name) {
-		debugfs_create_file(pid_files[i].name, 0660,
-				    debugfs_parent, pid_files[i].value,
-				    &fops_pid_param);
-		i++;
+
+	for (i = 0; pid_files[i].name; i++) {
+		struct dentry *dentry;
+
+		dentry = debugfs_create_file(pid_files[i].name, 0660,
+					     debugfs_parent, pid_files[i].value,
+					     &fops_pid_param);
+		if (!IS_ERR(dentry))
+			pid_files[i].dentry = dentry;
+	}
+}
+
+static void intel_pstate_debug_hide_params(void)
+{
+	int i;
+
+	if (IS_ERR_OR_NULL(debugfs_parent))
+		return;
+
+	for (i = 0; pid_files[i].name; i++) {
+		debugfs_remove(pid_files[i].dentry);
+		pid_files[i].dentry = NULL;
 	}
+
+	debugfs_remove(debugfs_parent);
+	debugfs_parent = NULL;
 }
 
 /************************** debugfs end ************************/
@@ -1051,6 +1072,34 @@ static void __init intel_pstate_debug_ex
 		return sprintf(buf, "%u\n", limits->object);		\
 	}
 
+static ssize_t intel_pstate_show_status(char *buf);
+static int intel_pstate_update_status(const char *buf, size_t size);
+
+static ssize_t show_status(struct kobject *kobj,
+			   struct attribute *attr, char *buf)
+{
+	ssize_t ret;
+
+	mutex_lock(&intel_pstate_driver_lock);
+	ret = intel_pstate_show_status(buf);
+	mutex_unlock(&intel_pstate_driver_lock);
+
+	return ret;
+}
+
+static ssize_t store_status(struct kobject *a, struct attribute *b,
+			    const char *buf, size_t count)
+{
+	char *p = memchr(buf, '\n', count);
+	int ret;
+
+	mutex_lock(&intel_pstate_driver_lock);
+	ret = intel_pstate_update_status(buf, p ? p - buf : count);
+	mutex_unlock(&intel_pstate_driver_lock);
+
+	return ret < 0 ? ret : count;
+}
+
 static ssize_t show_turbo_pct(struct kobject *kobj,
 				struct attribute *attr, char *buf)
 {
@@ -1235,6 +1284,7 @@ static ssize_t store_min_perf_pct(struct
 show_one(max_perf_pct, max_perf_pct);
 show_one(min_perf_pct, min_perf_pct);
 
+define_one_global_rw(status);
 define_one_global_rw(no_turbo);
 define_one_global_rw(max_perf_pct);
 define_one_global_rw(min_perf_pct);
@@ -1242,6 +1292,7 @@ define_one_global_ro(turbo_pct);
 define_one_global_ro(num_pstates);
 
 static struct attribute *intel_pstate_attributes[] = {
+	&status.attr,
 	&no_turbo.attr,
 	&turbo_pct.attr,
 	&num_pstates.attr,
@@ -2316,6 +2367,111 @@ static struct cpufreq_driver intel_cpufr
 
 static struct cpufreq_driver *intel_pstate_driver = &intel_pstate;
 
+static void intel_pstate_driver_cleanup(void)
+{
+	unsigned int cpu;
+
+	get_online_cpus();
+	for_each_online_cpu(cpu) {
+		if (all_cpu_data[cpu]) {
+			if (intel_pstate_driver == &intel_pstate)
+				intel_pstate_clear_update_util_hook(cpu);
+
+			kfree(all_cpu_data[cpu]);
+			all_cpu_data[cpu] = NULL;
+		}
+	}
+	put_online_cpus();
+}
+
+static int intel_pstate_register_driver(void)
+{
+	int ret;
+
+	ret = cpufreq_register_driver(intel_pstate_driver);
+	if (ret) {
+		intel_pstate_driver_cleanup();
+		return ret;
+	}
+
+	mutex_lock(&intel_pstate_limits_lock);
+	driver_registered = true;
+	mutex_unlock(&intel_pstate_limits_lock);
+
+	if (intel_pstate_driver == &intel_pstate && !hwp_active &&
+	    pstate_funcs.get_target_pstate != get_target_pstate_use_cpu_load)
+		intel_pstate_debug_expose_params();
+
+	return 0;
+}
+
+static int intel_pstate_unregister_driver(void)
+{
+	if (hwp_active)
+		return -EBUSY;
+
+	if (intel_pstate_driver == &intel_pstate && !hwp_active &&
+	    pstate_funcs.get_target_pstate != get_target_pstate_use_cpu_load)
+		intel_pstate_debug_hide_params();
+
+	mutex_lock(&intel_pstate_limits_lock);
+	driver_registered = false;
+	mutex_unlock(&intel_pstate_limits_lock);
+
+	cpufreq_unregister_driver(intel_pstate_driver);
+	intel_pstate_driver_cleanup();
+
+	return 0;
+}
+
+static ssize_t intel_pstate_show_status(char *buf)
+{
+	if (!driver_registered)
+		return sprintf(buf, "off\n");
+
+	return sprintf(buf, "%s\n", intel_pstate_driver == &intel_pstate ?
+					"active" : "passive");
+}
+
+static int intel_pstate_update_status(const char *buf, size_t size)
+{
+	int ret;
+
+	if (size == 3 && !strncmp(buf, "off", size))
+		return driver_registered ?
+			intel_pstate_unregister_driver() : -EINVAL;
+
+	if (size == 6 && !strncmp(buf, "active", size)) {
+		if (driver_registered) {
+			if (intel_pstate_driver == &intel_pstate)
+				return 0;
+
+			ret = intel_pstate_unregister_driver();
+			if (ret)
+				return ret;
+		}
+
+		intel_pstate_driver = &intel_pstate;
+		return intel_pstate_register_driver();
+	}
+
+	if (size == 7 && !strncmp(buf, "passive", size)) {
+		if (driver_registered) {
+			if (intel_pstate_driver != &intel_pstate)
+				return 0;
+
+			ret = intel_pstate_unregister_driver();
+			if (ret)
+				return ret;
+		}
+
+		intel_pstate_driver = &intel_cpufreq;
+		return intel_pstate_register_driver();
+	}
+
+	return -EINVAL;
+}
+
 static int no_load __initdata;
 static int no_hwp __initdata;
 static int hwp_only __initdata;
@@ -2503,9 +2659,9 @@ static const struct x86_cpu_id hwp_suppo
 
 static int __init intel_pstate_init(void)
 {
-	int cpu, rc = 0;
 	const struct x86_cpu_id *id;
 	struct cpu_defaults *cpu_def;
+	int rc = 0;
 
 	if (no_load)
 		return -ENODEV;
@@ -2537,49 +2693,29 @@ hwp_cpu_matched:
 	if (intel_pstate_platform_pwr_mgmt_exists())
 		return -ENODEV;
 
+	if (!hwp_active && hwp_only)
+		return -ENOTSUPP;
+
 	pr_info("Intel P-state driver initializing\n");
 
 	all_cpu_data = vzalloc(sizeof(void *) * num_possible_cpus());
 	if (!all_cpu_data)
 		return -ENOMEM;
 
-	if (!hwp_active && hwp_only)
-		goto out;
-
 	intel_pstate_request_control_from_smm();
 
 	intel_pstate_sysfs_expose_params();
 
-	rc = cpufreq_register_driver(intel_pstate_driver);
-	if (rc)
-		goto out;
-
 	mutex_lock(&intel_pstate_driver_lock);
-	driver_registered = true;
+	rc = intel_pstate_register_driver();
 	mutex_unlock(&intel_pstate_driver_lock);
-
-	if (intel_pstate_driver == &intel_pstate && !hwp_active &&
-	    pstate_funcs.get_target_pstate != get_target_pstate_use_cpu_load)
-		intel_pstate_debug_expose_params();
+	if (rc)
+		return rc;
 
 	if (hwp_active)
 		pr_info("HWP enabled\n");
 
-	return rc;
-out:
-	get_online_cpus();
-	for_each_online_cpu(cpu) {
-		if (all_cpu_data[cpu]) {
-			if (intel_pstate_driver == &intel_pstate)
-				intel_pstate_clear_update_util_hook(cpu);
-
-			kfree(all_cpu_data[cpu]);
-		}
-	}
-
-	put_online_cpus();
-	vfree(all_cpu_data);
-	return -ENODEV;
+	return 0;
 }
 device_initcall(intel_pstate_init);
 
Index: linux-pm/Documentation/cpu-freq/intel-pstate.txt
===================================================================
--- linux-pm.orig/Documentation/cpu-freq/intel-pstate.txt
+++ linux-pm/Documentation/cpu-freq/intel-pstate.txt
@@ -85,6 +85,21 @@ Sysfs will show :
 Refer to "Intel® 64 and IA-32 Architectures Software Developer’s Manual
 Volume 3: System Programming Guide" to understand ratios.
 
+There is one more sysfs attribute in /sys/devices/system/cpu/intel_pstate/
+that can be used for controlling the operation mode of the driver:
+
+      status: Three settings are possible:
+      "off"     - The driver is not in use at this time.
+      "active"  - The driver works as a P-state governor (default).
+      "passive" - The driver works as a regular cpufreq one and collaborates
+                  with the generic cpufreq governors (it sets P-states as
+                  requested by those governors).
+      The current setting is returned by reads from this attribute.  Writing one
+      of the above strings to it changes the operation mode as indicated by that
+      string, if possible.  If HW-managed P-states (HWP) are enabled, it is not
+      possible to change the driver's operation mode and attempts to write to
+      this attribute will fail.
+
 cpufreq sysfs for Intel P-State
 
 Since this driver registers with cpufreq, cpufreq sysfs is also presented.
