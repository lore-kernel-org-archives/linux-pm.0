From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH 05/37] cpufreq: blackfin: don't initialize part of policy that is set by core too
Date: Wed, 14 Aug 2013 19:01:54 +0530
Message-ID: <612914b58af33ab814bed3066046aadd19bd7ec6.1376486713.git.viresh.kumar@linaro.org>
References: <cover.1376486713.git.viresh.kumar@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1376486713.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1376486713.git.viresh.kumar@linaro.org>
References: <cover.1376486713.git.viresh.kumar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: rjw@sisk.pl
Cc: linaro-kernel@lists.linaro.org, patches@linaro.org, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Viresh Kumar <viresh.kumar@linaro.org>, Steven Miao <realmz6@gmail.com>
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
index b343c7b..12528b2 100644
--- a/drivers/cpufreq/blackfin-cpufreq.c
+++ b/drivers/cpufreq/blackfin-cpufreq.c
@@ -195,7 +195,6 @@ static int __bfin_cpu_init(struct cpufreq_policy *policy)
 
 	policy->cpuinfo.transition_latency = 50000; /* 50us assumed */
 
-	policy->cur = cclk;
 	return cpufreq_table_validate_and_show(policy, bfin_freq_table);
 }
 
-- 
1.7.12.rc2.18.g61b472e
