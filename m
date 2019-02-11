From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH 2/2] cpufreq: dt: Implement light_weight_exit() callback
Date: Mon, 11 Feb 2019 14:11:36 +0530
Message-ID: <742f4f42ae944a3ad13216f96fb0d03d394c395e.1549874368.git.viresh.kumar@linaro.org>
References: <cover.1549874368.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1549874368.git.viresh.kumar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, Sudeep Holla <sudeep.holla@arm.com>, Marek Szyprowski <m.szyprowski@samsung.com>, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Implement the light-weight tear down helper to reduce the amount of work
to do on CPU offline/online operation.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/cpufreq-dt.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/drivers/cpufreq/cpufreq-dt.c b/drivers/cpufreq/cpufreq-dt.c
index 7ba392911cd0..69309a8121f0 100644
--- a/drivers/cpufreq/cpufreq-dt.c
+++ b/drivers/cpufreq/cpufreq-dt.c
@@ -160,6 +160,15 @@ static int cpufreq_init(struct cpufreq_policy *policy)
 	const char *name;
 	int ret;
 
+	/*
+	 * We did light-weight shutdown earlier, nothing else to initialize here
+	 * apart from policy->cpus.
+	 */
+	if (policy->driver_data) {
+		cpumask_copy(policy->cpus, policy->related_cpus);
+		return 0;
+	}
+
 	cpu_dev = get_cpu_device(policy->cpu);
 	if (!cpu_dev) {
 		pr_err("failed to get cpu%d device\n", policy->cpu);
@@ -295,6 +304,15 @@ static int cpufreq_init(struct cpufreq_policy *policy)
 	return ret;
 }
 
+static int cpufreq_light_weight_exit(struct cpufreq_policy *policy)
+{
+	/*
+	 * Preserve policy->driver_data and don't free resources on light-weight
+	 * tear down.
+	 */
+	return 0;
+}
+
 static int cpufreq_exit(struct cpufreq_policy *policy)
 {
 	struct private_data *priv = policy->driver_data;
@@ -319,6 +337,7 @@ static struct cpufreq_driver dt_cpufreq_driver = {
 	.get = cpufreq_generic_get,
 	.init = cpufreq_init,
 	.exit = cpufreq_exit,
+	.light_weight_exit = cpufreq_light_weight_exit,
 	.name = "cpufreq-dt",
 	.attr = cpufreq_dt_attr,
 	.suspend = cpufreq_generic_suspend,
-- 
2.20.1.321.g9e740568ce00
