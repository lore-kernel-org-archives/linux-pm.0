From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH 16/17] cpufreq: remove check for cpufreq_disabled() from cpufreq_cpu_{get|put}()
Date: Fri,  2 Jan 2015 12:34:37 +0530
Message-ID: <49250a2946ff12500a5474eb9384c125b3ede23c.1420181916.git.viresh.kumar@linaro.org>
References: <cover.1420181916.git.viresh.kumar@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f44.google.com ([209.85.220.44]:47805 "EHLO
	mail-pa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750744AbbABHF4 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 2 Jan 2015 02:05:56 -0500
Received: by mail-pa0-f44.google.com with SMTP id et14so23671889pad.17
        for <linux-pm@vger.kernel.org>; Thu, 01 Jan 2015 23:05:55 -0800 (PST)
In-Reply-To: <cover.1420181916.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1420181916.git.viresh.kumar@linaro.org>
References: <cover.1420181916.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, prarit@redhat.com, skannan@codeaurora.org, Viresh Kumar <viresh.kumar@linaro.org>

In most of the cases cpufreq wouldn't be disabled and this adds unnecessary
delay for its users. In the case if cpufreq is really disabled, then the per-cpu
variable will also return NULL and things will continue working as is. Remove
this unnecessary check.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/cpufreq.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index 14d637a28dd8..62c6a0b8b0d1 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -202,9 +202,6 @@ struct cpufreq_policy *cpufreq_cpu_get(unsigned int cpu)
 	struct cpufreq_policy *policy = NULL;
 	unsigned long flags;
 
-	if (cpufreq_disabled())
-		return NULL;
-
 	if (!down_read_trylock(&cpufreq_rwsem))
 		return NULL;
 
@@ -229,9 +226,6 @@ EXPORT_SYMBOL_GPL(cpufreq_cpu_get);
 
 void cpufreq_cpu_put(struct cpufreq_policy *policy)
 {
-	if (cpufreq_disabled())
-		return;
-
 	kobject_put(&policy->kobj);
 	up_read(&cpufreq_rwsem);
 }
-- 
2.2.0

