From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH] cpufreq: schedutil: govern how frequently we change
 frequency with rate_limit
Date: Thu, 16 Feb 2017 15:42:10 +0530
Message-ID: <20170216101210.GD21911@vireshk-i7>
References: <4c9afe0a2cda5016b342f777f244c89c03cdc524.1487178939.git.viresh.kumar@linaro.org>
 <6429586.HoWBhxDx3r@aspire.rjw.lan>
 <4960111.i7trI6xaX7@aspire.rjw.lan>
 <4471954.l6hp2TNC2v@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f177.google.com ([209.85.192.177]:34403 "EHLO
        mail-pf0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750735AbdBPKMO (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 16 Feb 2017 05:12:14 -0500
Received: by mail-pf0-f177.google.com with SMTP id e4so4799167pfg.1
        for <linux-pm@vger.kernel.org>; Thu, 16 Feb 2017 02:12:14 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <4471954.l6hp2TNC2v@aspire.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>

On 16-02-17, 01:02, Rafael J. Wysocki wrote:
> More precisely, while the governor computations are less costly than updating
> the CPU state, they are not zero-cost, so do we really want to run them on
> every governor callback invocation until the CPU state is updated?
> 
> We may end up running them very often in some cases after the change you are
> proposing.

I was worried about that initially and kept an additional patch:

diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
index 306d97e7b57c..03d9dc1d1661 100644
--- a/kernel/sched/cpufreq_schedutil.c
+++ b/kernel/sched/cpufreq_schedutil.c
@@ -19,6 +19,7 @@
 #include "sched.h"
 
 #define SUGOV_KTHREAD_PRIORITY	50
+#define SUGOV_MIN_REEVALUATION_DELAY_NS	(1000 * NSEC_PER_USEC)
 
 struct sugov_tunables {
 	struct gov_attr_set attr_set;
@@ -33,6 +34,7 @@ struct sugov_policy {
 
 	raw_spinlock_t update_lock;  /* For shared policies */
 	u64 last_freq_update_time;
+	u64 last_freq_eval_time;
 	s64 freq_update_delay_ns;
 	unsigned int next_freq;
 
@@ -83,8 +85,14 @@ static bool sugov_should_update_freq(struct sugov_policy *sg_policy, u64 time)
 		return true;
 	}
 
 	delta_ns = time - sg_policy->last_freq_update_time;
-	return delta_ns >= sg_policy->freq_update_delay_ns;
+	if (delta_ns < sg_policy->freq_update_delay_ns)
+		return false;
+
+	/* Don't reevaluate frequency too frequently */
+	delta_ns = time - sg_policy->last_freq_eval_time;
+	return delta_ns >= SUGOV_MIN_REEVALUATION_DELAY_NS;
 }
 
 static void sugov_update_commit(struct sugov_policy *sg_policy, u64 time,
@@ -92,6 +100,8 @@ static void sugov_update_commit(struct sugov_policy *sg_policy, u64 time,
 {
 	struct cpufreq_policy *policy = sg_policy->policy;
 
+	sg_policy->last_freq_eval_time = time;
+
 	if (policy->fast_switch_enabled) {
 		if (sg_policy->next_freq == next_freq) {
 			trace_cpu_frequency(policy->cur, smp_processor_id());
@@ -576,6 +586,7 @@ static int sugov_start(struct cpufreq_policy *policy)
 
 	sg_policy->freq_update_delay_ns = sg_policy->tunables->rate_limit_us * NSEC_PER_USEC;
 	sg_policy->last_freq_update_time = 0;
+	sg_policy->last_freq_eval_time = 0;
 	sg_policy->next_freq = UINT_MAX;
 	sg_policy->work_in_progress = false;
 	sg_policy->need_freq_update = false;


But when I discussed this with Vincent, he suggested that it may not be required
at all as the scheduler (with the helped of "decayed") doesn't call into
schedutil too often, i.e. at least 1 ms. And if the CPUs are stable enough (i.e.
no interruptions to the running task), we wouldn't reevaluate before the next
tick.

And so with this change, in the worst case we will reevaluate load every 1 ms
after a time interval of rate_limit_us has passed since the last time frequency
was changed. And as soon as the frequency is changed, we will wait again for
rate_limit_us time.

As I remember, one of the motivations behind moving the cpufreq decision making
logic close to the scheduler core was to get early responses instead of waiting
for a period (like sampling rate) before making a frequency change. And that's
how we can improve performance of the tasks by giving them the bump when they
need it the most.

Yes, this change will surely add some more burden on the CPUs but that is kind
of required to make sure we don't penalize tasks unnecessarily, even when we
don't have to.

-- 
viresh
