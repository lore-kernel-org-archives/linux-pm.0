From: Quentin Perret <quentin.perret@arm.com>
Subject: [PATCH] cpufreq: scmi: Fix frequency invariance in slow path
Date: Wed,  9 Jan 2019 10:42:36 +0000
Message-ID: <20190109104236.6532-1-quentin.perret@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: sudeep.holla@arm.com, rjw@rjwysocki.net, viresh.kumar@linaro.org
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, qais.yousef@arm.com, quentin.perret@arm.com, dietmar.eggemann@arm.com, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

The scmi-cpufreq driver calls the arch_set_freq_scale() callback on
frequency changes to provide scale-invariant load-tracking signals to
the scheduler. However, in the slow path, it does so while specifying
the current and max frequencies in different units, hence resulting in a
broken freq_scale factor.

Fix this by passing all frequencies in KHz, as stored in the CPUFreq
frequency table.

Fixes: 99d6bdf33877 ("cpufreq: add support for CPU DVFS based on SCMI
message protocol")
Signed-off-by: Quentin Perret <quentin.perret@arm.com>
---
 drivers/cpufreq/scmi-cpufreq.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/cpufreq/scmi-cpufreq.c b/drivers/cpufreq/scmi-cpufreq.c
index 50b1551ba894..3f0693439486 100644
--- a/drivers/cpufreq/scmi-cpufreq.c
+++ b/drivers/cpufreq/scmi-cpufreq.c
@@ -52,9 +52,9 @@ scmi_cpufreq_set_target(struct cpufreq_policy *policy, unsigned int index)
 	int ret;
 	struct scmi_data *priv = policy->driver_data;
 	struct scmi_perf_ops *perf_ops = handle->perf_ops;
-	u64 freq = policy->freq_table[index].frequency * 1000;
+	u64 freq = policy->freq_table[index].frequency;
 
-	ret = perf_ops->freq_set(handle, priv->domain_id, freq, false);
+	ret = perf_ops->freq_set(handle, priv->domain_id, freq * 1000, false);
 	if (!ret)
 		arch_set_freq_scale(policy->related_cpus, freq,
 				    policy->cpuinfo.max_freq);
-- 
2.20.1
