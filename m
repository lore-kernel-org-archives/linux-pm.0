From: Jacob Shin <jacob.shin@amd.com>
Subject: [PATCH V2 1/2] cpufreq: ondemand: allow custom powersave_bias_target function to be registered
Date: Thu, 28 Mar 2013 13:24:16 -0500
Message-ID: <1364495057-14939-2-git-send-email-jacob.shin@amd.com>
References: <1364495057-14939-1-git-send-email-jacob.shin@amd.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1364495057-14939-1-git-send-email-jacob.shin@amd.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Viresh Kumar <viresh.kumar@linaro.org>, Jacob Shin <jacob.shin@amd.com>
List-Id: linux-pm@vger.kernel.org

This allows for another [arch specific] driver to hook into existing
powersave bias function of the ondemand governor. i.e. This allows AMD
specific powersave bias function (in a separate AMD specific driver)
to aid ondemand governor's frequency transition deicisions.

Signed-off-by: Jacob Shin <jacob.shin@amd.com>
---
 drivers/cpufreq/cpufreq_governor.h |    3 +++
 drivers/cpufreq/cpufreq_ondemand.c |   22 +++++++++++++++++++---
 2 files changed, 22 insertions(+), 3 deletions(-)

diff --git a/drivers/cpufreq/cpufreq_governor.h b/drivers/cpufreq/cpufreq_governor.h
index c83cabf..4b6808f 100644
--- a/drivers/cpufreq/cpufreq_governor.h
+++ b/drivers/cpufreq/cpufreq_governor.h
@@ -262,4 +262,7 @@ bool need_load_eval(struct cpu_dbs_common_info *cdbs,
 		unsigned int sampling_rate);
 int cpufreq_governor_dbs(struct cpufreq_policy *policy,
 		struct common_dbs_data *cdata, unsigned int event);
+void od_register_powersave_bias_function(unsigned int (*f)
+		(struct cpufreq_policy *, unsigned int, unsigned int));
+void od_unregister_powersave_bias_function(void);
 #endif /* _CPUFREQ_GOVERNER_H */
diff --git a/drivers/cpufreq/cpufreq_ondemand.c b/drivers/cpufreq/cpufreq_ondemand.c
index 15e80ee..36f0798 100644
--- a/drivers/cpufreq/cpufreq_ondemand.c
+++ b/drivers/cpufreq/cpufreq_ondemand.c
@@ -40,6 +40,8 @@
 
 static DEFINE_PER_CPU(struct od_cpu_dbs_info_s, od_cpu_dbs_info);
 
+static struct od_ops od_ops;
+
 #ifndef CONFIG_CPU_FREQ_DEFAULT_GOV_ONDEMAND
 static struct cpufreq_governor cpufreq_gov_ondemand;
 #endif
@@ -145,7 +147,8 @@ static void dbs_freq_increase(struct cpufreq_policy *p, unsigned int freq)
 	struct od_dbs_tuners *od_tuners = dbs_data->tuners;
 
 	if (od_tuners->powersave_bias)
-		freq = powersave_bias_target(p, freq, CPUFREQ_RELATION_H);
+		freq = od_ops.powersave_bias_target(p, freq,
+				CPUFREQ_RELATION_H);
 	else if (p->cur == p->max)
 		return;
 
@@ -206,8 +209,8 @@ static void od_check_cpu(int cpu, unsigned int load_freq)
 			__cpufreq_driver_target(policy, freq_next,
 					CPUFREQ_RELATION_L);
 		} else {
-			int freq = powersave_bias_target(policy, freq_next,
-					CPUFREQ_RELATION_L);
+			int freq = od_ops.powersave_bias_target(policy,
+					freq_next, CPUFREQ_RELATION_L);
 			__cpufreq_driver_target(policy, freq,
 					CPUFREQ_RELATION_L);
 		}
@@ -565,6 +568,19 @@ static struct common_dbs_data od_dbs_cdata = {
 	.exit = od_exit,
 };
 
+void od_register_powersave_bias_function(unsigned int (*f)
+		(struct cpufreq_policy *, unsigned int, unsigned int))
+{
+	od_ops.powersave_bias_target = f;
+}
+EXPORT_SYMBOL_GPL(od_register_powersave_bias_function);
+
+void od_unregister_powersave_bias_function(void)
+{
+	od_ops.powersave_bias_target = powersave_bias_target;
+}
+EXPORT_SYMBOL_GPL(od_unregister_powersave_bias_function);
+
 static int od_cpufreq_governor_dbs(struct cpufreq_policy *policy,
 		unsigned int event)
 {
-- 
1.7.9.5
