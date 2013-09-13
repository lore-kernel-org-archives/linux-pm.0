From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH 189/228] cpufreq: dbx500: remove calls to cpufreq_notify_transition()
Date: Fri, 13 Sep 2013 18:32:15 +0530
Message-ID: <6fbcd6c0c6799d62f379b7c02ef08a93714b75a9.1379063063.git.viresh.kumar@linaro.org>
References: <cover.1379063063.git.viresh.kumar@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f52.google.com ([209.85.220.52]:54871 "EHLO
	mail-pa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932109Ab3IMNZa (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 13 Sep 2013 09:25:30 -0400
Received: by mail-pa0-f52.google.com with SMTP id kq13so2508084pab.25
        for <linux-pm@vger.kernel.org>; Fri, 13 Sep 2013 06:25:30 -0700 (PDT)
In-Reply-To: <cover.1379063063.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1379063063.git.viresh.kumar@linaro.org>
References: <cover.1379063063.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rjw@sisk.pl
Cc: linaro-kernel@lists.linaro.org, patches@linaro.org, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Viresh Kumar <viresh.kumar@linaro.org>, Linus Walleij <linus.walleij@linaro.org>

Most of the drivers do following in their ->target_index() routines:

	struct cpufreq_freqs freqs;
	freqs.old = old freq...
	freqs.new = new freq...

	cpufreq_notify_transition(policy, &freqs, CPUFREQ_PRECHANGE);

	/* Change rate here */

	cpufreq_notify_transition(policy, &freqs, CPUFREQ_POSTCHANGE);

This is replicated over all cpufreq drivers today and there doesn't exists a
good enough reason why this shouldn't be moved to cpufreq core instead.

Earlier patches have added support in cpufreq core to do cpufreq notification on
frequency change, this one removes it from this driver.

Some related minor cleanups are also done along with it.

Cc: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/dbx500-cpufreq.c | 22 +---------------------
 1 file changed, 1 insertion(+), 21 deletions(-)

diff --git a/drivers/cpufreq/dbx500-cpufreq.c b/drivers/cpufreq/dbx500-cpufreq.c
index 238b169..0e67ab9 100644
--- a/drivers/cpufreq/dbx500-cpufreq.c
+++ b/drivers/cpufreq/dbx500-cpufreq.c
@@ -22,28 +22,8 @@ static struct clk *armss_clk;
 static int dbx500_cpufreq_target(struct cpufreq_policy *policy,
 				unsigned int index)
 {
-	struct cpufreq_freqs freqs;
-	int ret;
-
-	freqs.old = policy->cur;
-	freqs.new = freq_table[index].frequency;
-
-	/* pre-change notification */
-	cpufreq_notify_transition(policy, &freqs, CPUFREQ_PRECHANGE);
-
 	/* update armss clk frequency */
-	ret = clk_set_rate(armss_clk, freqs.new * 1000);
-
-	if (ret) {
-		pr_err("dbx500-cpufreq: Failed to set armss_clk to %d Hz: error %d\n",
-		       freqs.new * 1000, ret);
-		freqs.new = freqs.old;
-	}
-
-	/* post change notification */
-	cpufreq_notify_transition(policy, &freqs, CPUFREQ_POSTCHANGE);
-
-	return ret;
+	return clk_set_rate(armss_clk, freq_table[index].frequency * 1000);
 }
 
 static unsigned int dbx500_cpufreq_getspeed(unsigned int cpu)
-- 
1.7.12.rc2.18.g61b472e

