From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] cpufreq: conservative: Do not use transition notifications
Date: Mon, 13 Jun 2016 15:36:09 +0200
Message-ID: <4018929.eixPj0erQd@vostro.rjw.lan>
References: <2899343.d3UcWvo4TA@vostro.rjw.lan> <20160613110851.GT27439@vireshk-i7>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:51539 "HELO
	cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1423526AbcFMNcC (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 13 Jun 2016 09:32:02 -0400
In-Reply-To: <20160613110851.GT27439@vireshk-i7>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Linux PM list <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

On Monday, June 13, 2016 04:38:51 PM Viresh Kumar wrote:
> On 10-06-16, 03:00, Rafael J. Wysocki wrote:
> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > 
> > The conservative governor registers a transition notifier so it
> > can update its internal requested_freq value if it falls out of the
> > policy->min...policy->max range, but that's not the most
> > straightforward way to achieve that.
> > 
> > To do it in a more straightforward way, first make sure that
> > cs_dbs_timer() will only set frequencies between min and max.
> > 
> > With that, note that requested_freq will always fall between min
> > and max unless either policy->min or policy->max changes and the
> > governor's ->limits() callback will be invoked then.
> > 
> > Using this observation, add a ->limits callback pointer to
> > struct dbs_governor, make cpufreq_dbs_governor_limits() invoke
> > that callback if present, implement that callback in the conservative
> > governor to update requested_freq if needed and drop the transition
> > notifier from it, which also makes it possible to drop the
> > struct cs_governor definition from there and simplify the code
> > accordingly.
> 
> This code looks to me over-complicated and I am not sure if I
> understand why we wanted the notifiers anyway? Why can't we replace
> 'dbs_info->requested_freq' with 'policy->cur' and kill the notifier
> thing completely?
> 
> With requested_freq, we are trying to set the next freq to
> requested_freq +- Delta, which I am not sure is the best approach
> here.
> 
> What would go wrong if we will do, policy->cur +- delta instead?

That should work too, but I wanted to avoid changing the governor's behavior
too much.

So there is a tradeoff between adding a new callback to struct dbs_governor
just for conservative and making the latter behave slightly differently and
I agree that changing the governor a bit more is better.

And of course I'm all for more simplifications, so updated patch is appended. :-)

Thanks,
Rafael

---
From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Subject: [PATCH v2] cpufreq: conservative: Do not use transition notifications

The conservative governor registers a transition notifier so it
can update its internal requested_freq value if it falls out of the
policy->min...policy->max range, but requested_freq is not really
necessary.

That value is used to track the frequency requested by the governor
previously, but policy->cur can be used instead of it and then the
governor will not have to worry about updating the tracked value when
the current frequency changes independently (for example, as a result
of min or max changes).

Accodringly, drop requested_freq from struct cs_policy_dbs_info
and modify cs_dbs_timer() to use policy->cur instead of it.
While at it, notice that __cpufreq_driver_target() clamps its
target_freq argument between policy->min and policy->max, so
the callers of it don't have to do that and make additional
changes in cs_dbs_timer() in accordance with that.

After these changes the transition notifier used by the conservative
governor is not necessary any more, so drop it, which also makes it
possible to drop the struct cs_governor definition and simplify the
code accordingly.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/cpufreq/cpufreq_conservative.c |  103 ++++++---------------------------
 1 file changed, 21 insertions(+), 82 deletions(-)

Index: linux-pm/drivers/cpufreq/cpufreq_conservative.c
===================================================================
--- linux-pm.orig/drivers/cpufreq/cpufreq_conservative.c
+++ linux-pm/drivers/cpufreq/cpufreq_conservative.c
@@ -17,7 +17,6 @@
 struct cs_policy_dbs_info {
 	struct policy_dbs_info policy_dbs;
 	unsigned int down_skip;
-	unsigned int requested_freq;
 };
 
 static inline struct cs_policy_dbs_info *to_dbs_info(struct policy_dbs_info *policy_dbs)
@@ -75,19 +74,17 @@ static unsigned int cs_dbs_timer(struct
 
 	/* Check for frequency increase */
 	if (load > dbs_data->up_threshold) {
+		unsigned int requested_freq = policy->cur;
+
 		dbs_info->down_skip = 0;
 
 		/* if we are already at full speed then break out early */
-		if (dbs_info->requested_freq == policy->max)
+		if (requested_freq == policy->max)
 			goto out;
 
-		dbs_info->requested_freq += get_freq_target(cs_tuners, policy);
-
-		if (dbs_info->requested_freq > policy->max)
-			dbs_info->requested_freq = policy->max;
+		requested_freq += get_freq_target(cs_tuners, policy);
 
-		__cpufreq_driver_target(policy, dbs_info->requested_freq,
-			CPUFREQ_RELATION_H);
+		__cpufreq_driver_target(policy, requested_freq, CPUFREQ_RELATION_H);
 		goto out;
 	}
 
@@ -98,34 +95,26 @@ static unsigned int cs_dbs_timer(struct
 
 	/* Check for frequency decrease */
 	if (load < cs_tuners->down_threshold) {
-		unsigned int freq_target;
+		unsigned int freq_target, requested_freq = policy->cur;
 		/*
 		 * if we cannot reduce the frequency anymore, break out early
 		 */
-		if (policy->cur == policy->min)
+		if (requested_freq == policy->min)
 			goto out;
 
 		freq_target = get_freq_target(cs_tuners, policy);
-		if (dbs_info->requested_freq > freq_target)
-			dbs_info->requested_freq -= freq_target;
+		if (requested_freq > freq_target)
+			requested_freq -= freq_target;
 		else
-			dbs_info->requested_freq = policy->min;
+			requested_freq = policy->min;
 
-		__cpufreq_driver_target(policy, dbs_info->requested_freq,
-				CPUFREQ_RELATION_L);
+		__cpufreq_driver_target(policy, requested_freq, CPUFREQ_RELATION_L);
 	}
 
  out:
 	return dbs_data->sampling_rate;
 }
 
-static int dbs_cpufreq_notifier(struct notifier_block *nb, unsigned long val,
-				void *data);
-
-static struct notifier_block cs_cpufreq_notifier_block = {
-	.notifier_call = dbs_cpufreq_notifier,
-};
-
 /************************** sysfs interface ************************/
 
 static ssize_t store_sampling_down_factor(struct gov_attr_set *attr_set,
@@ -254,13 +243,6 @@ static struct attribute *cs_attributes[]
 
 /************************** sysfs end ************************/
 
-struct cs_governor {
-	struct dbs_governor dbs_gov;
-	unsigned int usage_count;
-};
-
-static struct cs_governor cs_gov;
-
 static struct policy_dbs_info *cs_alloc(void)
 {
 	struct cs_policy_dbs_info *dbs_info;
@@ -294,25 +276,11 @@ static int cs_init(struct dbs_data *dbs_
 	dbs_data->min_sampling_rate = MIN_SAMPLING_RATE_RATIO *
 		jiffies_to_usecs(10);
 
-	/*
-	 * This function and cs_exit() are only called under gov_dbs_data_mutex
-	 * which is global, so the cs_gov.usage_count accesses are guaranteed
-	 * to be serialized.
-	 */
-	if (!cs_gov.usage_count++)
-		cpufreq_register_notifier(&cs_cpufreq_notifier_block,
-					  CPUFREQ_TRANSITION_NOTIFIER);
-
 	return 0;
 }
 
 static void cs_exit(struct dbs_data *dbs_data)
 {
-	/* Protected by gov_dbs_data_mutex - see the comment in cs_init(). */
-	if (!--cs_gov.usage_count)
-		cpufreq_unregister_notifier(&cs_cpufreq_notifier_block,
-					    CPUFREQ_TRANSITION_NOTIFIER);
-
 	kfree(dbs_data->tuners);
 }
 
@@ -321,49 +289,20 @@ static void cs_start(struct cpufreq_poli
 	struct cs_policy_dbs_info *dbs_info = to_dbs_info(policy->governor_data);
 
 	dbs_info->down_skip = 0;
-	dbs_info->requested_freq = policy->cur;
 }
 
-static struct cs_governor cs_gov = {
-	.dbs_gov = {
-		.gov = CPUFREQ_DBS_GOVERNOR_INITIALIZER("conservative"),
-		.kobj_type = { .default_attrs = cs_attributes },
-		.gov_dbs_timer = cs_dbs_timer,
-		.alloc = cs_alloc,
-		.free = cs_free,
-		.init = cs_init,
-		.exit = cs_exit,
-		.start = cs_start,
-	},
+static struct dbs_governor cs_governor = {
+	.gov = CPUFREQ_DBS_GOVERNOR_INITIALIZER("conservative"),
+	.kobj_type = { .default_attrs = cs_attributes },
+	.gov_dbs_timer = cs_dbs_timer,
+	.alloc = cs_alloc,
+	.free = cs_free,
+	.init = cs_init,
+	.exit = cs_exit,
+	.start = cs_start,
 };
 
-#define CPU_FREQ_GOV_CONSERVATIVE	(&cs_gov.dbs_gov.gov)
-
-static int dbs_cpufreq_notifier(struct notifier_block *nb, unsigned long val,
-				void *data)
-{
-	struct cpufreq_freqs *freq = data;
-	struct cpufreq_policy *policy = cpufreq_cpu_get_raw(freq->cpu);
-	struct cs_policy_dbs_info *dbs_info;
-
-	if (!policy)
-		return 0;
-
-	/* policy isn't governed by conservative governor */
-	if (policy->governor != CPU_FREQ_GOV_CONSERVATIVE)
-		return 0;
-
-	dbs_info = to_dbs_info(policy->governor_data);
-	/*
-	 * we only care if our internally tracked freq moves outside the 'valid'
-	 * ranges of frequency available to us otherwise we do not change it
-	*/
-	if (dbs_info->requested_freq > policy->max
-			|| dbs_info->requested_freq < policy->min)
-		dbs_info->requested_freq = freq->new;
-
-	return 0;
-}
+#define CPU_FREQ_GOV_CONSERVATIVE	(&cs_governor.gov)
 
 static int __init cpufreq_gov_dbs_init(void)
 {

