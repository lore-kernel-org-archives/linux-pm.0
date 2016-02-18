From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH v2 12/12] cpufreq: governor: Narrow down the dbs_data_mutex coverage
Date: Thu, 18 Feb 2016 18:58:58 +0100
Message-ID: <2559441.qfMQ0Nj7fb@vostro.rjw.lan>
References: <2938006.67J0esUvOA@vostro.rjw.lan> <8616971.q0P8tF6lFz@vostro.rjw.lan> <20160218062040.GR2610@vireshk-i7>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:57493 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1423526AbcBRR5e (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 18 Feb 2016 12:57:34 -0500
In-Reply-To: <20160218062040.GR2610@vireshk-i7>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Linux PM list <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On Thursday, February 18, 2016 11:50:40 AM Viresh Kumar wrote:
> On 18-02-16, 02:38, Rafael J. Wysocki wrote:
> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

[cut]

> 
> This has turned into an ugly maze, really. I think it would be much
> better if we sacrifice a bit on consistency in the code, and move the
> locks in cpufreq_governor_dbs() around invocations to
> cpufreq_governor_init(). Or maybe create a
> __cpufreq_governor_init(), or whatever.
> 
> That routine is hardly readably anymore.

So does the one below look better?

---
From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Subject: [PATCH] cpufreq: governor: Narrow down the dbs_data_mutex coverage

Since cpufreq_governor_dbs() is now always called with policy->rwsem
held, it cannot be executed twice in parallel for the same policy.
Thus it is not necessary to hold dbs_data_mutex around the invocations
of cpufreq_governor_start/stop/limits() from it as those functions
never modify any data that can be shared between different policies.

However, cpufreq_governor_dbs() may be executed twice in parallal
for different policies using the same gov->gdbs_data object and
dbs_data_mutex is still necessary to protect that object against
concurrent updates.

For this reason, narrow down the dbs_data_mutex locking to
cpufreq_governor_init/exit() where it is needed and rename the
mutex to gov_dbs_data_mutex to reflect its purpose.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/cpufreq/cpufreq_governor.c |   46 ++++++++++++++++++-------------------
 1 file changed, 23 insertions(+), 23 deletions(-)

Index: linux-pm/drivers/cpufreq/cpufreq_governor.c
===================================================================
--- linux-pm.orig/drivers/cpufreq/cpufreq_governor.c
+++ linux-pm/drivers/cpufreq/cpufreq_governor.c
@@ -24,7 +24,7 @@
 
 static DEFINE_PER_CPU(struct cpu_dbs_info, cpu_dbs);
 
-static DEFINE_MUTEX(dbs_data_mutex);
+static DEFINE_MUTEX(gov_dbs_data_mutex);
 
 /* Common sysfs tunables */
 /**
@@ -422,10 +422,10 @@ static void free_policy_dbs_info(struct
 static int cpufreq_governor_init(struct cpufreq_policy *policy)
 {
 	struct dbs_governor *gov = dbs_governor_of(policy);
-	struct dbs_data *dbs_data = gov->gdbs_data;
+	struct dbs_data *dbs_data;
 	struct policy_dbs_info *policy_dbs;
 	unsigned int latency;
-	int ret;
+	int ret = 0;
 
 	/* State should be equivalent to EXIT */
 	if (policy->governor_data)
@@ -435,6 +435,10 @@ static int cpufreq_governor_init(struct
 	if (!policy_dbs)
 		return -ENOMEM;
 
+	/* Protect gov->gdbs_data against concurrent updates. */
+	mutex_lock(&gov_dbs_data_mutex);
+
+	dbs_data = gov->gdbs_data;
 	if (dbs_data) {
 		if (WARN_ON(have_governor_per_policy())) {
 			ret = -EINVAL;
@@ -447,8 +451,7 @@ static int cpufreq_governor_init(struct
 		dbs_data->usage_count++;
 		list_add(&policy_dbs->list, &dbs_data->policy_dbs_list);
 		mutex_unlock(&dbs_data->mutex);
-
-		return 0;
+		goto out;
 	}
 
 	dbs_data = kzalloc(sizeof(*dbs_data), GFP_KERNEL);
@@ -489,7 +492,7 @@ static int cpufreq_governor_init(struct
 				   get_governor_parent_kobj(policy),
 				   "%s", gov->gov.name);
 	if (!ret)
-		return 0;
+		goto out;
 
 	/* Failure, so roll back. */
 	pr_err("cpufreq: Governor initialization failed (dbs_data kobject init error %d)\n", ret);
@@ -503,6 +506,9 @@ static int cpufreq_governor_init(struct
 
 free_policy_dbs_info:
 	free_policy_dbs_info(policy, gov);
+
+out:
+	mutex_unlock(&gov_dbs_data_mutex);
 	return ret;
 }
 
@@ -513,6 +519,9 @@ static int cpufreq_governor_exit(struct
 	struct dbs_data *dbs_data = policy_dbs->dbs_data;
 	int count;
 
+	/* Protect gov->gdbs_data against concurrent updates. */
+	mutex_lock(&gov_dbs_data_mutex);
+
 	mutex_lock(&dbs_data->mutex);
 	list_del(&policy_dbs->list);
 	count = --dbs_data->usage_count;
@@ -534,6 +543,8 @@ static int cpufreq_governor_exit(struct
 	}
 
 	free_policy_dbs_info(policy, gov);
+
+	mutex_unlock(&gov_dbs_data_mutex);
 	return 0;
 }
 
@@ -600,31 +611,20 @@ static int cpufreq_governor_limits(struc
 
 int cpufreq_governor_dbs(struct cpufreq_policy *policy, unsigned int event)
 {
-	int ret = -EINVAL;
-
-	/* Lock governor to block concurrent initialization of governor */
-	mutex_lock(&dbs_data_mutex);
-
 	if (event == CPUFREQ_GOV_POLICY_INIT) {
-		ret = cpufreq_governor_init(policy);
+		return cpufreq_governor_init(policy);
 	} else if (policy->governor_data) {
 		switch (event) {
 		case CPUFREQ_GOV_POLICY_EXIT:
-			ret = cpufreq_governor_exit(policy);
-			break;
+			return cpufreq_governor_exit(policy);
 		case CPUFREQ_GOV_START:
-			ret = cpufreq_governor_start(policy);
-			break;
+			return cpufreq_governor_start(policy);
 		case CPUFREQ_GOV_STOP:
-			ret = cpufreq_governor_stop(policy);
-			break;
+			return cpufreq_governor_stop(policy);
 		case CPUFREQ_GOV_LIMITS:
-			ret = cpufreq_governor_limits(policy);
-			break;
+			return cpufreq_governor_limits(policy);
 		}
 	}
-
-	mutex_unlock(&dbs_data_mutex);
-	return ret;
+	return -EINVAL;
 }
 EXPORT_SYMBOL_GPL(cpufreq_governor_dbs);

