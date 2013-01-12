From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH 1/5] cpufreq: Manage only online cpus
Date: Sat, 12 Jan 2013 10:44:38 +0530
Message-ID: <1765dc7c08c5cc2fccbdfba8e63492ff4a183a81.1357967566.git.viresh.kumar@linaro.org>
References: <cover.1357967566.git.viresh.kumar@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pb0-f44.google.com ([209.85.160.44]:55976 "EHLO
	mail-pb0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752639Ab3ALFO7 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sat, 12 Jan 2013 00:14:59 -0500
Received: by mail-pb0-f44.google.com with SMTP id uo1so1308057pbc.17
        for <linux-pm@vger.kernel.org>; Fri, 11 Jan 2013 21:14:58 -0800 (PST)
In-Reply-To: <cover.1357967566.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1357967566.git.viresh.kumar@linaro.org>
References: <cover.1357967566.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rjw@sisk.pl
Cc: cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linaro-dev@lists.linaro.org, patches@linaro.org, Viresh Kumar <viresh.kumar@linaro.org>

cpufreq core doesn't manage offline cpus and if driver->init() has returned
mask including offline cpus, it may result in unwanted behavior by cpufreq core
or governors.

We need to get only online cpus in this mask. There are two places to fix this
mask, cpufreq core and cpufreq driver. It makes sense to do this at common place
and hence is done in core.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/cpufreq.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index 1f93dbd..de99517 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -970,6 +970,13 @@ static int cpufreq_add_dev(struct device *dev, struct subsys_interface *sif)
 		pr_debug("initialization failed\n");
 		goto err_unlock_policy;
 	}
+
+	/*
+	 * affected cpus must always be the one, which are online. We aren't
+	 * managing offline cpus here.
+	 */
+	cpumask_and(policy->cpus, policy->cpus, cpu_online_mask);
+
 	policy->user_policy.min = policy->min;
 	policy->user_policy.max = policy->max;
 
-- 
1.7.12.rc2.18.g61b472e

