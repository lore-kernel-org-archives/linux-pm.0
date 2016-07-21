From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH] cpufreq: Disallow ->resolve_freq() for drivers providing ->target_index()
Date: Thu, 21 Jul 2016 14:23:30 -0700
Message-ID: <a49fb95b6186dc041f5a64f0c38d9ebc92fade83.1469136204.git.viresh.kumar@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f52.google.com ([209.85.220.52]:34206 "EHLO
	mail-pa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754415AbcGUVXi (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 21 Jul 2016 17:23:38 -0400
Received: by mail-pa0-f52.google.com with SMTP id fi15so32520529pac.1
        for <linux-pm@vger.kernel.org>; Thu, 21 Jul 2016 14:23:38 -0700 (PDT)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, steve.muckle@linaro.org, peterz@infradead.org, mingo@redhat.com, vincent.guittot@linaro.org, morten.rasmussen@arm.com, dietmar.eggemann@arm.com, Juri.Lelli@arm.com, patrick.bellasi@arm.com

The handlers provided by cpufreq core are sufficient for resolving the
frequency for drivers providing ->target_index(), as the core already
has the frequency table and so ->resolve_freq() isn't required for such
platforms.

This patch disallows drivers with ->target_index() callback to use the
->resolve_freq() callback.

Also, it fixes a potential kernel crash for drivers providing ->target()
but no ->resolve_freq().

Fixes: e3c062360870 ("cpufreq: add cpufreq_driver_resolve_freq()")
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/cpufreq.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index b696baeb249d..342bbee8d0e1 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -507,12 +507,20 @@ unsigned int cpufreq_driver_resolve_freq(struct cpufreq_policy *policy,
 {
 	target_freq = clamp_val(target_freq, policy->min, policy->max);
 	policy->cached_target_freq = target_freq;
+
+	if (cpufreq_driver->target_index) {
+		int idx;
+
+		idx = cpufreq_frequency_table_target(policy, target_freq,
+						     CPUFREQ_RELATION_L);
+		policy->cached_resolved_idx = idx;
+		return policy->freq_table[idx].frequency;
+	}
+
 	if (cpufreq_driver->resolve_freq)
 		return cpufreq_driver->resolve_freq(policy, target_freq);
-	policy->cached_resolved_idx =
-		cpufreq_frequency_table_target(policy, target_freq,
-					       CPUFREQ_RELATION_L);
-	return policy->freq_table[policy->cached_resolved_idx].frequency;
+
+	return UINT_MAX;
 }
 
 /*********************************************************************
-- 
2.7.4

