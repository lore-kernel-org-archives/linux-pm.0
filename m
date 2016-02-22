From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH 3/3] cpufreq: Remove 'policy->governor_enabled'
Date: Mon, 22 Feb 2016 16:36:44 +0530
Message-ID: <71eb1afbbf5001f978d6a610fd298900d1953f91.1456139127.git.viresh.kumar@linaro.org>
References: <cover.1456139127.git.viresh.kumar@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1456139127.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1456139127.git.viresh.kumar@linaro.org>
References: <cover.1456139127.git.viresh.kumar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

The entire sequence of events (like INIT/START or STOP/EXIT) for which
cpufreq_governor() is called, is guaranteed to be protected by
policy->rwsem now.

The additional checks that were added earlier (as we were forced to drop
policy->rwsem before calling cpufreq_governor() for EXIT event), aren't
required anymore.

Over that, they weren't sufficient really. They just take care of
START/STOP events, but not INIT/EXIT and the state machine was never
maintained properly by them.

Kill the unnecessary checks and policy->governor_enabled field.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/cpufreq.c | 17 -----------------
 include/linux/cpufreq.h   |  1 -
 2 files changed, 18 deletions(-)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index fa070bf87dd8..8259e8215bc1 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -1961,17 +1961,6 @@ static int cpufreq_governor(struct cpufreq_policy *policy, unsigned int event)
 
 	pr_debug("%s: for CPU %u, event %u\n", __func__, policy->cpu, event);
 
-	if ((policy->governor_enabled && event == CPUFREQ_GOV_START)
-	    || (!policy->governor_enabled
-	    && (event == CPUFREQ_GOV_LIMITS || event == CPUFREQ_GOV_STOP))) {
-		return -EBUSY;
-	}
-
-	if (event == CPUFREQ_GOV_STOP)
-		policy->governor_enabled = false;
-	else if (event == CPUFREQ_GOV_START)
-		policy->governor_enabled = true;
-
 	ret = policy->governor->governor(policy, event);
 
 	if (!ret) {
@@ -1979,12 +1968,6 @@ static int cpufreq_governor(struct cpufreq_policy *policy, unsigned int event)
 			policy->governor->initialized++;
 		else if (event == CPUFREQ_GOV_POLICY_EXIT)
 			policy->governor->initialized--;
-	} else {
-		/* Restore original values */
-		if (event == CPUFREQ_GOV_STOP)
-			policy->governor_enabled = true;
-		else if (event == CPUFREQ_GOV_START)
-			policy->governor_enabled = false;
 	}
 
 	if (((event == CPUFREQ_GOV_POLICY_INIT) && ret) ||
diff --git a/include/linux/cpufreq.h b/include/linux/cpufreq.h
index cac3d1ba8200..a50c5b2e3bf2 100644
--- a/include/linux/cpufreq.h
+++ b/include/linux/cpufreq.h
@@ -80,7 +80,6 @@ struct cpufreq_policy {
 	unsigned int		last_policy; /* policy before unplug */
 	struct cpufreq_governor	*governor; /* see below */
 	void			*governor_data;
-	bool			governor_enabled; /* governor start/stop flag */
 	char			last_governor[CPUFREQ_NAME_LEN]; /* last governor used */
 
 	struct work_struct	update; /* if update_policy() needs to be
-- 
2.7.1.410.g6faf27b
