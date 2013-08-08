From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH 29/35] cpufreq: s5pv210: use cpufreq_table_validate_and_show()
Date: Thu,  8 Aug 2013 19:18:31 +0530
Message-ID: <2f893d48637b41518ee16040735dbc984700cb91.1375964117.git.viresh.kumar@linaro.org>
References: <cover.1375964117.git.viresh.kumar@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1375964117.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1375964117.git.viresh.kumar@linaro.org>
References: <cover.1375964117.git.viresh.kumar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: rjw@sisk.pl
Cc: linaro-kernel@lists.linaro.org, patches@linaro.org, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Viresh Kumar <viresh.kumar@linaro.org>, Kukjin Kim <kgene.kim@samsung.com>
List-Id: linux-pm@vger.kernel.org

Lets use cpufreq_table_validate_and_show() instead of calling
cpufreq_frequency_table_cpuinfo() and cpufreq_frequency_table_get_attr().

Cc: Kukjin Kim <kgene.kim@samsung.com>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/s5pv210-cpufreq.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/cpufreq/s5pv210-cpufreq.c b/drivers/cpufreq/s5pv210-cpufreq.c
index 5c77570..c266a7e 100644
--- a/drivers/cpufreq/s5pv210-cpufreq.c
+++ b/drivers/cpufreq/s5pv210-cpufreq.c
@@ -553,11 +553,9 @@ static int __init s5pv210_cpu_init(struct cpufreq_policy *policy)
 
 	policy->cur = policy->min = policy->max = s5pv210_getspeed(0);
 
-	cpufreq_frequency_table_get_attr(s5pv210_freq_table, policy->cpu);
-
 	policy->cpuinfo.transition_latency = 40000;
 
-	return cpufreq_frequency_table_cpuinfo(policy, s5pv210_freq_table);
+	return cpufreq_table_validate_and_show(policy, s5pv210_freq_table);
 
 out_dmc1:
 	clk_put(dmc0_clk);
-- 
1.7.12.rc2.18.g61b472e
