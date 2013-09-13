From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH 123/228] cpufreq: spear: don't initialize part of policy that is set by core too
Date: Fri, 13 Sep 2013 18:31:09 +0530
Message-ID: <4f06a09472f9a4a37dd34ff5c81a12e56121dd11.1379063063.git.viresh.kumar@linaro.org>
References: <cover.1379063063.git.viresh.kumar@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f42.google.com ([209.85.220.42]:64529 "EHLO
	mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933438Ab3IMNRf (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 13 Sep 2013 09:17:35 -0400
Received: by mail-pa0-f42.google.com with SMTP id lj1so2539931pab.1
        for <linux-pm@vger.kernel.org>; Fri, 13 Sep 2013 06:17:34 -0700 (PDT)
In-Reply-To: <cover.1379063063.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1379063063.git.viresh.kumar@linaro.org>
References: <cover.1379063063.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rjw@sisk.pl
Cc: linaro-kernel@lists.linaro.org, patches@linaro.org, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Viresh Kumar <viresh.kumar@linaro.org>, spear-devel@list.st.com

Many common initializations of struct policy are moved to core now and hence
this driver doesn't need to do it. This patch removes such code.

Most recent of those changes is to call ->get() in the core after calling
->init().

Cc: spear-devel@list.st.com
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/spear-cpufreq.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/cpufreq/spear-cpufreq.c b/drivers/cpufreq/spear-cpufreq.c
index e9657e3..aacdb61 100644
--- a/drivers/cpufreq/spear-cpufreq.c
+++ b/drivers/cpufreq/spear-cpufreq.c
@@ -180,8 +180,6 @@ static int spear_cpufreq_init(struct cpufreq_policy *policy)
 	}
 
 	policy->cpuinfo.transition_latency = spear_cpufreq.transition_latency;
-	policy->cur = spear_cpufreq_get(0);
-
 	cpumask_setall(policy->cpus);
 
 	return 0;
-- 
1.7.12.rc2.18.g61b472e

