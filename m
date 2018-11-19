From: Quentin Perret <quentin.perret@arm.com>
Subject: [PATCH v9 15/15] OPTIONAL: cpufreq: dt: Register an Energy Model
Date: Mon, 19 Nov 2018 14:18:57 +0000
Message-ID: <20181119141857.8625-16-quentin.perret@arm.com>
References: <20181119141857.8625-1-quentin.perret@arm.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181119141857.8625-1-quentin.perret@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: peterz@infradead.org, rjw@rjwysocki.net, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Cc: gregkh@linuxfoundation.org, mingo@redhat.com, dietmar.eggemann@arm.com, morten.rasmussen@arm.com, chris.redpath@arm.com, patrick.bellasi@arm.com, valentin.schneider@arm.com, vincent.guittot@linaro.org, thara.gopinath@linaro.org, viresh.kumar@linaro.org, tkjos@google.com, joel@joelfernandes.org, smuckle@google.com, adharmap@codeaurora.org, skannan@codeaurora.org, pkondeti@codeaurora.org, juri.lelli@redhat.com, edubezval@gmail.com, srinivas.pandruvada@linux.intel.com, currojerez@riseup.net, javi.merino@kernel.org, quentin.perret@arm.com
List-Id: linux-pm@vger.kernel.org

*******************************************************************
* This patch illustrates the usage of the newly introduced Energy *
* Model framework and isn't supposed to be merged as-is.          *
*******************************************************************

The Energy Model framework provides an API to register the active power
of CPUs. Call this API from the cpufreq-dt driver with an estimation
of the power as P = C * V^2 * f with C, V, and f respectively the
capacitance of the CPU and the voltage and frequency of the OPP.

The CPU capacitance is read from the "dynamic-power-coefficient" DT
binding (originally introduced for thermal/IPA), and the voltage and
frequency values from PM_OPP.

Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Viresh Kumar <viresh.kumar@linaro.org>
Signed-off-by: Quentin Perret <quentin.perret@arm.com>
---
 drivers/cpufreq/cpufreq-dt.c | 48 +++++++++++++++++++++++++++++++++++-
 1 file changed, 47 insertions(+), 1 deletion(-)

diff --git a/drivers/cpufreq/cpufreq-dt.c b/drivers/cpufreq/cpufreq-dt.c
index e58bfcb1169e..4cfef5554d86 100644
--- a/drivers/cpufreq/cpufreq-dt.c
+++ b/drivers/cpufreq/cpufreq-dt.c
@@ -16,6 +16,7 @@
 #include <linux/cpu_cooling.h>
 #include <linux/cpufreq.h>
 #include <linux/cpumask.h>
+#include <linux/energy_model.h>
 #include <linux/err.h>
 #include <linux/module.h>
 #include <linux/of.h>
@@ -150,8 +151,50 @@ static int resources_available(void)
 	return 0;
 }
 
+static int __maybe_unused of_est_power(unsigned long *mW, unsigned long *KHz,
+				       int cpu)
+{
+	unsigned long mV, Hz, MHz;
+	struct device *cpu_dev;
+	struct dev_pm_opp *opp;
+	struct device_node *np;
+	u32 cap;
+	u64 tmp;
+
+	cpu_dev = get_cpu_device(cpu);
+	if (!cpu_dev)
+		return -ENODEV;
+
+	np = of_node_get(cpu_dev->of_node);
+	if (!np)
+		return -EINVAL;
+
+	if (of_property_read_u32(np, "dynamic-power-coefficient", &cap))
+		return -EINVAL;
+
+	Hz = *KHz * 1000;
+	opp = dev_pm_opp_find_freq_ceil(cpu_dev, &Hz);
+	if (IS_ERR(opp))
+		return -EINVAL;
+
+	mV = dev_pm_opp_get_voltage(opp) / 1000;
+	dev_pm_opp_put(opp);
+	if (!mV)
+		return -EINVAL;
+
+	MHz = Hz / 1000000;
+	tmp = (u64)cap * mV * mV * MHz;
+	do_div(tmp, 1000000000);
+
+	*mW = (unsigned long)tmp;
+	*KHz = Hz / 1000;
+
+	return 0;
+}
+
 static int cpufreq_init(struct cpufreq_policy *policy)
 {
+	struct em_data_callback em_cb = EM_DATA_CB(of_est_power);
 	struct cpufreq_frequency_table *freq_table;
 	struct opp_table *opp_table = NULL;
 	struct private_data *priv;
@@ -160,7 +203,7 @@ static int cpufreq_init(struct cpufreq_policy *policy)
 	unsigned int transition_latency;
 	bool fallback = false;
 	const char *name;
-	int ret;
+	int ret, nr_opp;
 
 	cpu_dev = get_cpu_device(policy->cpu);
 	if (!cpu_dev) {
@@ -237,6 +280,7 @@ static int cpufreq_init(struct cpufreq_policy *policy)
 		ret = -EPROBE_DEFER;
 		goto out_free_opp;
 	}
+	nr_opp = ret;
 
 	if (fallback) {
 		cpumask_setall(policy->cpus);
@@ -280,6 +324,8 @@ static int cpufreq_init(struct cpufreq_policy *policy)
 	policy->cpuinfo.transition_latency = transition_latency;
 	policy->dvfs_possible_from_any_cpu = true;
 
+	em_register_perf_domain(policy->cpus, nr_opp, &em_cb);
+
 	return 0;
 
 out_free_cpufreq_table:
-- 
2.19.1
