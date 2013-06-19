From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH 04/13] cpufreq: dbx500: call CPUFREQ_POSTCHANGE notfier in error cases
Date: Wed, 19 Jun 2013 14:22:58 +0530
Message-ID: <f88ce5f93929a780ff63df1fc73c03a0703b2af0.1371630975.git.viresh.kumar@linaro.org>
References: <cover.1371630975.git.viresh.kumar@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f54.google.com ([209.85.220.54]:48002 "EHLO
	mail-pa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934410Ab3FSIyQ (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 19 Jun 2013 04:54:16 -0400
Received: by mail-pa0-f54.google.com with SMTP id kx10so4942720pab.13
        for <linux-pm@vger.kernel.org>; Wed, 19 Jun 2013 01:54:16 -0700 (PDT)
In-Reply-To: <cover.1371630975.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1371630975.git.viresh.kumar@linaro.org>
References: <cover.1371630975.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rjw@sisk.pl
Cc: linaro-kernel@lists.linaro.org, patches@linaro.org, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, robin.randhawa@arm.com, Steve.Bannister@arm.com, Liviu.Dudau@arm.com, charles.garcia-tobin@arm.com, arvind.chauhan@arm.com, dave.martin@arm.com, Viresh Kumar <viresh.kumar@linaro.org>, Linus Walleij <linus.walleij@linaro.org>

PRECHANGE and POSTCHANGE notifiers must be called in groups, i.e either both
should be called or both shouldn't be.

In case we have started PRECHANGE notifier and found an error, we must call
POSTCHANGE notifier with freqs.new = freqs.old to guarantee that sequence of
calling notifiers is complete.

This patch fixes it.

Cc: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/dbx500-cpufreq.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/cpufreq/dbx500-cpufreq.c b/drivers/cpufreq/dbx500-cpufreq.c
index 6ec6539..1fdb02b 100644
--- a/drivers/cpufreq/dbx500-cpufreq.c
+++ b/drivers/cpufreq/dbx500-cpufreq.c
@@ -57,13 +57,13 @@ static int dbx500_cpufreq_target(struct cpufreq_policy *policy,
 	if (ret) {
 		pr_err("dbx500-cpufreq: Failed to set armss_clk to %d Hz: error %d\n",
 		       freqs.new * 1000, ret);
-		return ret;
+		freqs.new = freqs.old;
 	}
 
 	/* post change notification */
 	cpufreq_notify_transition(policy, &freqs, CPUFREQ_POSTCHANGE);
 
-	return 0;
+	return ret;
 }
 
 static unsigned int dbx500_cpufreq_getspeed(unsigned int cpu)
-- 
1.7.12.rc2.18.g61b472e

