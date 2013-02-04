From: Viresh Kumar <viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: [PATCH 3/4] cpufreq: Add per policy governor-init/exit infrastructure
Date: Mon,  4 Feb 2013 17:08:53 +0530
Message-ID: <c106ad57a4e7f037d8eeed7aa75a5cd5e806258e.1359976493.git.viresh.kumar@linaro.org>
References: <cover.1359976493.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linaro-dev-bounces-cunTk1MwBs8s++Sfvej+rw@public.gmane.org>
In-Reply-To: <cover.1359976493.git.viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
In-Reply-To: <cover.1359976493.git.viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
References: <cover.1359976493.git.viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
List-Unsubscribe: <http://lists.linaro.org/mailman/options/linaro-dev>,
	<mailto:linaro-dev-request-cunTk1MwBs8s++Sfvej+rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linaro.org/pipermail/linaro-dev>
List-Post: <mailto:linaro-dev-cunTk1MwBs8s++Sfvej+rw@public.gmane.org>
List-Help: <mailto:linaro-dev-request-cunTk1MwBs8s++Sfvej+rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.linaro.org/mailman/listinfo/linaro-dev>,
	<mailto:linaro-dev-request-cunTk1MwBs8s++Sfvej+rw@public.gmane.org?subject=subscribe>
Sender: linaro-dev-bounces-cunTk1MwBs8s++Sfvej+rw@public.gmane.org
Errors-To: linaro-dev-bounces-cunTk1MwBs8s++Sfvej+rw@public.gmane.org
To: rjw-KKrjLPT3xs0@public.gmane.org
Cc: Steve.Bannister-5wv7dgnIgG8@public.gmane.org, linaro-dev-cunTk1MwBs8s++Sfvej+rw@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Viresh Kumar <viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, cpufreq-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-pm@vger.kernel.org

Currently, there can't be multiple instances of single governor_type. If we have
a multi-package system, where we have multiple instances of struct policy (per
package), we can't have multiple instances of same governor. i.e. We can't have
multiple instances of ondemand governor for multiple packages.

Governors directory in sysfs is created at /sys/devices/system/cpu/cpufreq/
governor-name/. Which again reflects that there can be only one instance of a
governor_type in the system.

This is a bottleneck for multicluster system, where we want different packages
to use same governor type, but with different tunables.

This patch is inclined towards providing this infrastructure. Because we are
required to allocate governor's resources dynamically now, we must do it at
policy creation and end. And so got CPUFREQ_GOV_POLICY_INIT/EXIT.

Signed-off-by: Viresh Kumar <viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
---
 drivers/cpufreq/cpufreq.c | 20 +++++++++++++++++---
 include/linux/cpufreq.h   |  9 ++++++---
 2 files changed, 23 insertions(+), 6 deletions(-)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index e619f4f..1ae78d4 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -1076,6 +1076,7 @@ static int __cpufreq_remove_dev(struct device *dev, struct subsys_interface *sif
 
 	/* If cpu is last user of policy, free policy */
 	if (cpus == 1) {
+		__cpufreq_governor(data, CPUFREQ_GOV_POLICY_EXIT);
 		lock_policy_rwsem_write(cpu);
 		kobj = &data->kobj;
 		cmp = &data->kobj_unregister;
@@ -1655,7 +1656,7 @@ EXPORT_SYMBOL(cpufreq_get_policy);
 static int __cpufreq_set_policy(struct cpufreq_policy *data,
 				struct cpufreq_policy *policy)
 {
-	int ret = 0;
+	int ret = 0, failed = 1;
 
 	pr_debug("setting new policy for CPU %u: %u - %u kHz\n", policy->cpu,
 		policy->min, policy->max);
@@ -1709,18 +1710,31 @@ static int __cpufreq_set_policy(struct cpufreq_policy *data,
 			pr_debug("governor switch\n");
 
 			/* end old governor */
-			if (data->governor)
+			if (data->governor) {
 				__cpufreq_governor(data, CPUFREQ_GOV_STOP);
+				__cpufreq_governor(data,
+						CPUFREQ_GOV_POLICY_EXIT);
+			}
 
 			/* start new governor */
 			data->governor = policy->governor;
-			if (__cpufreq_governor(data, CPUFREQ_GOV_START)) {
+			if (!__cpufreq_governor(data, CPUFREQ_GOV_POLICY_INIT)) {
+				if (!__cpufreq_governor(data, CPUFREQ_GOV_START))
+					failed = 0;
+				else
+					__cpufreq_governor(data,
+							CPUFREQ_GOV_POLICY_EXIT);
+			}
+
+			if (failed) {
 				/* new governor failed, so re-start old one */
 				pr_debug("starting governor %s failed\n",
 							data->governor->name);
 				if (old_gov) {
 					data->governor = old_gov;
 					__cpufreq_governor(data,
+							CPUFREQ_GOV_POLICY_INIT);
+					__cpufreq_governor(data,
 							   CPUFREQ_GOV_START);
 				}
 				ret = -EINVAL;
diff --git a/include/linux/cpufreq.h b/include/linux/cpufreq.h
index a22944c..3b822ce 100644
--- a/include/linux/cpufreq.h
+++ b/include/linux/cpufreq.h
@@ -106,6 +106,7 @@ struct cpufreq_policy {
 					 * governors are used */
 	unsigned int		policy; /* see above */
 	struct cpufreq_governor	*governor; /* see below */
+	void			*governor_data;
 
 	struct work_struct	update; /* if update_policy() needs to be
 					 * called, but you're in IRQ context */
@@ -178,9 +179,11 @@ static inline unsigned long cpufreq_scale(unsigned long old, u_int div, u_int mu
  *                          CPUFREQ GOVERNORS                        *
  *********************************************************************/
 
-#define CPUFREQ_GOV_START  1
-#define CPUFREQ_GOV_STOP   2
-#define CPUFREQ_GOV_LIMITS 3
+#define CPUFREQ_GOV_START	1
+#define CPUFREQ_GOV_STOP	2
+#define CPUFREQ_GOV_LIMITS	3
+#define CPUFREQ_GOV_POLICY_INIT	4
+#define CPUFREQ_GOV_POLICY_EXIT	4
 
 struct cpufreq_governor {
 	char	name[CPUFREQ_NAME_LEN];
-- 
1.7.12.rc2.18.g61b472e
