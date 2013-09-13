From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH 011/228] cpufreq: s3cx4xx: call cpufreq_frequency_table_get_attr()
Date: Fri, 13 Sep 2013 18:29:17 +0530
Message-ID: <2636b035d75e4777a12b76534475f85f15a3b676.1379063063.git.viresh.kumar@linaro.org>
References: <cover.1379063063.git.viresh.kumar@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1379063063.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1379063063.git.viresh.kumar@linaro.org>
References: <cover.1379063063.git.viresh.kumar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: rjw@sisk.pl
Cc: linaro-kernel@lists.linaro.org, patches@linaro.org, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Viresh Kumar <viresh.kumar@linaro.org>, Kukjin Kim <kgene.kim@samsung.com>
List-Id: linux-pm@vger.kernel.org

This exposes frequency table of driver to cpufreq core and is required for core
to guess what the index for a target frequency is, when it calls
cpufreq_frequency_table_target(). And so this driver needs to expose it.

Cc: Kukjin Kim <kgene.kim@samsung.com>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/s3c24xx-cpufreq.c | 4 +++-
 drivers/cpufreq/s3c64xx-cpufreq.c | 3 +++
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/cpufreq/s3c24xx-cpufreq.c b/drivers/cpufreq/s3c24xx-cpufreq.c
index b0f343f..f2c872c 100644
--- a/drivers/cpufreq/s3c24xx-cpufreq.c
+++ b/drivers/cpufreq/s3c24xx-cpufreq.c
@@ -386,8 +386,10 @@ static int s3c_cpufreq_init(struct cpufreq_policy *policy)
 	/* feed the latency information from the cpu driver */
 	policy->cpuinfo.transition_latency = cpu_cur.info->latency;
 
-	if (ftab)
+	if (ftab) {
 		cpufreq_frequency_table_cpuinfo(policy, ftab);
+		cpufreq_frequency_table_get_attr(ftab, policy->cpu);
+	}
 
 	return 0;
 }
diff --git a/drivers/cpufreq/s3c64xx-cpufreq.c b/drivers/cpufreq/s3c64xx-cpufreq.c
index 8a72b0c..9024043 100644
--- a/drivers/cpufreq/s3c64xx-cpufreq.c
+++ b/drivers/cpufreq/s3c64xx-cpufreq.c
@@ -257,6 +257,9 @@ static int s3c64xx_cpufreq_driver_init(struct cpufreq_policy *policy)
 		       ret);
 		regulator_put(vddarm);
 		clk_put(armclk);
+	} else {
+		cpufreq_frequency_table_get_attr(s3c64xx_freq_table,
+				policy->cpu);
 	}
 
 	return ret;
-- 
1.7.12.rc2.18.g61b472e
