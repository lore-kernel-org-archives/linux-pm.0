From: Stratos Karafotis <stratosk@semaphore.gr>
Subject: [PATCH] cpufreq: governor: Fix typos in comments
Date: Mon, 26 Aug 2013 21:42:21 +0300
Message-ID: <521BA18D.70706@semaphore.gr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>, Viresh Kumar <viresh.kumar@linaro.org>
Cc: cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

- 'Governer' should be 'Governor'
- 'S' is used for Siemens (electrical conductance) in SI units.
Use small 's' for seconds.

Signed-off-by: Stratos Karafotis <stratosk@semaphore.gr>
---
 drivers/cpufreq/cpufreq_governor.c |  2 +-
 drivers/cpufreq/cpufreq_governor.h | 12 ++++++------
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/cpufreq/cpufreq_governor.c b/drivers/cpufreq/cpufreq_governor.c
index 8742736..fea104a 100644
--- a/drivers/cpufreq/cpufreq_governor.c
+++ b/drivers/cpufreq/cpufreq_governor.c
@@ -230,7 +230,7 @@ int cpufreq_governor_dbs(struct cpufreq_policy *policy,
 
 		policy->governor_data = dbs_data;
 
-		/* policy latency is in nS. Convert it to uS first */
+		/* policy latency is in ns. Convert it to us first */
 		latency = policy->cpuinfo.transition_latency / 1000;
 		if (latency == 0)
 			latency = 1;
diff --git a/drivers/cpufreq/cpufreq_governor.h b/drivers/cpufreq/cpufreq_governor.h
index a02d78b..88cd39f 100644
--- a/drivers/cpufreq/cpufreq_governor.h
+++ b/drivers/cpufreq/cpufreq_governor.h
@@ -25,11 +25,11 @@
 /*
  * The polling frequency depends on the capability of the processor. Default
  * polling frequency is 1000 times the transition latency of the processor. The
- * governor will work on any processor with transition latency <= 10mS, using
+ * governor will work on any processor with transition latency <= 10ms, using
  * appropriate sampling rate.
  *
- * For CPUs with transition latency > 10mS (mostly drivers with CPUFREQ_ETERNAL)
- * this governor will not work. All times here are in uS.
+ * For CPUs with transition latency > 10ms (mostly drivers with CPUFREQ_ETERNAL)
+ * this governor will not work. All times here are in us (micro seconds).
  */
 #define MIN_SAMPLING_RATE_RATIO			(2)
 #define LATENCY_MULTIPLIER			(1000)
@@ -162,7 +162,7 @@ struct cs_cpu_dbs_info_s {
 	unsigned int enable:1;
 };
 
-/* Per policy Governers sysfs tunables */
+/* Per policy Governors sysfs tunables */
 struct od_dbs_tuners {
 	unsigned int ignore_nice_load;
 	unsigned int sampling_rate;
@@ -181,7 +181,7 @@ struct cs_dbs_tuners {
 	unsigned int freq_step;
 };
 
-/* Common Governer data across policies */
+/* Common Governor data across policies */
 struct dbs_data;
 struct common_dbs_data {
 	/* Common across governors */
@@ -205,7 +205,7 @@ struct common_dbs_data {
 	void *gov_ops;
 };
 
-/* Governer Per policy data */
+/* Governor Per policy data */
 struct dbs_data {
 	struct common_dbs_data *cdata;
 	unsigned int min_sampling_rate;
-- 
1.8.3.1
