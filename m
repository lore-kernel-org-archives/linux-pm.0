From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH 33/37] cpufreq: sh: don't initialize part of policy that is set by core too
Date: Wed, 14 Aug 2013 19:02:22 +0530
Message-ID: <3248b5fa8ff398349355def086e5998d18ad0e1b.1376486714.git.viresh.kumar@linaro.org>
References: <cover.1376486713.git.viresh.kumar@linaro.org>
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <cover.1376486713.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1376486713.git.viresh.kumar@linaro.org>
References: <cover.1376486713.git.viresh.kumar@linaro.org>
Sender: linux-sh-owner@vger.kernel.org
To: rjw@sisk.pl
Cc: linaro-kernel@lists.linaro.org, patches@linaro.org, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Viresh Kumar <viresh.kumar@linaro.org>, Paul Mundt <lethal@linux-sh.org>, linux-sh@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Many common initializations of struct policy are moved to core now and hence
this driver doesn't need to do it. This patch removes such code.

Most recent of those changes is to call ->get() in the core after calling
->init().

Cc: Paul Mundt <lethal@linux-sh.org>
Cc: linux-sh@vger.kernel.org
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/sh-cpufreq.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/cpufreq/sh-cpufreq.c b/drivers/cpufreq/sh-cpufreq.c
index 91c6446..018348b 100644
--- a/drivers/cpufreq/sh-cpufreq.c
+++ b/drivers/cpufreq/sh-cpufreq.c
@@ -114,8 +114,6 @@ static int sh_cpufreq_cpu_init(struct cpufreq_policy *policy)
 		return PTR_ERR(cpuclk);
 	}
 
-	policy->cur = sh_cpufreq_get(cpu);
-
 	freq_table = cpuclk->nr_freqs ? cpuclk->freq_table : NULL;
 	if (freq_table) {
 		int result;
-- 
1.7.12.rc2.18.g61b472e

