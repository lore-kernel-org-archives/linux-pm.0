From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH 1/6] cpufreq: Don't check for max_transition_latency
Date: Thu, 29 Jun 2017 16:29:04 +0530
Message-ID: <9924a30ffcce1b83fd6b3d199753a039a1d6f5ef.1498733506.git.viresh.kumar@linaro.org>
References: <cover.1498733506.git.viresh.kumar@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pg0-f50.google.com ([74.125.83.50]:36143 "EHLO
        mail-pg0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752440AbdF2K7R (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 29 Jun 2017 06:59:17 -0400
Received: by mail-pg0-f50.google.com with SMTP id u62so46261953pgb.3
        for <linux-pm@vger.kernel.org>; Thu, 29 Jun 2017 03:59:17 -0700 (PDT)
In-Reply-To: <cover.1498733506.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1498733506.git.viresh.kumar@linaro.org>
References: <cover.1498733506.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>
Cc: linux-pm@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, linux-kernel@vger.kernel.org

This check is there only for drivers that set transition_latency to
CPUFREQ_ETERNAL. And the "max_transition_latency" field is only set for
ondemand and conservative governors (i.e. This code doesn't run for
schedutil governor).

With CPUFREQ_ETERNAL, transition latency becomes around 4 seconds (yeah
its practically impossible). But even then there is nothing particular
in the governor's code that will not function if the latency is over
10ms (TRANSITION_LATENCY_LIMIT). Why disable use of the governor
completely ?

And if its about falling back to the performance governor for such
platforms, then we aren't doing the same for schedutil governor.

This patch get rids of this particular check and let platforms decide if
they want to use legacy governors or not.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/cpufreq.c | 14 --------------
 include/linux/cpufreq.h   |  3 ---
 2 files changed, 17 deletions(-)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index 6e7424d12de9..34dbbf3122c8 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -1988,20 +1988,6 @@ static int cpufreq_init_governor(struct cpufreq_policy *policy)
 	if (!policy->governor)
 		return -EINVAL;
 
-	if (policy->governor->max_transition_latency &&
-	    policy->cpuinfo.transition_latency >
-	    policy->governor->max_transition_latency) {
-		struct cpufreq_governor *gov = cpufreq_fallback_governor();
-
-		if (gov) {
-			pr_warn("%s governor failed, too long transition latency of HW, fallback to %s governor\n",
-				policy->governor->name, gov->name);
-			policy->governor = gov;
-		} else {
-			return -EINVAL;
-		}
-	}
-
 	if (!try_module_get(policy->governor->owner))
 		return -EINVAL;
 
diff --git a/include/linux/cpufreq.h b/include/linux/cpufreq.h
index 905117bd5012..0818bdc3ebf2 100644
--- a/include/linux/cpufreq.h
+++ b/include/linux/cpufreq.h
@@ -487,9 +487,6 @@ static inline unsigned long cpufreq_scale(unsigned long old, u_int div,
  * polling frequency is 1000 times the transition latency of the processor. The
  * ondemand governor will work on any processor with transition latency <= 10ms,
  * using appropriate sampling rate.
- *
- * For CPUs with transition latency > 10ms (mostly drivers with CPUFREQ_ETERNAL)
- * the ondemand governor will not work. All times here are in us (microseconds).
  */
 #define MIN_SAMPLING_RATE_RATIO		(2)
 #define LATENCY_MULTIPLIER		(1000)
-- 
2.13.0.71.gd7076ec9c9cb
