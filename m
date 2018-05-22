From: George Cherian <george.cherian@cavium.com>
Subject: [PATCH] cpufreq / CPPC: Add cpuinfo_cur_freq support for CPPC
Date: Tue, 22 May 2018 04:42:04 -0700
Message-ID: <1526989324-4183-1-git-send-email-george.cherian@cavium.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Cc: rjw@rjwysocki.net, viresh.kumar@linaro.org, George Cherian <george.cherian@cavium.com>
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
---
 drivers/cpufreq/cppc_cpufreq.c | 44 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 44 insertions(+)

diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
index b15115a..a046915 100644
--- a/drivers/cpufreq/cppc_cpufreq.c
+++ b/drivers/cpufreq/cppc_cpufreq.c
@@ -240,10 +240,54 @@ static int cppc_cpufreq_cpu_init(struct cpufreq_policy *policy)
 	return ret;
 }
 
+static int cppc_get_rate_from_fbctrs(struct cppc_perf_fb_ctrs fb_ctrs_t0,
+				     struct cppc_perf_fb_ctrs fb_ctrs_t1)
+{
+	u64 delta_reference, delta_delivered;
+	u64 reference_perf, ratio;
+
+	reference_perf = fb_ctrs_t0.reference_perf;
+	if (fb_ctrs_t1.reference > fb_ctrs_t0.reference)
+		delta_reference = fb_ctrs_t1.reference - fb_ctrs_t0.reference;
+	else /* Counters would have wrapped-around */
+		delta_reference  = ((u64)(~((u64)0)) - fb_ctrs_t0.reference) +
+					fb_ctrs_t1.reference;
+
+	if (fb_ctrs_t1.delivered > fb_ctrs_t0.delivered)
+		delta_delivered = fb_ctrs_t1.delivered - fb_ctrs_t0.delivered;
+	else /* Counters would have wrapped-around */
+		delta_delivered  = ((u64)(~((u64)0)) - fb_ctrs_t0.delivered) +
+					fb_ctrs_t1.delivered;
+
+	if (delta_reference)  /* Check to avoid divide-by zero */
+		ratio = (delta_delivered * 1000) / delta_reference;
+	else
+		return -EINVAL;
+
+	return (reference_perf * ratio) / 1000;
+}
+
+static unsigned int cppc_cpufreq_get_rate(unsigned int cpunum)
+{
+	struct cppc_perf_fb_ctrs fb_ctrs_t0 = {0}, fb_ctrs_t1 = {0};
+	int ret;
+
+	ret = cppc_get_perf_ctrs(cpunum, &fb_ctrs_t0);
+	if (ret)
+		return ret;
+
+	ret = cppc_get_perf_ctrs(cpunum, &fb_ctrs_t1);
+	if (ret)
+		return ret;
+
+	return cppc_get_rate_from_fbctrs(fb_ctrs_t0, fb_ctrs_t1);
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
