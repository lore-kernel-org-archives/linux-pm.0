From: Sudeep Holla <sudeep.holla@arm.com>
Subject: [PATCH v6 20/20] cpufreq: scmi: add support for fast frequency
 switching
Date: Fri, 23 Feb 2018 16:23:50 +0000
Message-ID: <1519403030-21189-21-git-send-email-sudeep.holla@arm.com>
References: <1519403030-21189-1-git-send-email-sudeep.holla@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1519403030-21189-1-git-send-email-sudeep.holla@arm.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: ALKML <linux-arm-kernel@lists.infradead.org>, LKML <linux-kernel@vger.kernel.org>, DTML <devicetree@vger.kernel.org>
Cc: Alexey Klimov <klimov.linux@gmail.com>, linux-pm@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Arnd Bergmann <arnd@arndb.de>, Sudeep Holla <sudeep.holla@arm.com>
List-Id: linux-pm@vger.kernel.org

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
 drivers/cpufreq/scmi-cpufreq.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/cpufreq/scmi-cpufreq.c b/drivers/cpufreq/scmi-cpufreq.c
index 3745dc5fe2a8..ec0c58ddc1ed 100644
--- a/drivers/cpufreq/scmi-cpufreq.c
+++ b/drivers/cpufreq/scmi-cpufreq.c
@@ -69,6 +69,22 @@ scmi_cpufreq_set_target(struct cpufreq_policy *policy, unsigned int index)
 	return ret;
 }
 
+static unsigned int scmi_cpufreq_fast_switch(struct cpufreq_policy *policy,
+					     unsigned int target_freq)
+{
+	struct scmi_data *priv = policy->driver_data;
+	struct scmi_perf_ops *perf_ops = handle->perf_ops;
+
+	if (!perf_ops->freq_set(handle, priv->domain_id,
+				target_freq * 1000, true)) {
+		arch_set_freq_scale(policy->related_cpus, target_freq,
+				    policy->cpuinfo.max_freq);
+		return target_freq;
+	}
+
+	return 0;
+}
+
 static int
 scmi_get_sharing_cpus(struct device *cpu_dev, struct cpumask *cpumask)
 {
@@ -168,6 +184,7 @@ static int scmi_cpufreq_init(struct cpufreq_policy *policy)
 
 	policy->cpuinfo.transition_latency = latency;
 
+	policy->fast_switch_possible = true;
 	return 0;
 
 out_free_cpufreq_table:
@@ -206,6 +223,7 @@ static struct cpufreq_driver scmi_cpufreq_driver = {
 	.verify	= cpufreq_generic_frequency_table_verify,
 	.attr	= cpufreq_generic_attr,
 	.target_index	= scmi_cpufreq_set_target,
+	.fast_switch	= scmi_cpufreq_fast_switch,
 	.get	= scmi_cpufreq_get_rate,
 	.init	= scmi_cpufreq_init,
 	.exit	= scmi_cpufreq_exit,
-- 
2.7.4
