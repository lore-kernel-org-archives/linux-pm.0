From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH V2 Resend 76/92] cpufreq: cris: use cpufreq_generic_init() routine
Date: Thu,  3 Oct 2013 20:29:10 +0530
Message-ID: <ff13d77b942899e30f688f563672df33d485c5d6.1380783079.git.viresh.kumar@linaro.org>
References: <cover.1380783079.git.viresh.kumar@linaro.org>
Return-path: <cpufreq-owner@vger.kernel.org>
In-Reply-To: <cover.1380783079.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1380783079.git.viresh.kumar@linaro.org>
References: <cover.1380783079.git.viresh.kumar@linaro.org>
Sender: cpufreq-owner@vger.kernel.org
To: rjw@sisk.pl
Cc: cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, Viresh Kumar <viresh.kumar@linaro.org>, Jesper Nilsson <jesper.nilsson@axis.com>, Mikael Starvik <starvik@axis.com>, linux-cris-kernel@axis.com
List-Id: linux-pm@vger.kernel.org

Use generic cpufreq_generic_init() routine instead of replicating the same code
here.

Cc: Jesper Nilsson <jesper.nilsson@axis.com>
Cc: Mikael Starvik <starvik@axis.com>
Cc: linux-cris-kernel@axis.com
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/cris-artpec3-cpufreq.c | 6 +-----
 drivers/cpufreq/cris-etraxfs-cpufreq.c | 5 +----
 2 files changed, 2 insertions(+), 9 deletions(-)

diff --git a/drivers/cpufreq/cris-artpec3-cpufreq.c b/drivers/cpufreq/cris-artpec3-cpufreq.c
index 4d88e4f..05fdc7e 100644
--- a/drivers/cpufreq/cris-artpec3-cpufreq.c
+++ b/drivers/cpufreq/cris-artpec3-cpufreq.c
@@ -71,13 +71,9 @@ static int cris_freq_target(struct cpufreq_policy *policy,
 
 static int cris_freq_cpu_init(struct cpufreq_policy *policy)
 {
-	/* cpuinfo and default policy values */
-	policy->cpuinfo.transition_latency = 1000000; /* 1ms */
-
-	return cpufreq_table_validate_and_show(policy, cris_freq_table);
+	return cpufreq_generic_init(policy, cris_freq_table, 1000000);
 }
 
-
 static struct cpufreq_driver cris_freq_driver = {
 	.get	= cris_freq_get_cpu_frequency,
 	.verify	= cpufreq_generic_frequency_table_verify,
diff --git a/drivers/cpufreq/cris-etraxfs-cpufreq.c b/drivers/cpufreq/cris-etraxfs-cpufreq.c
index f7d2d49..fac2b26 100644
--- a/drivers/cpufreq/cris-etraxfs-cpufreq.c
+++ b/drivers/cpufreq/cris-etraxfs-cpufreq.c
@@ -70,10 +70,7 @@ static int cris_freq_target(struct cpufreq_policy *policy,
 
 static int cris_freq_cpu_init(struct cpufreq_policy *policy)
 {
-	/* cpuinfo and default policy values */
-	policy->cpuinfo.transition_latency = 1000000;	/* 1ms */
-
-	return cpufreq_table_validate_and_show(policy, cris_freq_table);
+	return cpufreq_generic_init(policy, cris_freq_table, 1000000);
 }
 
 static struct cpufreq_driver cris_freq_driver = {
-- 
1.7.12.rc2.18.g61b472e

