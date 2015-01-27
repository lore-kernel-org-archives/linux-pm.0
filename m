From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH 07/18] cpufreq: Drop (now) useless check 'cpu > nr_cpu_ids'
Date: Tue, 27 Jan 2015 14:06:13 +0530
Message-ID: <0b79fabc34316fe1e38c9cbe4750bd68ae65b03b.1422346933.git.viresh.kumar@linaro.org>
References: <cover.1422346933.git.viresh.kumar@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pd0-f180.google.com ([209.85.192.180]:59221 "EHLO
	mail-pd0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757840AbbA0IhI (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 27 Jan 2015 03:37:08 -0500
Received: by mail-pd0-f180.google.com with SMTP id ft15so17535171pdb.11
        for <linux-pm@vger.kernel.org>; Tue, 27 Jan 2015 00:37:07 -0800 (PST)
In-Reply-To: <cover.1422346933.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1422346933.git.viresh.kumar@linaro.org>
References: <cover.1422346933.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, sboyd@codeaurora.org, prarit@redhat.com, skannan@codeaurora.org, Viresh Kumar <viresh.kumar@linaro.org>

Earlier we used to find the 'policy' belonging to a cpu with the help of a
per-cpu variable. And if 'cpu' passed to cpufreq_cpu_get() is bigger than
'nr_cpu_ids', it would have caused unpredictable issues as the per-cpu variable
wouldn't have covered that value of 'cpu'. And so we had this check.

We traverse active-policy list to find policy for a cpu now. Even if 'cpu'
passed to cpufreq_cpu_get() is an invalid number (i.e. greater than nr_cpu_ids),
we will be able to manage it without any unpredictable behavior.

And so this check isn't required anymore. Get rid of it.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/cpufreq.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index 7f947287ba46..d9528046f651 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -172,9 +172,6 @@ struct cpufreq_policy *cpufreq_cpu_get(unsigned int cpu)
 	struct cpufreq_policy *policy = NULL;
 	unsigned long flags;
 
-	if (cpu >= nr_cpu_ids)
-		return NULL;
-
 	if (!down_read_trylock(&cpufreq_rwsem))
 		return NULL;
 
-- 
2.3.0.rc0.44.ga94655d

