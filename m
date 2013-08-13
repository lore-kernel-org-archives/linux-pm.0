From: tianyu.lan@intel.com
Subject: [PATCH] Thermal/cpu_cooling: Return directly for the cpu out of allowed_cpus in the cpufreq_thermal_notifier()
Date: Tue, 13 Aug 2013 10:07:28 +0800
Message-ID: <1376359648-5749-1-git-send-email-tianyu.lan@intel.com>
Return-path: <cpufreq-owner@vger.kernel.org>
Sender: cpufreq-owner@vger.kernel.org
To: rjw@sisk.pl, lenb@kernel.org
Cc: Lan Tianyu <tianyu.lan@intel.com>, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

From: Lan Tianyu <tianyu.lan@intel.com>

cpufreq_thermal_notifier() is to change the cpu's cpufreq in the allowed_cpus mask
when associated thermal-cpufreq cdev's cooling state is changed. It's a cpufreq policy
notifier handler and it will be triggered even if those cpus out of allowed_cpus has
changed freq policy.

cpufreq_thermal_notifier() checks the policy->cpu. If it belongs to allowed_cpus,
change max_freq(default to 0) to the desire cpufreq value and pass 0 and max_freq
to cpufreq_verify_within_limits() as cpufreq scope. But if not, do nothing and
max_freq will remain 0. This will cause the cpufreq scope to become 0~0. This
is not right. This patch is to return directly after finding cpu not belonging
to allowed_cpus.

Signed-off-by: Lan Tianyu <tianyu.lan@intel.com>
---
 drivers/thermal/cpu_cooling.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/thermal/cpu_cooling.c b/drivers/thermal/cpu_cooling.c
index 82e15db..5b3744e 100644
--- a/drivers/thermal/cpu_cooling.c
+++ b/drivers/thermal/cpu_cooling.c
@@ -322,6 +322,8 @@ static int cpufreq_thermal_notifier(struct notifier_block *nb,
 
 	if (cpumask_test_cpu(policy->cpu, &notify_device->allowed_cpus))
 		max_freq = notify_device->cpufreq_val;
+	else
+		return 0;
 
 	/* Never exceed user_policy.max */
 	if (max_freq > policy->user_policy.max)
-- 
1.8.4.rc0.1.g8f6a3e5.dirty

