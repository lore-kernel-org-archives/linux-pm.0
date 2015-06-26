From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 03/10] cpufreq: conservative: remove 'enable' field
Date: Fri, 26 Jun 2015 11:49:31 +0530
Message-ID: <20150626061931.GD16275@linux>
References: <cover.1434959517.git.viresh.kumar@linaro.org>
 <e5627369b56ae3dcd00d7243e00618992c457cce.1434959517.git.viresh.kumar@linaro.org>
 <558CE9DD.1050105@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f51.google.com ([209.85.220.51]:34300 "EHLO
	mail-pa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751557AbbFZGTl (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 26 Jun 2015 02:19:41 -0400
Received: by pabvl15 with SMTP id vl15so63351359pab.1
        for <linux-pm@vger.kernel.org>; Thu, 25 Jun 2015 23:19:41 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <558CE9DD.1050105@linux.vnet.ibm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Preeti U Murthy <preeti@linux.vnet.ibm.com>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org

On 26-06-15, 11:27, Preeti U Murthy wrote:
> On 06/22/2015 01:32 PM, Viresh Kumar wrote:
> > Conservative governor has its own 'enable' field to check two things:
> > - If conservative governor is used for a CPU or not
> > - If governor is currently enabled or not, as there can be a race around
> >   the notifier being called while it was getting unregistered from
> >   cpufreq_governor_dbs().
> 
> The race is between changing governors in cpufreq_set_policy() and the
> notifier being called, isn't it ? The governor will get unregistered
> when we remove the cpufreq module and here too we do not set
> policy->governor to NULL nor set the enable bit to 0. So it does not
> look like we were protecting these checks against un-registering the
> governor.

I was talking about the same race which I believed to exist in 2/10 as
well.. But there is no such race it seems as we discussed yesterday.
So, only the first point is what the enable field was required for.

And because of that getting NAK'd, here is the new version:

-------------------------8<-----------------

Message-Id: <4ce8fc98a46af394118237ef90ed0b80a7652cfb.1435299551.git.viresh.kumar@linaro.org>
From: Viresh Kumar <viresh.kumar@linaro.org>
Date: Fri, 19 Jun 2015 11:40:14 +0530
Subject: [PATCH] cpufreq: conservative: remove 'enable' field

Conservative governor has its own 'enable' field to check if
conservative governor is used for a CPU or not

This can be checked by policy->governor with 'cpufreq_gov_conservative'
and so this field can be dropped.

Because its not guaranteed that dbs_info->cdbs.ccdbs will a valid
pointer for all CPUs (will be NULL for CPUs that don't use
ondemand/conservative governors), we can't use it anymore. Lets get
policy with cpufreq_cpu_get() instead.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/cpufreq_conservative.c | 34 +++++++++++++++++++++-------------
 drivers/cpufreq/cpufreq_governor.c     | 12 +-----------
 drivers/cpufreq/cpufreq_governor.h     |  1 -
 3 files changed, 22 insertions(+), 25 deletions(-)

diff --git a/drivers/cpufreq/cpufreq_conservative.c b/drivers/cpufreq/cpufreq_conservative.c
index 0e4154e584bf..f53719e5bed9 100644
--- a/drivers/cpufreq/cpufreq_conservative.c
+++ b/drivers/cpufreq/cpufreq_conservative.c
@@ -23,6 +23,19 @@
 
 static DEFINE_PER_CPU(struct cs_cpu_dbs_info_s, cs_cpu_dbs_info);
 
+static int cs_cpufreq_governor_dbs(struct cpufreq_policy *policy,
+				   unsigned int event);
+
+#ifndef CONFIG_CPU_FREQ_DEFAULT_GOV_CONSERVATIVE
+static
+#endif
+struct cpufreq_governor cpufreq_gov_conservative = {
+	.name			= "conservative",
+	.governor		= cs_cpufreq_governor_dbs,
+	.max_transition_latency	= TRANSITION_LATENCY_LIMIT,
+	.owner			= THIS_MODULE,
+};
+
 static inline unsigned int get_freq_target(struct cs_dbs_tuners *cs_tuners,
 					   struct cpufreq_policy *policy)
 {
@@ -119,12 +132,14 @@ static int dbs_cpufreq_notifier(struct notifier_block *nb, unsigned long val,
 	struct cpufreq_freqs *freq = data;
 	struct cs_cpu_dbs_info_s *dbs_info =
 					&per_cpu(cs_cpu_dbs_info, freq->cpu);
-	struct cpufreq_policy *policy;
+	struct cpufreq_policy *policy = cpufreq_cpu_get(freq->cpu);
 
-	if (!dbs_info->enable)
+	if (!policy)
 		return 0;
 
-	policy = dbs_info->cdbs.ccdbs->policy;
+	/* policy isn't governed by conservative governor */
+	if (policy->governor != &cpufreq_gov_conservative)
+		goto policy_put;
 
 	/*
 	 * we only care if our internally tracked freq moves outside the 'valid'
@@ -134,6 +149,9 @@ static int dbs_cpufreq_notifier(struct notifier_block *nb, unsigned long val,
 			|| dbs_info->requested_freq < policy->min)
 		dbs_info->requested_freq = freq->new;
 
+policy_put:
+	cpufreq_cpu_put(policy);
+
 	return 0;
 }
 
@@ -367,16 +385,6 @@ static int cs_cpufreq_governor_dbs(struct cpufreq_policy *policy,
 	return cpufreq_governor_dbs(policy, &cs_dbs_cdata, event);
 }
 
-#ifndef CONFIG_CPU_FREQ_DEFAULT_GOV_CONSERVATIVE
-static
-#endif
-struct cpufreq_governor cpufreq_gov_conservative = {
-	.name			= "conservative",
-	.governor		= cs_cpufreq_governor_dbs,
-	.max_transition_latency	= TRANSITION_LATENCY_LIMIT,
-	.owner			= THIS_MODULE,
-};
-
 static int __init cpufreq_gov_dbs_init(void)
 {
 	return cpufreq_register_governor(&cpufreq_gov_conservative);
diff --git a/drivers/cpufreq/cpufreq_governor.c b/drivers/cpufreq/cpufreq_governor.c
index af63402a94a9..836aefd03c1b 100644
--- a/drivers/cpufreq/cpufreq_governor.c
+++ b/drivers/cpufreq/cpufreq_governor.c
@@ -463,7 +463,6 @@ static int cpufreq_governor_start(struct cpufreq_policy *policy,
 			cdata->get_cpu_dbs_info_s(cpu);
 
 		cs_dbs_info->down_skip = 0;
-		cs_dbs_info->enable = 1;
 		cs_dbs_info->requested_freq = policy->cur;
 	} else {
 		struct od_ops *od_ops = cdata->gov_ops;
@@ -482,9 +481,7 @@ static int cpufreq_governor_start(struct cpufreq_policy *policy,
 static int cpufreq_governor_stop(struct cpufreq_policy *policy,
 				 struct dbs_data *dbs_data)
 {
-	struct common_dbs_data *cdata = dbs_data->cdata;
-	unsigned int cpu = policy->cpu;
-	struct cpu_dbs_info *cdbs = cdata->get_cpu_cdbs(cpu);
+	struct cpu_dbs_info *cdbs = dbs_data->cdata->get_cpu_cdbs(policy->cpu);
 	struct cpu_common_dbs_info *ccdbs = cdbs->ccdbs;
 
 	/* State should be equivalent to START */
@@ -493,13 +490,6 @@ static int cpufreq_governor_stop(struct cpufreq_policy *policy,
 
 	gov_cancel_work(dbs_data, policy);
 
-	if (cdata->governor == GOV_CONSERVATIVE) {
-		struct cs_cpu_dbs_info_s *cs_dbs_info =
-			cdata->get_cpu_dbs_info_s(cpu);
-
-		cs_dbs_info->enable = 0;
-	}
-
 	ccdbs->policy = NULL;
 	mutex_destroy(&ccdbs->timer_mutex);
 	return 0;
diff --git a/drivers/cpufreq/cpufreq_governor.h b/drivers/cpufreq/cpufreq_governor.h
index 2125c299c602..a0d24149f18c 100644
--- a/drivers/cpufreq/cpufreq_governor.h
+++ b/drivers/cpufreq/cpufreq_governor.h
@@ -170,7 +170,6 @@ struct cs_cpu_dbs_info_s {
 	struct cpu_dbs_info cdbs;
 	unsigned int down_skip;
 	unsigned int requested_freq;
-	unsigned int enable:1;
 };
 
 /* Per policy Governors sysfs tunables */
