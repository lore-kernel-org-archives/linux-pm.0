From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH 04/17] cpufreq: merge 'if' blocks in __cpufreq_remove_dev_prepare()
Date: Fri,  2 Jan 2015 12:34:25 +0530
Message-ID: <1fff9a11bc2dae2751ae5a1125e4db059cde7ced.1420181916.git.viresh.kumar@linaro.org>
References: <cover.1420181916.git.viresh.kumar@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f41.google.com ([209.85.220.41]:52260 "EHLO
	mail-pa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750711AbbABHFK (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 2 Jan 2015 02:05:10 -0500
Received: by mail-pa0-f41.google.com with SMTP id rd3so23749659pab.28
        for <linux-pm@vger.kernel.org>; Thu, 01 Jan 2015 23:05:10 -0800 (PST)
In-Reply-To: <cover.1420181916.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1420181916.git.viresh.kumar@linaro.org>
References: <cover.1420181916.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, prarit@redhat.com, skannan@codeaurora.org, Viresh Kumar <viresh.kumar@linaro.org>

There are two 'if' blocks here, checking for !cpufreq_driver->setpolicy and
has_target(). Both are actually doing the same thing, merge them.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/cpufreq.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index 4271d68aec41..4309b075df06 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -1364,11 +1364,10 @@ static int __cpufreq_remove_dev_prepare(struct device *dev,
 			pr_err("%s: Failed to stop governor\n", __func__);
 			return ret;
 		}
-	}
 
-	if (!cpufreq_driver->setpolicy)
 		strncpy(per_cpu(cpufreq_cpu_governor, cpu),
 			policy->governor->name, CPUFREQ_NAME_LEN);
+	}
 
 	down_read(&policy->rwsem);
 	cpus = cpumask_weight(policy->cpus);
-- 
2.2.0

