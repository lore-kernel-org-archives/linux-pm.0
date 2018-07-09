From: George Cherian <george.cherian@cavium.com>
Subject: [PATCH v3] cpufreq / CPPC: Add cpuinfo_cur_freq support for CPPC
Date: Mon,  9 Jul 2018 03:10:48 -0700
Message-ID: <1531131048-60762-1-git-send-email-george.cherian@cavium.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Cc: viresh.kumar@linaro.org, rjw@rjwysocki.net, pprakash@codeaurora.org, George Cherian <george.cherian@cavium.com>
List-Id: linux-pm@vger.kernel.org

Per Section 8.4.7.1.3 of ACPI 6.2, The platform provides performance
feedback via set of performance counters. To determine the actual
performance level delivered over time, OSPM may read a set of
performance counters from the Reference Performance Counter Register
and the Delivered Performance Counter Register.

OSPM calculates the delivered performance over a given time period by
taking a beginning and ending snapshot of both the reference and
delivered performance counters, and calculating:

delivered_perf = reference_perf X (delta of delivered_perf counter / delta of reference_perf counter).

Implement the above and hook this to the cpufreq->get method.

Signed-off-by: George Cherian <george.cherian@cavium.com>
Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/cppc_cpufreq.c | 44 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 44 insertions(+)

diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
index a9d3eec..61132e8 100644
--- a/drivers/cpufreq/cppc_cpufreq.c
+++ b/drivers/cpufreq/cppc_cpufreq.c
@@ -296,10 +296,54 @@ static int cppc_cpufreq_cpu_init(struct cpufreq_policy *policy)
 	return ret;
 }
 
+static int cppc_get_rate_from_fbctrs(struct cppc_cpudata *cpu,
+				     struct cppc_perf_fb_ctrs fb_ctrs_t0,
+				     struct cppc_perf_fb_ctrs fb_ctrs_t1)
+{
+	u64 delta_reference, delta_delivered;
+	u64 reference_perf, delivered_perf;
+
+	reference_perf = fb_ctrs_t0.reference_perf;
+
+	delta_reference = (u32)fb_ctrs_t1.reference -
+				(u32)fb_ctrs_t0.reference;
+	delta_delivered = (u32)fb_ctrs_t1.delivered -
+				(u32)fb_ctrs_t0.delivered;
+
+	/* Check to avoid divide-by zero */
+	if (delta_reference || delta_delivered)
+		delivered_perf = (reference_perf * delta_delivered) /
+					delta_reference;
+	else
+		delivered_perf = cpu->perf_ctrls.desired_perf;
+
+	return cppc_cpufreq_perf_to_khz(cpu, delivered_perf);
+}
+
+static unsigned int cppc_cpufreq_get_rate(unsigned int cpunum)
+{
+	struct cppc_perf_fb_ctrs fb_ctrs_t0 = {0}, fb_ctrs_t1 = {0};
+	struct cppc_cpudata *cpu = all_cpu_data[cpunum];
+	int ret;
+
+	ret = cppc_get_perf_ctrs(cpunum, &fb_ctrs_t0);
+	if (ret)
+		return ret;
+
+	udelay(2); /* 2usec delay between sampling */
+
+	ret = cppc_get_perf_ctrs(cpunum, &fb_ctrs_t1);
+	if (ret)
+		return ret;
+
+	return cppc_get_rate_from_fbctrs(cpu, fb_ctrs_t0, fb_ctrs_t1);
+}
+
 static struct cpufreq_driver cppc_cpufreq_driver = {
 	.flags = CPUFREQ_CONST_LOOPS,
 	.verify = cppc_verify_policy,
 	.target = cppc_cpufreq_set_target,
+	.get = cppc_cpufreq_get_rate,
 	.init = cppc_cpufreq_cpu_init,
 	.stop_cpu = cppc_cpufreq_stop_cpu,
 	.name = "cppc_cpufreq",
-- 
1.8.3.1
