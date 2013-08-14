From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH 10/37] cpufreq: dbx500: don't initialize part of policy that is set by core too
Date: Wed, 14 Aug 2013 19:01:59 +0530
Message-ID: <5532817a232d16558111f035874e9eb74e03e81e.1376486713.git.viresh.kumar@linaro.org>
References: <cover.1376486713.git.viresh.kumar@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pd0-f169.google.com ([209.85.192.169]:47972 "EHLO
	mail-pd0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932504Ab3HNNd6 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 14 Aug 2013 09:33:58 -0400
Received: by mail-pd0-f169.google.com with SMTP id r10so6363528pdi.14
        for <linux-pm@vger.kernel.org>; Wed, 14 Aug 2013 06:33:58 -0700 (PDT)
In-Reply-To: <cover.1376486713.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1376486713.git.viresh.kumar@linaro.org>
References: <cover.1376486713.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rjw@sisk.pl
Cc: linaro-kernel@lists.linaro.org, patches@linaro.org, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Viresh Kumar <viresh.kumar@linaro.org>, Linus Walleij <linus.walleij@linaro.org>

Many common initializations of struct policy are moved to core now and hence
this driver doesn't need to do it. This patch removes such code.

Most recent of those changes is to call ->get() in the core after calling
->init().

Cc: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/dbx500-cpufreq.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/cpufreq/dbx500-cpufreq.c b/drivers/cpufreq/dbx500-cpufreq.c
index 28deaf0..d6d6b8c 100644
--- a/drivers/cpufreq/dbx500-cpufreq.c
+++ b/drivers/cpufreq/dbx500-cpufreq.c
@@ -73,11 +73,6 @@ static int dbx500_cpufreq_init(struct cpufreq_policy *policy)
 		return res;
 	}
 
-	policy->min = policy->cpuinfo.min_freq;
-	policy->max = policy->cpuinfo.max_freq;
-	policy->cur = dbx500_cpufreq_getspeed(policy->cpu);
-	policy->governor = CPUFREQ_DEFAULT_GOVERNOR;
-
 	/*
 	 * FIXME : Need to take time measurement across the target()
 	 *	   function with no/some/all drivers in the notification
-- 
1.7.12.rc2.18.g61b472e

