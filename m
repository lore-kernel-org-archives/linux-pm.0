From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH 01/18] cpufreq: Drop cpufreq_disabled() check from cpufreq_cpu_{get|put}()
Date: Tue, 27 Jan 2015 14:06:07 +0530
Message-ID: <59b0050553f89e00298b585ba89d2627a0fab164.1422346933.git.viresh.kumar@linaro.org>
References: <cover.1422346933.git.viresh.kumar@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pd0-f181.google.com ([209.85.192.181]:39364 "EHLO
	mail-pd0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754034AbbA0Igp (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 27 Jan 2015 03:36:45 -0500
Received: by mail-pd0-f181.google.com with SMTP id g10so17527726pdj.12
        for <linux-pm@vger.kernel.org>; Tue, 27 Jan 2015 00:36:45 -0800 (PST)
In-Reply-To: <cover.1422346933.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1422346933.git.viresh.kumar@linaro.org>
References: <cover.1422346933.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, sboyd@codeaurora.org, prarit@redhat.com, skannan@codeaurora.org, Viresh Kumar <viresh.kumar@linaro.org>

Even if cpufreq is disabled then also the per-cpu variable will return NULL and
things will continue working as is. Remove this unnecessary check.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/cpufreq.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index ca69f42b8e1e..72990ba59fad 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -203,7 +203,7 @@ struct cpufreq_policy *cpufreq_cpu_get(unsigned int cpu)
 	struct cpufreq_policy *policy = NULL;
 	unsigned long flags;
 
-	if (cpufreq_disabled() || (cpu >= nr_cpu_ids))
+	if (cpu >= nr_cpu_ids)
 		return NULL;
 
 	if (!down_read_trylock(&cpufreq_rwsem))
@@ -230,9 +230,6 @@ EXPORT_SYMBOL_GPL(cpufreq_cpu_get);
 
 void cpufreq_cpu_put(struct cpufreq_policy *policy)
 {
-	if (cpufreq_disabled())
-		return;
-
 	kobject_put(&policy->kobj);
 	up_read(&cpufreq_rwsem);
 }
-- 
2.3.0.rc0.44.ga94655d

