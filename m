From: Viresh Kumar <viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: [PATCH 1/4] cpufreq: governors: Fix WARN_ON() for multi-policy
	platforms
Date: Thu,  7 Feb 2013 15:57:43 +0530
Message-ID: <007dda326f1b1415846671d7fcfbd520f4f16151.1360232293.git.viresh.kumar@linaro.org>
References: <cover.1360232293.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linaro-dev-bounces-cunTk1MwBs8s++Sfvej+rw@public.gmane.org>
In-Reply-To: <cover.1360232293.git.viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
In-Reply-To: <cover.1360232293.git.viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
References: <cover.1360232293.git.viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
List-Unsubscribe: <http://lists.linaro.org/mailman/options/linaro-dev>,
	<mailto:linaro-dev-request-cunTk1MwBs8s++Sfvej+rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linaro.org/pipermail/linaro-dev>
List-Post: <mailto:linaro-dev-cunTk1MwBs8s++Sfvej+rw@public.gmane.org>
List-Help: <mailto:linaro-dev-request-cunTk1MwBs8s++Sfvej+rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.linaro.org/mailman/listinfo/linaro-dev>,
	<mailto:linaro-dev-request-cunTk1MwBs8s++Sfvej+rw@public.gmane.org?subject=subscribe>
Sender: linaro-dev-bounces-cunTk1MwBs8s++Sfvej+rw@public.gmane.org
Errors-To: linaro-dev-bounces-cunTk1MwBs8s++Sfvej+rw@public.gmane.org
To: rjw-KKrjLPT3xs0@public.gmane.org, valdis.kletnieks-PjAqaU27lzQ@public.gmane.org, artem.savkov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Cc: Steve.Bannister-5wv7dgnIgG8@public.gmane.org, linaro-dev-cunTk1MwBs8s++Sfvej+rw@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Viresh Kumar <viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, cpufreq-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-pm@vger.kernel.org

On multi-policy systems there is a single instance of governor for both the
policies (if same governor is chosen for both policies). With the code update
from following patches:

8eeed09 cpufreq: governors: Get rid of dbs_data->enable field
b394058 cpufreq: governors: Reset tunables only for cpufreq_unregister_governor()

We are creating/removing sysfs directory of governor for for every call to
GOV_START and STOP. This would fail for multi-policy system as there is a
per-policy call to START/STOP.

This patch reuses the governor->initialized variable to detect total users of
governor.

Signed-off-by: Viresh Kumar <viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
---
 drivers/cpufreq/cpufreq.c          |  6 ++++--
 drivers/cpufreq/cpufreq_governor.c | 32 +++++++++++++++++++-------------
 2 files changed, 23 insertions(+), 15 deletions(-)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index ccc598a..3b941a1 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -1567,8 +1567,10 @@ static int __cpufreq_governor(struct cpufreq_policy *policy,
 						policy->cpu, event);
 	ret = policy->governor->governor(policy, event);
 
-	if (!policy->governor->initialized && (event == CPUFREQ_GOV_START))
-		policy->governor->initialized = 1;
+	if (event == CPUFREQ_GOV_START)
+		policy->governor->initialized++;
+	else if (event == CPUFREQ_GOV_STOP)
+		policy->governor->initialized--;
 
 	/* we keep one module reference alive for
 			each CPU governed by this CPU */
diff --git a/drivers/cpufreq/cpufreq_governor.c b/drivers/cpufreq/cpufreq_governor.c
index e4a306c..5a76086 100644
--- a/drivers/cpufreq/cpufreq_governor.c
+++ b/drivers/cpufreq/cpufreq_governor.c
@@ -247,11 +247,13 @@ int cpufreq_governor_dbs(struct dbs_data *dbs_data,
 					     dbs_data->gov_dbs_timer);
 		}
 
-		rc = sysfs_create_group(cpufreq_global_kobject,
-				dbs_data->attr_group);
-		if (rc) {
-			mutex_unlock(&dbs_data->mutex);
-			return rc;
+		if (!policy->governor->initialized) {
+			rc = sysfs_create_group(cpufreq_global_kobject,
+					dbs_data->attr_group);
+			if (rc) {
+				mutex_unlock(&dbs_data->mutex);
+				return rc;
+			}
 		}
 
 		/*
@@ -262,13 +264,15 @@ int cpufreq_governor_dbs(struct dbs_data *dbs_data,
 			cs_dbs_info->down_skip = 0;
 			cs_dbs_info->enable = 1;
 			cs_dbs_info->requested_freq = policy->cur;
-			cpufreq_register_notifier(cs_ops->notifier_block,
-					CPUFREQ_TRANSITION_NOTIFIER);
 
-			if (!policy->governor->initialized)
+			if (!policy->governor->initialized) {
+				cpufreq_register_notifier(cs_ops->notifier_block,
+						CPUFREQ_TRANSITION_NOTIFIER);
+
 				dbs_data->min_sampling_rate =
 					MIN_SAMPLING_RATE_RATIO *
 					jiffies_to_usecs(10);
+			}
 		} else {
 			od_dbs_info->rate_mult = 1;
 			od_dbs_info->sample_type = OD_NORMAL_SAMPLE;
@@ -311,11 +315,13 @@ unlock:
 		mutex_lock(&dbs_data->mutex);
 		mutex_destroy(&cpu_cdbs->timer_mutex);
 
-		sysfs_remove_group(cpufreq_global_kobject,
-				dbs_data->attr_group);
-		if (dbs_data->governor == GOV_CONSERVATIVE)
-			cpufreq_unregister_notifier(cs_ops->notifier_block,
-					CPUFREQ_TRANSITION_NOTIFIER);
+		if (policy->governor->initialized == 1) {
+			sysfs_remove_group(cpufreq_global_kobject,
+					dbs_data->attr_group);
+			if (dbs_data->governor == GOV_CONSERVATIVE)
+				cpufreq_unregister_notifier(cs_ops->notifier_block,
+						CPUFREQ_TRANSITION_NOTIFIER);
+		}
 		mutex_unlock(&dbs_data->mutex);
 
 		break;
-- 
1.7.12.rc2.18.g61b472e
