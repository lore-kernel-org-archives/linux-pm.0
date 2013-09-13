From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH 098/228] cpufreq: davinci: don't initialize part of policy that is set by core too
Date: Fri, 13 Sep 2013 18:30:44 +0530
Message-ID: <d5846c490ebcbb37458742f13749b3f7722a4827.1379063063.git.viresh.kumar@linaro.org>
References: <cover.1379063063.git.viresh.kumar@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pb0-f41.google.com ([209.85.160.41]:42942 "EHLO
	mail-pb0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933085Ab3IMNOg (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 13 Sep 2013 09:14:36 -0400
Received: by mail-pb0-f41.google.com with SMTP id rp2so1235530pbb.0
        for <linux-pm@vger.kernel.org>; Fri, 13 Sep 2013 06:14:36 -0700 (PDT)
In-Reply-To: <cover.1379063063.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1379063063.git.viresh.kumar@linaro.org>
References: <cover.1379063063.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rjw@sisk.pl
Cc: linaro-kernel@lists.linaro.org, patches@linaro.org, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Viresh Kumar <viresh.kumar@linaro.org>, Sekhar Nori <nsekhar@ti.com>

Many common initializations of struct policy are moved to core now and hence
this driver doesn't need to do it. This patch removes such code.

Most recent of those changes is to call ->get() in the core after calling
->init().

Cc: Sekhar Nori <nsekhar@ti.com>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/davinci-cpufreq.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/cpufreq/davinci-cpufreq.c b/drivers/cpufreq/davinci-cpufreq.c
index f228642..55cf094 100644
--- a/drivers/cpufreq/davinci-cpufreq.c
+++ b/drivers/cpufreq/davinci-cpufreq.c
@@ -136,8 +136,6 @@ static int davinci_cpu_init(struct cpufreq_policy *policy)
 			return result;
 	}
 
-	policy->cur = davinci_getspeed(0);
-
 	result = cpufreq_table_validate_and_show(policy, freq_table);
 	if (result) {
 		pr_err("%s: cpufreq_table_validate_and_show() failed",
-- 
1.7.12.rc2.18.g61b472e

