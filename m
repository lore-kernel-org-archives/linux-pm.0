From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH 09/34] cpufreq: dbx500: remove calls to cpufreq_notify_transition()
Date: Fri, 16 Aug 2013 07:55:06 +0530
Message-ID: <6ce2b2cfc0c51c27ab27c4b4ff6d446debfd4dd9.1376619363.git.viresh.kumar@linaro.org>
References: <cover.1376619363.git.viresh.kumar@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1376619363.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1376619363.git.viresh.kumar@linaro.org>
References: <cover.1376619363.git.viresh.kumar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: rjw@sisk.pl
Cc: linaro-kernel@lists.linaro.org, patches@linaro.org, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Viresh Kumar <viresh.kumar@linaro.org>, Linus Walleij <linus.walleij@linaro.org>
List-Id: linux-pm@vger.kernel.org

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
index d6d6b8c..060430c 100644
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
