From: Sai Gurrappadi <sgurrappadi@nvidia.com>
Subject: [PATCHv2] cpufreq: Fix GOV_LIMITS handling for the userspace governor
Date: Fri, 29 Apr 2016 14:44:37 -0700
Message-ID: <5723D5C5.9030900@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from hqemgate16.nvidia.com ([216.228.121.65]:13051 "EHLO
	hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751303AbcD2Vqg (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 29 Apr 2016 17:46:36 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rafael.j.wysocki@intel.com, viresh.kumar@linaro.org
Cc: linux-pm@vger.kernel.org, MLongnecker@nvidia.com

Currently, the userspace governor only updates frequency on GOV_LIMITS
if policy->cur falls outside policy->{min/max}. However, it is also
necessary to update current frequency on GOV_LIMITS to match the user
requested value if it can be achieved within the new policy->{max/min}.

This was previously the behaviour in the governor until commit d1922f0
("cpufreq: Simplify userspace governor") which incorrectly assumed that
policy->cur == user requested frequency via scaling_setspeed. This won't
be true if the user requested frequency falls outside policy->{min/max}.
Ex: a temporary thermal cap throttled the user requested frequency.

Fix this by storing the user requested frequency in a seperate variable.
The governor will then try to achieve this request on every GOV_LIMITS
change.

Fixes: d1922f02562f ("cpufreq: Simplify userspace governor")

Signed-off-by: Sai Gurrappadi <sgurrappadi@nvidia.com>
---

Changes in v2:
- Used policy->governor_data rather than using a per-cpu variable

 drivers/cpufreq/cpufreq_userspace.c | 43 ++++++++++++++++++++++++++++++++-----
 1 file changed, 38 insertions(+), 5 deletions(-)

diff --git a/drivers/cpufreq/cpufreq_userspace.c
b/drivers/cpufreq/cpufreq_userspace.c
index 4d16f45..9f3dec9 100644
--- a/drivers/cpufreq/cpufreq_userspace.c
+++ b/drivers/cpufreq/cpufreq_userspace.c
@@ -17,6 +17,7 @@
 #include <linux/init.h>
 #include <linux/module.h>
 #include <linux/mutex.h>
+#include <linux/slab.h>

 static DEFINE_PER_CPU(unsigned int, cpu_is_managed);
 static DEFINE_MUTEX(userspace_mutex);
@@ -31,6 +32,7 @@ static DEFINE_MUTEX(userspace_mutex);
 static int cpufreq_set(struct cpufreq_policy *policy, unsigned int freq)
 {
 	int ret = -EINVAL;
+	unsigned int *setspeed = policy->governor_data;

 	pr_debug("cpufreq_set for cpu %u, freq %u kHz\n", policy->cpu, freq);

@@ -38,6 +40,8 @@ static int cpufreq_set(struct cpufreq_policy *policy,
unsigned int freq)
 	if (!per_cpu(cpu_is_managed, policy->cpu))
 		goto err;

+	*setspeed = freq;
+
 	ret = __cpufreq_driver_target(policy, freq, CPUFREQ_RELATION_L);
  err:
 	mutex_unlock(&userspace_mutex);
@@ -49,19 +53,45 @@ static ssize_t show_speed(struct cpufreq_policy *policy,
char *buf)
 	return sprintf(buf, "%u\n", policy->cur);
 }

+static int cpufreq_userspace_policy_init(struct cpufreq_policy *policy)
+{
+	unsigned int *setspeed;
+
+	setspeed = kzalloc(sizeof(*setspeed), GFP_KERNEL);
+	if (!setspeed)
+		return -ENOMEM;
+
+	policy->governor_data = setspeed;
+	return 0;
+}
+
 static int cpufreq_governor_userspace(struct cpufreq_policy *policy,
 				   unsigned int event)
 {
+	unsigned int *setspeed = policy->governor_data;
 	unsigned int cpu = policy->cpu;
 	int rc = 0;

+	if (event == CPUFREQ_GOV_POLICY_INIT)
+		return cpufreq_userspace_policy_init(policy);
+
+	if (!setspeed)
+		return -EINVAL;
+
 	switch (event) {
+	case CPUFREQ_GOV_POLICY_EXIT:
+		mutex_lock(&userspace_mutex);
+		policy->governor_data = NULL;
+		kfree(setspeed);
+		mutex_unlock(&userspace_mutex);
+		break;
 	case CPUFREQ_GOV_START:
 		BUG_ON(!policy->cur);
 		pr_debug("started managing cpu %u\n", cpu);

 		mutex_lock(&userspace_mutex);
 		per_cpu(cpu_is_managed, cpu) = 1;
+		*setspeed = policy->cur;
 		mutex_unlock(&userspace_mutex);
 		break;
 	case CPUFREQ_GOV_STOP:
@@ -69,20 +99,23 @@ static int cpufreq_governor_userspace(struct
cpufreq_policy *policy,

 		mutex_lock(&userspace_mutex);
 		per_cpu(cpu_is_managed, cpu) = 0;
+		*setspeed = 0;
 		mutex_unlock(&userspace_mutex);
 		break;
 	case CPUFREQ_GOV_LIMITS:
 		mutex_lock(&userspace_mutex);
-		pr_debug("limit event for cpu %u: %u - %u kHz, currently %u kHz\n",
-			cpu, policy->min, policy->max,
-			policy->cur);
+		pr_debug("limit event for cpu %u: %u - %u kHz, currently %u kHz, last set
to %u kHz\n",
+			cpu, policy->min, policy->max, policy->cur, *setspeed);

-		if (policy->max < policy->cur)
+		if (policy->max < *setspeed)
 			__cpufreq_driver_target(policy, policy->max,
 						CPUFREQ_RELATION_H);
-		else if (policy->min > policy->cur)
+		else if (policy->min > *setspeed)
 			__cpufreq_driver_target(policy, policy->min,
 						CPUFREQ_RELATION_L);
+		else
+			__cpufreq_driver_target(policy, *setspeed,
+						CPUFREQ_RELATION_L);
 		mutex_unlock(&userspace_mutex);
 		break;
 	}
-- 
2.1.4
