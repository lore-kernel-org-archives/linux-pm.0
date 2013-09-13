From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH 090/228] cpufreq: call cpufreq_driver->get() after calling
 ->init()
Date: Fri, 13 Sep 2013 18:30:36 +0530
Message-ID: <65ceb79aa6cf70ee2ee64f92ffe92e43e8663c4e.1379063063.git.viresh.kumar@linaro.org>
References: <cover.1379063063.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <cover.1379063063.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1379063063.git.viresh.kumar@linaro.org>
References: <cover.1379063063.git.viresh.kumar@linaro.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: rjw@sisk.pl
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, Viresh Kumar <viresh.kumar@linaro.org>, patches@linaro.org, linux-kernel@vger.kernel.org, cpufreq@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

Almost all drivers set policy->cur with current cpu frequency in their ->init()
part. This can be done for all of them at core level and so they wouldn't need
to do it.

This patch adds supporting code in cpufreq core for calling get() after we have
called init() for a policy.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/cpufreq.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index c7274e6..1e6b602 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -1081,6 +1081,14 @@ static int __cpufreq_add_dev(struct device *dev, struct subsys_interface *sif,
 		goto err_set_policy_cpu;
 	}
 
+	if (cpufreq_driver->get) {
+		policy->cur = cpufreq_driver->get(policy->cpu);
+		if (!policy->cur) {
+			pr_err("%s: ->get() failed\n", __func__);
+			goto err_get_freq;
+		}
+	}
+
 	/* related cpus should atleast have policy->cpus */
 	cpumask_or(policy->related_cpus, policy->related_cpus, policy->cpus);
 
@@ -1135,6 +1143,9 @@ err_out_unregister:
 		per_cpu(cpufreq_cpu_data, j) = NULL;
 	write_unlock_irqrestore(&cpufreq_driver_lock, flags);
 
+err_get_freq:
+	if (cpufreq_driver->exit)
+		cpufreq_driver->exit(policy);
 err_set_policy_cpu:
 	cpufreq_policy_free(policy);
 nomem_out:
-- 
1.7.12.rc2.18.g61b472e
