From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH V2 Resend 64/92] cpufreq: s3c: don't initialize part of policy that is set by core too
Date: Thu,  3 Oct 2013 20:28:58 +0530
Message-ID: <e6532440b82f5319acdccb460ed04ef419264bc4.1380783079.git.viresh.kumar@linaro.org>
References: <cover.1380783079.git.viresh.kumar@linaro.org>
Return-path: <cpufreq-owner@vger.kernel.org>
In-Reply-To: <cover.1380783079.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1380783079.git.viresh.kumar@linaro.org>
References: <cover.1380783079.git.viresh.kumar@linaro.org>
Sender: cpufreq-owner@vger.kernel.org
To: rjw@sisk.pl
Cc: cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, Viresh Kumar <viresh.kumar@linaro.org>, Kukjin Kim <kgene.kim@samsung.com>
List-Id: linux-pm@vger.kernel.org

Many common initializations of struct policy are moved to core now and hence
this driver doesn't need to do it. This patch removes such code.

Most recent of those changes is to call ->get() in the core after calling
->init().

Cc: Kukjin Kim <kgene.kim@samsung.com>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/s3c2416-cpufreq.c | 2 --
 drivers/cpufreq/s3c24xx-cpufreq.c | 5 -----
 drivers/cpufreq/s3c64xx-cpufreq.c | 2 --
 3 files changed, 9 deletions(-)

diff --git a/drivers/cpufreq/s3c2416-cpufreq.c b/drivers/cpufreq/s3c2416-cpufreq.c
index 8c57f10..22c4c2d 100644
--- a/drivers/cpufreq/s3c2416-cpufreq.c
+++ b/drivers/cpufreq/s3c2416-cpufreq.c
@@ -476,8 +476,6 @@ static int __init s3c2416_cpufreq_driver_init(struct cpufreq_policy *policy)
 		freq++;
 	}
 
-	policy->cur = clk_get_rate(s3c_freq->armclk) / 1000;
-
 	/* Datasheet says PLL stabalisation time must be at least 300us,
 	 * so but add some fudge. (reference in LOCKCON0 register description)
 	 */
diff --git a/drivers/cpufreq/s3c24xx-cpufreq.c b/drivers/cpufreq/s3c24xx-cpufreq.c
index 027dec1..e0fbaef 100644
--- a/drivers/cpufreq/s3c24xx-cpufreq.c
+++ b/drivers/cpufreq/s3c24xx-cpufreq.c
@@ -378,11 +378,6 @@ static int s3c_cpufreq_init(struct cpufreq_policy *policy)
 	if (policy->cpu != 0)
 		return -EINVAL;
 
-	policy->cur = s3c_cpufreq_get(0);
-	policy->min = policy->cpuinfo.min_freq = 0;
-	policy->max = policy->cpuinfo.max_freq = cpu_cur.info->max.fclk / 1000;
-	policy->governor = CPUFREQ_DEFAULT_GOVERNOR;
-
 	/* feed the latency information from the cpu driver */
 	policy->cpuinfo.transition_latency = cpu_cur.info->latency;
 
diff --git a/drivers/cpufreq/s3c64xx-cpufreq.c b/drivers/cpufreq/s3c64xx-cpufreq.c
index 99fbc49..a66cfa3 100644
--- a/drivers/cpufreq/s3c64xx-cpufreq.c
+++ b/drivers/cpufreq/s3c64xx-cpufreq.c
@@ -235,8 +235,6 @@ static int s3c64xx_cpufreq_driver_init(struct cpufreq_policy *policy)
 		freq++;
 	}
 
-	policy->cur = clk_get_rate(armclk) / 1000;
-
 	/* Datasheet says PLL stabalisation time (if we were to use
 	 * the PLLs, which we don't currently) is ~300us worst case,
 	 * but add some fudge.
-- 
1.7.12.rc2.18.g61b472e

