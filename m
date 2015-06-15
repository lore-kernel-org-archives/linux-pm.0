From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 09/12] cpufreq: governor: Avoid invalid states with
 additional checks
Date: Mon, 15 Jun 2015 14:42:27 +0530
Message-ID: <20150615091227.GD27654@linux>
References: <cover.1434019473.git.viresh.kumar@linaro.org>
 <280186b68a8b906365316876a7b6d9eafb28296b.1434019473.git.viresh.kumar@linaro.org>
 <557E93E5.3030604@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pd0-f171.google.com ([209.85.192.171]:36649 "EHLO
	mail-pd0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755992AbbFOJMc (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 15 Jun 2015 05:12:32 -0400
Received: by pdjm12 with SMTP id m12so68615284pdj.3
        for <linux-pm@vger.kernel.org>; Mon, 15 Jun 2015 02:12:31 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <557E93E5.3030604@linux.vnet.ibm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Preeti U Murthy <preeti@linux.vnet.ibm.com>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, ke.wang@spreadtrum.com, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, ego@linux.vnet.ibm.com, paulus@samba.org, shilpa.bhat@linux.vnet.ibm.com, prarit@redhat.com, robert.schoene@tu-dresden.de, skannan@codeaurora.org

On 15-06-15, 14:29, Preeti U Murthy wrote:
> On 06/11/2015 04:21 PM, Viresh Kumar wrote:
> > @@ -169,8 +169,12 @@ static inline void __gov_queue_work(int cpu, struct dbs_data *dbs_data,
> >  void gov_queue_work(struct dbs_data *dbs_data, struct cpufreq_policy *policy,
> >  		unsigned int delay, bool all_cpus)
> >  {
> > +	struct cpu_dbs_info *cdbs = dbs_data->cdata->get_cpu_cdbs(policy->cpu);
> >  	int i;
> > 
> > +	if (!cdbs->ccdbs->enabled)
> > +		return;
> 
> policy->governor_enabled is already doing this job. Why this additional
> check ?

That can be removed after this series. The idea was to get/set this
information from within the governor instead of cpufreq core. And all
those checks from __cpufreq_governor() should die as well.

> > +
> >  	mutex_lock(&cpufreq_governor_lock);
> >  	if (!policy->governor_enabled)
> >  		goto out_unlock;
> > @@ -234,6 +238,8 @@ static void dbs_timer(struct work_struct *work)
> >  	bool modify_all = true;
> > 
> >  	mutex_lock(&dbs_data->cdata->mutex);
> > +	if (!cdbs->ccdbs->enabled)
> > +		goto unlock;
> 
> This should not trigger at all if we get the entries into
> cpufreq_governor_dbs() fixed. I don't like the idea of adding
> checks/locks in places where it can be avoided.

We will get the order of events get fixed in cpufreq.c, but this is
about the sanity of the governor.

> > -static void cpufreq_governor_exit(struct cpufreq_policy *policy,
> > -				  struct dbs_data *dbs_data)
> > +static int cpufreq_governor_exit(struct cpufreq_policy *policy,
> > +				 struct dbs_data *dbs_data)
> >  {
> >  	struct common_dbs_data *cdata = dbs_data->cdata;
> > +	struct cpu_dbs_info *cdbs = cdata->get_cpu_cdbs(policy->cpu);
> > +
> > +	/* STOP should have been called by now */
> 
> This is not true, atleast in the races that I have seen. The problem is
> not about STOP not being called before an EXIT. It is about a START
> being called after a STOP and before an EXIT. The comment should ideally
> be "The policy is active, stop it before exit" or similar.
> 
> > +	if (cdbs->ccdbs->enabled)
> > +		return -EBUSY;
> 
> And.. in such a scenario, we must not be aborting EXIT; rather it must
> cancel the queued work and successfully exit the policy. An EXIT is a
> more urgent operation than START, given its call sites. Also an EXIT
> will not leave the cpufreq governors in a limbo state, it is bound to
> restart a new policy or quit a policy if the last cpu goes down. A
> racing START operation however is typically from a call site referencing
> an older policy. Its better to abort this than the EXIT operation.
> 
> It may mean a user is trying to switch governors, and the exit operation
> is quitting the old governor as a result. A START from a
> cpufreq_remove_dev_finish() racing in just before this is no reason to
> prevent switching governors.

We can't decide the priority of events here. All we can do is to make
sure that the governor doesn't end up going into a bad state.

So, if the sequence is STOP followed by START and then EXIT. Because
START has started the wqs, EXIT can't just EXIT. And pushing the
wq-cancel part into EXIT is absolutely wrong.

What we need to prevent is the START to interfere with the sequence of
STOP, EXIT. We will do that separately, we are just making sure here
that a user code isn't following wrong sequence of events.

-- 
viresh
