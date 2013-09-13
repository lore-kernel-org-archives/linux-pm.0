From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH 017/228] cpufreq: cris: use cpufreq_table_validate_and_show()
Date: Fri, 13 Sep 2013 18:29:23 +0530
Message-ID: <004c82aa4bdb721a03b38b3b5ef5fe7ca7841773.1379063063.git.viresh.kumar@linaro.org>
References: <cover.1379063063.git.viresh.kumar@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1379063063.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1379063063.git.viresh.kumar@linaro.org>
References: <cover.1379063063.git.viresh.kumar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: rjw@sisk.pl
Cc: linaro-kernel@lists.linaro.org, patches@linaro.org, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Viresh Kumar <viresh.kumar@linaro.org>, Jesper Nilsson <jesper.nilsson@axis.com>, Mikael Starvik <starvik@axis.com>, linux-cris-kernel@axis.com
List-Id: linux-pm@vger.kernel.org

Lets use cpufreq_table_validate_and_show() instead of calling
cpufreq_frequency_table_cpuinfo() and cpufreq_frequency_table_get_attr().

Cc: Jesper Nilsson <jesper.nilsson@axis.com>
Cc: Mikael Starvik <starvik@axis.com>
Cc: linux-cris-kernel@axis.com
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/cris-artpec3-cpufreq.c | 10 +---------
 drivers/cpufreq/cris-etraxfs-cpufreq.c | 10 +---------
 2 files changed, 2 insertions(+), 18 deletions(-)

diff --git a/drivers/cpufreq/cris-artpec3-cpufreq.c b/drivers/cpufreq/cris-artpec3-cpufreq.c
index cb8276d..444fd96 100644
--- a/drivers/cpufreq/cris-artpec3-cpufreq.c
+++ b/drivers/cpufreq/cris-artpec3-cpufreq.c
@@ -76,19 +76,11 @@ static int cris_freq_target(struct cpufreq_policy *policy,
 
 static int cris_freq_cpu_init(struct cpufreq_policy *policy)
 {
-	int result;
-
 	/* cpuinfo and default policy values */
 	policy->cpuinfo.transition_latency = 1000000; /* 1ms */
 	policy->cur = cris_freq_get_cpu_frequency(0);
 
-	result = cpufreq_frequency_table_cpuinfo(policy, cris_freq_table);
-	if (result)
-		return (result);
-
-	cpufreq_frequency_table_get_attr(cris_freq_table, policy->cpu);
-
-	return 0;
+	return cpufreq_table_validate_and_show(policy, cris_freq_table);
 }
 
 
diff --git a/drivers/cpufreq/cris-etraxfs-cpufreq.c b/drivers/cpufreq/cris-etraxfs-cpufreq.c
index 72328f7..428395e 100644
--- a/drivers/cpufreq/cris-etraxfs-cpufreq.c
+++ b/drivers/cpufreq/cris-etraxfs-cpufreq.c
@@ -75,19 +75,11 @@ static int cris_freq_target(struct cpufreq_policy *policy,
 
 static int cris_freq_cpu_init(struct cpufreq_policy *policy)
 {
-	int result;
-
 	/* cpuinfo and default policy values */
 	policy->cpuinfo.transition_latency = 1000000;	/* 1ms */
 	policy->cur = cris_freq_get_cpu_frequency(0);
 
-	result = cpufreq_frequency_table_cpuinfo(policy, cris_freq_table);
-	if (result)
-		return (result);
-
-	cpufreq_frequency_table_get_attr(cris_freq_table, policy->cpu);
-
-	return 0;
+	return cpufreq_table_validate_and_show(policy, cris_freq_table);
 }
 
 static int cris_freq_cpu_exit(struct cpufreq_policy *policy)
-- 
1.7.12.rc2.18.g61b472e
