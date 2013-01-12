From: Viresh Kumar <viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: [PATCH 2/5] cpufreq: Notify governors when cpus are hot-[un]plugged
Date: Sat, 12 Jan 2013 10:44:39 +0530
Message-ID: <6def83ce4bb23170d9c4fdf7a7105b90d3cb73b7.1357967566.git.viresh.kumar@linaro.org>
References: <cover.1357967566.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linaro-dev-bounces-cunTk1MwBs8s++Sfvej+rw@public.gmane.org>
In-Reply-To: <cover.1357967566.git.viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
In-Reply-To: <cover.1357967566.git.viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
References: <cover.1357967566.git.viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
List-Unsubscribe: <http://lists.linaro.org/mailman/options/linaro-dev>,
	<mailto:linaro-dev-request-cunTk1MwBs8s++Sfvej+rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linaro.org/pipermail/linaro-dev>
List-Post: <mailto:linaro-dev-cunTk1MwBs8s++Sfvej+rw@public.gmane.org>
List-Help: <mailto:linaro-dev-request-cunTk1MwBs8s++Sfvej+rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.linaro.org/mailman/listinfo/linaro-dev>,
	<mailto:linaro-dev-request-cunTk1MwBs8s++Sfvej+rw@public.gmane.org?subject=subscribe>
Sender: linaro-dev-bounces-cunTk1MwBs8s++Sfvej+rw@public.gmane.org
Errors-To: linaro-dev-bounces-cunTk1MwBs8s++Sfvej+rw@public.gmane.org
To: rjw-KKrjLPT3xs0@public.gmane.org
Cc: linaro-dev-cunTk1MwBs8s++Sfvej+rw@public.gmane.org, patches-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, Viresh Kumar <viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, cpufreq-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-pm@vger.kernel.org

Because cpufreq core and governors worry only about the online cpus, if a cpu is
hot [un]plugged, we must notify governors about it, otherwise be ready to expect
something unexpected.

We already have notifiers in the form of CPUFREQ_GOV_START/CPUFREQ_GOV_STOP, we
just need to call them now.

Signed-off-by: Viresh Kumar <viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
---
 drivers/cpufreq/cpufreq.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index de99517..a0a33bd 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -751,11 +751,16 @@ static int cpufreq_add_dev_policy(unsigned int cpu,
 				return -EBUSY;
 			}
 
+			__cpufreq_governor(managed_policy, CPUFREQ_GOV_STOP);
+
 			spin_lock_irqsave(&cpufreq_driver_lock, flags);
 			cpumask_copy(managed_policy->cpus, policy->cpus);
 			per_cpu(cpufreq_cpu_data, cpu) = managed_policy;
 			spin_unlock_irqrestore(&cpufreq_driver_lock, flags);
 
+			__cpufreq_governor(managed_policy, CPUFREQ_GOV_START);
+			__cpufreq_governor(managed_policy, CPUFREQ_GOV_LIMITS);
+
 			pr_debug("CPU already managed, adding link\n");
 			ret = sysfs_create_link(&dev->kobj,
 						&managed_policy->kobj,
@@ -1066,8 +1071,13 @@ static int __cpufreq_remove_dev(struct device *dev, struct subsys_interface *sif
 	 */
 	if (unlikely(cpu != data->cpu)) {
 		pr_debug("removing link\n");
+		__cpufreq_governor(data, CPUFREQ_GOV_STOP);
 		cpumask_clear_cpu(cpu, data->cpus);
 		spin_unlock_irqrestore(&cpufreq_driver_lock, flags);
+
+		__cpufreq_governor(data, CPUFREQ_GOV_START);
+		__cpufreq_governor(data, CPUFREQ_GOV_LIMITS);
+
 		kobj = &dev->kobj;
 		cpufreq_cpu_put(data);
 		unlock_policy_rwsem_write(cpu);
-- 
1.7.12.rc2.18.g61b472e
