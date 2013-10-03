From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH V2 Resend 67/92] cpufreq: sc520_freq: don't initialize part of policy that is set by core too
Date: Thu,  3 Oct 2013 20:29:01 +0530
Message-ID: <79662bb0671aa2938c852005892ddbda4fbb9ad9.1380783079.git.viresh.kumar@linaro.org>
References: <cover.1380783079.git.viresh.kumar@linaro.org>
Return-path: <cpufreq-owner@vger.kernel.org>
In-Reply-To: <cover.1380783079.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1380783079.git.viresh.kumar@linaro.org>
References: <cover.1380783079.git.viresh.kumar@linaro.org>
Sender: cpufreq-owner@vger.kernel.org
To: rjw@sisk.pl
Cc: cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, Viresh Kumar <viresh.kumar@linaro.org>
List-Id: linux-pm@vger.kernel.org

Many common initializations of struct policy are moved to core now and hence
this driver doesn't need to do it. This patch removes such code.

Most recent of those changes is to call ->get() in the core after calling
->init().

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/sc520_freq.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/cpufreq/sc520_freq.c b/drivers/cpufreq/sc520_freq.c
index 8556225..9047ab1 100644
--- a/drivers/cpufreq/sc520_freq.c
+++ b/drivers/cpufreq/sc520_freq.c
@@ -109,7 +109,6 @@ static int sc520_freq_cpu_init(struct cpufreq_policy *policy)
 
 	/* cpuinfo and default policy values */
 	policy->cpuinfo.transition_latency = 1000000; /* 1ms */
-	policy->cur = sc520_freq_get_cpu_frequency(0);
 
 	return cpufreq_table_validate_and_show(policy, sc520_freq_table);
 }
-- 
1.7.12.rc2.18.g61b472e

