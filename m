From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH V2 Resend 40/92] cpufreq: blackfin: don't initialize part of policy that is set by core too
Date: Thu,  3 Oct 2013 20:28:34 +0530
Message-ID: <f3330cbded7a496a59993005da6b2ad4a5d00342.1380783079.git.viresh.kumar@linaro.org>
References: <cover.1380783079.git.viresh.kumar@linaro.org>
Return-path: <cpufreq-owner@vger.kernel.org>
In-Reply-To: <cover.1380783079.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1380783079.git.viresh.kumar@linaro.org>
References: <cover.1380783079.git.viresh.kumar@linaro.org>
Sender: cpufreq-owner@vger.kernel.org
To: rjw@sisk.pl
Cc: cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, Viresh Kumar <viresh.kumar@linaro.org>, Steven Miao <realmz6@gmail.com>
List-Id: linux-pm@vger.kernel.org

Many common initializations of struct policy are moved to core now and hence
this driver doesn't need to do it. This patch removes such code.

Most recent of those changes is to call ->get() in the core after calling
->init().

Cc: Steven Miao <realmz6@gmail.com>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/blackfin-cpufreq.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/cpufreq/blackfin-cpufreq.c b/drivers/cpufreq/blackfin-cpufreq.c
index 48888cf..0bc9e8c 100644
--- a/drivers/cpufreq/blackfin-cpufreq.c
+++ b/drivers/cpufreq/blackfin-cpufreq.c
@@ -204,7 +204,6 @@ static int __bfin_cpu_init(struct cpufreq_policy *policy)
 
 	policy->cpuinfo.transition_latency = 50000; /* 50us assumed */
 
-	policy->cur = cclk;
 	return cpufreq_table_validate_and_show(policy, bfin_freq_table);
 }
 
-- 
1.7.12.rc2.18.g61b472e

