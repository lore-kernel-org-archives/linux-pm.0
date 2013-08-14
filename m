From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH 09/37] cpufreq: davinci: don't initialize part of policy that is set by core too
Date: Wed, 14 Aug 2013 19:01:58 +0530
Message-ID: <ad1a845cea78027fc153d47e2851cb935c4d77df.1376486713.git.viresh.kumar@linaro.org>
References: <cover.1376486713.git.viresh.kumar@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pd0-f182.google.com ([209.85.192.182]:56112 "EHLO
	mail-pd0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757871Ab3HNNdv (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 14 Aug 2013 09:33:51 -0400
Received: by mail-pd0-f182.google.com with SMTP id r10so5733184pdi.27
        for <linux-pm@vger.kernel.org>; Wed, 14 Aug 2013 06:33:51 -0700 (PDT)
In-Reply-To: <cover.1376486713.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1376486713.git.viresh.kumar@linaro.org>
References: <cover.1376486713.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rjw@sisk.pl
Cc: linaro-kernel@lists.linaro.org, patches@linaro.org, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Viresh Kumar <viresh.kumar@linaro.org>, Sekhar Nori <nsekhar@ti.com>

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
index 822100b..07ea6c0 100644
--- a/drivers/cpufreq/davinci-cpufreq.c
+++ b/drivers/cpufreq/davinci-cpufreq.c
@@ -128,8 +128,6 @@ static int davinci_cpu_init(struct cpufreq_policy *policy)
 			return result;
 	}
 
-	policy->cur = davinci_getspeed(0);
-
 	result = cpufreq_table_validate_and_show(policy, freq_table);
 	if (result) {
 		pr_err("%s: cpufreq_table_validate_and_show() failed",
-- 
1.7.12.rc2.18.g61b472e

