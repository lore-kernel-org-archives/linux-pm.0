From: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Subject: [PATCH 1/2] cpufreq: Fix governor start/stop race condition
Date: Wed, 02 Apr 2014 16:19:37 +0200
Message-ID: <1396448378-22487-2-git-send-email-k.kozlowski@samsung.com>
References: <1396448378-22487-1-git-send-email-k.kozlowski@samsung.com>
Return-path: <stable-owner@vger.kernel.org>
In-reply-to: <1396448378-22487-1-git-send-email-k.kozlowski@samsung.com>
Sender: stable-owner@vger.kernel.org
To: stable@vger.kernel.org, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Xiaoguang Chen <chenxg@marvell.com>, Stephen Boyd <sboyd@codeaurora.org>, rjw@rjwysocki.net, Viresh Kumar <viresh.kumar@linaro.org>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
List-Id: linux-pm@vger.kernel.org

From: Xiaoguang Chen <chenxg@marvell.com>

Cpufreq governors' stop and start operations should be carried out
in sequence.  Otherwise, there will be unexpected behavior, like in
the example below.

Suppose there are 4 CPUs and policy->cpu=CPU0, CPU1/2/3 are linked
to CPU0.  The normal sequence is:

 1) Current governor is userspace.  An application tries to set the
    governor to ondemand.  It will call __cpufreq_set_policy() in
    which it will stop the userspace governor and then start the
    ondemand governor.

 2) Current governor is userspace.  The online of CPU3 runs on CPU0.
    It will call cpufreq_add_policy_cpu() in which it will first
    stop the userspace governor, and then start it again.

If the sequence of the above two cases interleaves, it becomes:

 1) Application stops userspace governor
 2)                                  Hotplug stops userspace governor

which is a problem, because the governor shouldn't be stopped twice
in a row.  What happens next is:

 3) Application starts ondemand governor
 4)                                  Hotplug starts a governor

In step 4, the hotplug is supposed to start the userspace governor,
but now the governor has been changed by the application to ondemand,
so the ondemand governor is started once again, which is incorrect.

The solution is to prevent policy governors from being stopped
multiple times in a row.  A governor should only be stopped once for
one policy.  After it has been stopped, no more governor stop
operations should be executed.

Also add a mutex to serialize governor operations.

[rjw: Changelog.  And you owe me a beverage of my choice.]
Signed-off-by: Xiaoguang Chen <chenxg@marvell.com>
Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Cc: <stable@vger.kernel.org>
---
 drivers/cpufreq/cpufreq.c |   24 ++++++++++++++++++++++++
 include/linux/cpufreq.h   |    1 +
 2 files changed, 25 insertions(+)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index f8c28607ccd6..43cf60832468 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -49,6 +49,7 @@ static DEFINE_PER_CPU(struct cpufreq_policy *, cpufreq_cpu_data);
 static DEFINE_PER_CPU(char[CPUFREQ_NAME_LEN], cpufreq_cpu_governor);
 #endif
 static DEFINE_RWLOCK(cpufreq_driver_lock);
+static DEFINE_MUTEX(cpufreq_governor_lock);
 
 /*
  * cpu_policy_rwsem is a per CPU reader-writer semaphore designed to cure
@@ -1635,6 +1636,21 @@ static int __cpufreq_governor(struct cpufreq_policy *policy,
 
 	pr_debug("__cpufreq_governor for CPU %u, event %u\n",
 						policy->cpu, event);
+
+	mutex_lock(&cpufreq_governor_lock);
+	if ((!policy->governor_enabled && (event == CPUFREQ_GOV_STOP)) ||
+	    (policy->governor_enabled && (event == CPUFREQ_GOV_START))) {
+		mutex_unlock(&cpufreq_governor_lock);
+		return -EBUSY;
+	}
+
+	if (event == CPUFREQ_GOV_STOP)
+		policy->governor_enabled = false;
+	else if (event == CPUFREQ_GOV_START)
+		policy->governor_enabled = true;
+
+	mutex_unlock(&cpufreq_governor_lock);
+
 	ret = policy->governor->governor(policy, event);
 
 	if (!ret) {
@@ -1642,6 +1658,14 @@ static int __cpufreq_governor(struct cpufreq_policy *policy,
 			policy->governor->initialized++;
 		else if (event == CPUFREQ_GOV_POLICY_EXIT)
 			policy->governor->initialized--;
+	} else {
+		/* Restore original values */
+		mutex_lock(&cpufreq_governor_lock);
+		if (event == CPUFREQ_GOV_STOP)
+			policy->governor_enabled = true;
+		else if (event == CPUFREQ_GOV_START)
+			policy->governor_enabled = false;
+		mutex_unlock(&cpufreq_governor_lock);
 	}
 
 	/* we keep one module reference alive for
diff --git a/include/linux/cpufreq.h b/include/linux/cpufreq.h
index d93905633dc7..125719d41285 100644
--- a/include/linux/cpufreq.h
+++ b/include/linux/cpufreq.h
@@ -111,6 +111,7 @@ struct cpufreq_policy {
 	unsigned int		policy; /* see above */
 	struct cpufreq_governor	*governor; /* see below */
 	void			*governor_data;
+	bool			governor_enabled; /* governor start/stop flag */
 
 	struct work_struct	update; /* if update_policy() needs to be
 					 * called, but you're in IRQ context */
-- 
1.7.9.5
