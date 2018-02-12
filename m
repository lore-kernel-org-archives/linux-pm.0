From: Sudeep Holla <sudeep.holla@arm.com>
Subject: [PATCH v5 20/20] cpufreq: scmi: add support for fast frequency switching
Date: Mon, 12 Feb 2018 18:45:24 +0000
Message-ID: <1518461124-17371-21-git-send-email-sudeep.holla@arm.com>
References: <1518461124-17371-1-git-send-email-sudeep.holla@arm.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:47326 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754160AbeBLSqP (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 12 Feb 2018 13:46:15 -0500
In-Reply-To: <1518461124-17371-1-git-send-email-sudeep.holla@arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: ALKML <linux-arm-kernel@lists.infradead.org>, LKML <linux-kernel@vger.kernel.org>, DTML <devicetree@vger.kernel.org>
Cc: Sudeep Holla <sudeep.holla@arm.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Arnd Bergmann <arnd@arndb.de>, Alexey Klimov <klimov.linux@gmail.com>, linux-pm@vger.kernel.org

The cpufreq core provides option for drivers to implement fast_switch
callback which is invoked for frequency switching from interrupt context.

This patch adds support for fast_switch callback in SCMI cpufreq driver
by making use of polling based SCMI transfer. It also sets the flag
fast_switch_possible.

Cc: linux-pm@vger.kernel.org
Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
---
 drivers/cpufreq/scmi-cpufreq.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/cpufreq/scmi-cpufreq.c b/drivers/cpufreq/scmi-cpufreq.c
index d6d35f7692b3..c869c99b2142 100644
--- a/drivers/cpufreq/scmi-cpufreq.c
+++ b/drivers/cpufreq/scmi-cpufreq.c
@@ -64,6 +64,19 @@ scmi_cpufreq_set_target(struct cpufreq_policy *policy, unsigned int index)
 	return perf_ops->freq_set(handle, priv->domain_id, freq, false);
 }
 
+static unsigned int scmi_cpufreq_fast_switch(struct cpufreq_policy *policy,
+					     unsigned int target_freq)
+{
+	struct scmi_data *priv = policy->driver_data;
+	struct scmi_perf_ops *perf_ops = handle->perf_ops;
+
+	if (!perf_ops->freq_set(handle, priv->domain_id,
+				target_freq * 1000, true))
+		return target_freq;
+
+	return 0;
+}
+
 static int
 scmi_get_sharing_cpus(struct device *cpu_dev, struct cpumask *cpumask)
 {
@@ -163,6 +176,7 @@ static int scmi_cpufreq_init(struct cpufreq_policy *policy)
 
 	policy->cpuinfo.transition_latency = latency;
 
+	policy->fast_switch_possible = true;
 	return 0;
 
 out_free_cpufreq_table:
@@ -201,6 +215,7 @@ static struct cpufreq_driver scmi_cpufreq_driver = {
 	.verify	= cpufreq_generic_frequency_table_verify,
 	.attr	= cpufreq_generic_attr,
 	.target_index	= scmi_cpufreq_set_target,
+	.fast_switch	= scmi_cpufreq_fast_switch,
 	.get	= scmi_cpufreq_get_rate,
 	.init	= scmi_cpufreq_init,
 	.exit	= scmi_cpufreq_exit,
-- 
2.7.4
