From: Quentin Perret <quentin.perret@arm.com>
Subject: [PATCH v2 5/5] cpufreq: scmi: Register an Energy Model
Date: Wed, 30 Jan 2019 17:05:06 +0000
Message-ID: <20190130170506.20450-6-quentin.perret@arm.com>
References: <20190130170506.20450-1-quentin.perret@arm.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190130170506.20450-1-quentin.perret@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: viresh.kumar@linaro.org, sudeep.holla@arm.com, rjw@rjwysocki.net, nm@ti.com, sboyd@kernel.org, mka@chromium.org
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, dietmar.eggemann@arm.com, quentin.perret@arm.com
List-Id: linux-pm@vger.kernel.org

The Energy Model (EM) framework provides an API to register the active
power of CPUs. Call this API from the scmi-cpufreq driver by using the
power costs obtained from firmware. This is done to ensure interested
subsystems (the task scheduler, for example) can make use of the EM
when available.

Signed-off-by: Quentin Perret <quentin.perret@arm.com>
---
 drivers/cpufreq/scmi-cpufreq.c | 39 +++++++++++++++++++++++++++++++---
 1 file changed, 36 insertions(+), 3 deletions(-)

diff --git a/drivers/cpufreq/scmi-cpufreq.c b/drivers/cpufreq/scmi-cpufreq.c
index 242c3370544e..0d87e1433296 100644
--- a/drivers/cpufreq/scmi-cpufreq.c
+++ b/drivers/cpufreq/scmi-cpufreq.c
@@ -12,6 +12,7 @@
 #include <linux/cpufreq.h>
 #include <linux/cpumask.h>
 #include <linux/cpu_cooling.h>
+#include <linux/energy_model.h>
 #include <linux/export.h>
 #include <linux/module.h>
 #include <linux/pm_opp.h>
@@ -103,13 +104,42 @@ scmi_get_sharing_cpus(struct device *cpu_dev, struct cpumask *cpumask)
 	return 0;
 }
 
+static int __maybe_unused
+scmi_get_cpu_power(unsigned long *power, unsigned long *KHz, int cpu)
+{
+	struct device *cpu_dev = get_cpu_device(cpu);
+	unsigned long Hz;
+	int ret, domain;
+
+	if (!cpu_dev) {
+		pr_err("failed to get cpu%d device\n", cpu);
+		return -ENODEV;
+	}
+
+	domain = handle->perf_ops->device_domain_id(cpu_dev);
+	if (domain < 0)
+		return domain;
+
+	/* Get the power cost of the performance domain. */
+	Hz = *KHz * 1000;
+	ret = handle->perf_ops->est_power_get(handle, domain, &Hz, power);
+	if (ret)
+		return ret;
+
+	/* The EM framework specifies the frequency in KHz. */
+	*KHz = Hz / 1000;
+
+	return 0;
+}
+
 static int scmi_cpufreq_init(struct cpufreq_policy *policy)
 {
-	int ret;
+	int ret, nr_opp;
 	unsigned int latency;
 	struct device *cpu_dev;
 	struct scmi_data *priv;
 	struct cpufreq_frequency_table *freq_table;
+	struct em_data_callback em_cb = EM_DATA_CB(scmi_get_cpu_power);
 
 	cpu_dev = get_cpu_device(policy->cpu);
 	if (!cpu_dev) {
@@ -136,8 +166,8 @@ static int scmi_cpufreq_init(struct cpufreq_policy *policy)
 		return ret;
 	}
 
-	ret = dev_pm_opp_get_opp_count(cpu_dev);
-	if (ret <= 0) {
+	nr_opp = dev_pm_opp_get_opp_count(cpu_dev);
+	if (nr_opp <= 0) {
 		dev_dbg(cpu_dev, "OPP table is not ready, deferring probe\n");
 		ret = -EPROBE_DEFER;
 		goto out_free_opp;
@@ -171,6 +201,9 @@ static int scmi_cpufreq_init(struct cpufreq_policy *policy)
 	policy->cpuinfo.transition_latency = latency;
 
 	policy->fast_switch_possible = true;
+
+	em_register_perf_domain(policy->cpus, nr_opp, &em_cb);
+
 	return 0;
 
 out_free_priv:
-- 
2.20.1
