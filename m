From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH 4/12] cpufreq: governor: Drop unused governor callback and data fields
Date: Thu, 18 Feb 2016 02:22:42 +0100
Message-ID: <2775883.U0xits96un@vostro.rjw.lan>
References: <2938006.67J0esUvOA@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:61903 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S965734AbcBRBgw (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 17 Feb 2016 20:36:52 -0500
In-Reply-To: <2938006.67J0esUvOA@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Linux PM list <linux-pm@vger.kernel.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

After some previous changes, the ->get_cpu_dbs_info_s governor
callback and the "governor" field in struct dbs_governor (whose
value represents the governor type) are not used any more, so
drop them.

Also drop the unused gov_ops field from struct dbs_governor.

No functional changes.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/cpufreq/cpufreq_conservative.c |    2 --
 drivers/cpufreq/cpufreq_governor.h     |   15 +--------------
 drivers/cpufreq/cpufreq_ondemand.c     |    3 ---
 3 files changed, 1 insertion(+), 19 deletions(-)

Index: linux-pm/drivers/cpufreq/cpufreq_conservative.c
===================================================================
--- linux-pm.orig/drivers/cpufreq/cpufreq_conservative.c
+++ linux-pm/drivers/cpufreq/cpufreq_conservative.c
@@ -296,10 +296,8 @@ static struct dbs_governor cs_dbs_gov =
 		.max_transition_latency = TRANSITION_LATENCY_LIMIT,
 		.owner = THIS_MODULE,
 	},
-	.governor = GOV_CONSERVATIVE,
 	.kobj_type = { .default_attrs = cs_attributes },
 	.get_cpu_cdbs = get_cpu_cdbs,
-	.get_cpu_dbs_info_s = get_cpu_dbs_info_s,
 	.gov_dbs_timer = cs_dbs_timer,
 	.init = cs_init,
 	.exit = cs_exit,
Index: linux-pm/drivers/cpufreq/cpufreq_governor.h
===================================================================
--- linux-pm.orig/drivers/cpufreq/cpufreq_governor.h
+++ linux-pm/drivers/cpufreq/cpufreq_governor.h
@@ -46,11 +46,6 @@ enum {OD_NORMAL_SAMPLE, OD_SUB_SAMPLE};
 static struct cpu_dbs_info *get_cpu_cdbs(int cpu)			\
 {									\
 	return &per_cpu(_dbs_info, cpu).cdbs;				\
-}									\
-									\
-static void *get_cpu_dbs_info_s(int cpu)				\
-{									\
-	return &per_cpu(_dbs_info, cpu);				\
 }
 
 /*
@@ -188,10 +183,6 @@ struct cs_dbs_tuners {
 /* Common Governor data across policies */
 struct dbs_governor {
 	struct cpufreq_governor gov;
-
-	#define GOV_ONDEMAND		0
-	#define GOV_CONSERVATIVE	1
-	int governor;
 	struct kobj_type kobj_type;
 
 	/*
@@ -201,14 +192,10 @@ struct dbs_governor {
 	struct dbs_data *gdbs_data;
 
 	struct cpu_dbs_info *(*get_cpu_cdbs)(int cpu);
-	void *(*get_cpu_dbs_info_s)(int cpu);
 	unsigned int (*gov_dbs_timer)(struct cpufreq_policy *policy);
 	int (*init)(struct dbs_data *dbs_data, bool notify);
 	void (*exit)(struct dbs_data *dbs_data, bool notify);
 	void (*start)(struct cpufreq_policy *policy);
-
-	/* Governor specific ops, see below */
-	void *gov_ops;
 };
 
 static inline struct dbs_governor *dbs_governor_of(struct cpufreq_policy *policy)
@@ -216,7 +203,7 @@ static inline struct dbs_governor *dbs_g
 	return container_of(policy->governor, struct dbs_governor, gov);
 }
 
-/* Governor specific ops, will be passed to dbs_data->gov_ops */
+/* Governor specific operations */
 struct od_ops {
 	void (*powersave_bias_init_cpu)(int cpu);
 	unsigned int (*powersave_bias_target)(struct cpufreq_policy *policy,
Index: linux-pm/drivers/cpufreq/cpufreq_ondemand.c
===================================================================
--- linux-pm.orig/drivers/cpufreq/cpufreq_ondemand.c
+++ linux-pm/drivers/cpufreq/cpufreq_ondemand.c
@@ -433,12 +433,9 @@ static struct dbs_governor od_dbs_gov =
 		.max_transition_latency	= TRANSITION_LATENCY_LIMIT,
 		.owner = THIS_MODULE,
 	},
-	.governor = GOV_ONDEMAND,
 	.kobj_type = { .default_attrs = od_attributes },
 	.get_cpu_cdbs = get_cpu_cdbs,
-	.get_cpu_dbs_info_s = get_cpu_dbs_info_s,
 	.gov_dbs_timer = od_dbs_timer,
-	.gov_ops = &od_ops,
 	.init = od_init,
 	.exit = od_exit,
 	.start = od_start,

