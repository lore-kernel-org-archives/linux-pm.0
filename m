From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH 08/37] cpufreq: cris: don't initialize part of policy that is set by core too
Date: Wed, 14 Aug 2013 19:01:57 +0530
Message-ID: <7058b9f50de83553530460cc9488db0e1230ed86.1376486713.git.viresh.kumar@linaro.org>
References: <cover.1376486713.git.viresh.kumar@linaro.org>
Return-path: <cpufreq-owner@vger.kernel.org>
In-Reply-To: <cover.1376486713.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1376486713.git.viresh.kumar@linaro.org>
References: <cover.1376486713.git.viresh.kumar@linaro.org>
Sender: cpufreq-owner@vger.kernel.org
To: rjw@sisk.pl
Cc: linaro-kernel@lists.linaro.org, patches@linaro.org, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Viresh Kumar <viresh.kumar@linaro.org>, Jesper Nilsson <jesper.nilsson@axis.com>, Mikael Starvik <starvik@axis.com>, linux-cris-kernel@axis.com
List-Id: linux-pm@vger.kernel.org

Many common initializations of struct policy are moved to core now and hence
this driver doesn't need to do it. This patch removes such code.

Most recent of those changes is to call ->get() in the core after calling
->init().

Cc: Jesper Nilsson <jesper.nilsson@axis.com>
Cc: Mikael Starvik <starvik@axis.com>
Cc: linux-cris-kernel@axis.com
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/cris-artpec3-cpufreq.c | 1 -
 drivers/cpufreq/cris-etraxfs-cpufreq.c | 1 -
 2 files changed, 2 deletions(-)

diff --git a/drivers/cpufreq/cris-artpec3-cpufreq.c b/drivers/cpufreq/cris-artpec3-cpufreq.c
index 1488277..dace19d 100644
--- a/drivers/cpufreq/cris-artpec3-cpufreq.c
+++ b/drivers/cpufreq/cris-artpec3-cpufreq.c
@@ -59,7 +59,6 @@ static int cris_freq_cpu_init(struct cpufreq_policy *policy)
 {
 	/* cpuinfo and default policy values */
 	policy->cpuinfo.transition_latency = 1000000; /* 1ms */
-	policy->cur = cris_freq_get_cpu_frequency(0);
 
 	return cpufreq_table_validate_and_show(policy, cris_freq_table);
 }
diff --git a/drivers/cpufreq/cris-etraxfs-cpufreq.c b/drivers/cpufreq/cris-etraxfs-cpufreq.c
index 4e3e9c7..4d40d9df 100644
--- a/drivers/cpufreq/cris-etraxfs-cpufreq.c
+++ b/drivers/cpufreq/cris-etraxfs-cpufreq.c
@@ -59,7 +59,6 @@ static int cris_freq_cpu_init(struct cpufreq_policy *policy)
 {
 	/* cpuinfo and default policy values */
 	policy->cpuinfo.transition_latency = 1000000;	/* 1ms */
-	policy->cur = cris_freq_get_cpu_frequency(0);
 
 	return cpufreq_table_validate_and_show(policy, cris_freq_table);
 }
-- 
1.7.12.rc2.18.g61b472e

