From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH 3/3 v3] cpufreq: governor: Replace timers with utilization update callbacks
Date: Mon, 08 Feb 2016 03:08:07 +0100
Message-ID: <2172360.cldhrkXzeh@vostro.rjw.lan>
References: <3071836.JbNxX8hU6x@vostro.rjw.lan> <20160207091040.GA6112@vireshk> <1855005.ZFAA5ekheo@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:55572 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1753034AbcBHCG6 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sun, 7 Feb 2016 21:06:58 -0500
In-Reply-To: <1855005.ZFAA5ekheo@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Juri Lelli <juri.lelli@arm.com>, Steve Muckle <steve.muckle@linaro.org>, Thomas Gleixner <tglx@linutronix.de>

On Sunday, February 07, 2016 03:43:20 PM Rafael J. Wysocki wrote:
> On Sunday, February 07, 2016 02:40:40 PM Viresh Kumar wrote:
> > On 06-02-16, 00:10, Rafael J. Wysocki wrote:
> > > On Friday, February 05, 2016 08:17:56 PM Viresh Kumar wrote:
> > > > Okay, how about this then.
> > > > 
> > > > We do some computations here and based on them, conditionally want to
> > > > update sample_delay_ns. Because there is no penalty now, in terms of
> > > > removing/adding timers/wq, etc, why shouldn't we simply update the
> > > > sample_delay_ns everytime without any checks? That would mean that the
> > > > change of sampling rate is effective immediately, what can be better than that?
> > > 
> > > Yes, we can do that.
> > > 
> > > There is a small concern about updating in parallel with dbs_work_handler()
> > > in which case we may overwrite the (hopefully already correct) sample_delay_ns
> > > value that it has just written, but then it will be corrected next time we
> > > take a sample, so it shouldn't be a big deal.
> > > 
> > > OK, I'll update the patch to do that.
> > 
> > Great.
> > 
> > > > Also, we should do the same from update-sampling-rate of conservative
> > > > governor as well.
> > > 
> > > Let's just not change the whole world in one patch, OK?
> > 
> > Yeah, I wasn't asking to update in the same patch, but just that we
> > should do that as well.
> > 
> > > > I did bit of that this morning, and there weren't any serious issues as
> > > > as far as I could see :)
> > > 
> > > The case I'm mostly concerned about is when update_sampling_rate() looks
> > > at a CPU with a policy completely unrelated to the dbs_data it was called
> > > for.  In that case the "shared" object may just go away from under it at
> > > any time while it is looking at that object in theory.
> > 
> > Right, a way (ofcourse we should try find something better) is to move
> > that update to a separate work item, just as I did it in my patch..
> 
> No, it isn't.  Trying to do it asynchronously will only lead to more
> concurrency-related issues.
> 
> > But, I am quite sure we can get that fixed.
> 
> What we need to do, is to make it possible for update_sampling_rate()
> to walk all of the cpu_dbs_infos and look at what their policy_dbs
> fields point to safely.
> 
> After my cleanup patches it does that under dbs_data_mutex and that works,
> because this mutex is also held around *any* updates of struct cpu_dbs_info
> anywhere.
> 
> However, the cpu_dbs_infos themselves are actually static, so they can be
> accessed at any time.  It looks like, then, we may just need to add a lock to
> each of them to ensure that the policy_dbs thing won't go away suddenly and
> we may not need dbs_data_mutex in there any more.

Moreover, update_sampling_rate() doesn't need to walk the cpu_dbs_infos,
it may walk policies instead.  Like after the (untested) appended patch.

Then, if we have a governor_data_lock in struct policy, we can use that
to protect policy_dbs while it is being access there and we're done.

I'll try to prototype something along these lines tomorrow.

Thanks,
Rafael


---
 drivers/cpufreq/cpufreq_ondemand.c |   21 ++++++---------------
 1 file changed, 6 insertions(+), 15 deletions(-)

Index: linux-pm/drivers/cpufreq/cpufreq_ondemand.c
===================================================================
--- linux-pm.orig/drivers/cpufreq/cpufreq_ondemand.c
+++ linux-pm/drivers/cpufreq/cpufreq_ondemand.c
@@ -254,34 +254,23 @@ static void update_sampling_rate(struct
 	cpumask_copy(&cpumask, cpu_online_mask);
 
 	for_each_cpu(cpu, &cpumask) {
-		struct cpufreq_policy *policy;
-		struct od_cpu_dbs_info_s *dbs_info;
-		struct cpu_dbs_info *cdbs;
+		struct cpufreq_policy *policy = cpufreq_cpu_get(cpu);
 		struct policy_dbs_info *policy_dbs;
 
-		dbs_info = &per_cpu(od_cpu_dbs_info, cpu);
-		cdbs = &dbs_info->cdbs;
-		policy_dbs = cdbs->policy_dbs;
-
-		/*
-		 * A valid policy_dbs and policy_dbs->policy means governor
-		 * hasn't stopped or exited yet.
-		 */
-		if (!policy_dbs || !policy_dbs->policy)
+		if (!policy)
 			continue;
 
-		policy = policy_dbs->policy;
-
 		/* clear all CPUs of this policy */
 		cpumask_andnot(&cpumask, &cpumask, policy->cpus);
 
+		policy_dbs = policy->governor_data;
 		/*
 		 * Update sampling rate for CPUs whose policy is governed by
 		 * dbs_data. In case of governor_per_policy, only a single
 		 * policy will be governed by dbs_data, otherwise there can be
 		 * multiple policies that are governed by the same dbs_data.
 		 */
-		if (dbs_data == policy_dbs->dbs_data) {
+		if (policy_dbs && policy_dbs->dbs_data == dbs_data) {
 			mutex_lock(&policy_dbs->timer_mutex);
 			/*
 			 * On 32-bit architectures this may race with the
@@ -304,6 +293,8 @@ static void update_sampling_rate(struct
 			gov_update_sample_delay(policy_dbs, new_rate);
 			mutex_unlock(&policy_dbs->timer_mutex);
 		}
+
+		cpufreq_cpu_put(policy);
 	}
 
 	mutex_unlock(&dbs_data_mutex);

