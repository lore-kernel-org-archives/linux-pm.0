From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH V2 3/9] cpufreq: ondemand: only queue canceled works from
 update_sampling_rate()
Date: Tue, 8 Sep 2015 07:28:31 +0530
Message-ID: <20150908015831.GY26760@linux>
References: <cover.1437999691.git.viresh.kumar@linaro.org>
 <5b568d732469de1a902e0aa1034ea24e863aa524.1437999691.git.viresh.kumar@linaro.org>
 <1806697.T1XSqGqSN5@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f52.google.com ([209.85.220.52]:34994 "EHLO
	mail-pa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752536AbbIHB6f (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 7 Sep 2015 21:58:35 -0400
Received: by pacfv12 with SMTP id fv12so111824193pac.2
        for <linux-pm@vger.kernel.org>; Mon, 07 Sep 2015 18:58:35 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1806697.T1XSqGqSN5@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, preeti.lkml@gmail.com, open list <linux-kernel@vger.kernel.org>

On 08-09-15, 03:11, Rafael J. Wysocki wrote:
> There really are two cases, either you pass a CPU or gov_queue_work() has to
> walk policy->cpus.

Right (At least for now, we are doing just that.)

> Doing it the way you did hides that IMO.

Maybe. But I see it otherwise. Adding special meaning to a variable
(like int cpu == -1 being the special case to specify policy->cpus)
hides things morei, as we need to look at how it is decoded finally in
the routine gov_queue_work().

But if we send a mask instead, it is very clear by reading the callers
site, what we are trying to do.

> I'd simply pass an int and use a special value to indicate that policy->cpus
> is to be walked.

Like cpu == -1 thing? Or something else?

> > -	if (!all_cpus) {
> > -		/*
> > -		 * Use raw_smp_processor_id() to avoid preemptible warnings.
> > -		 * We know that this is only called with all_cpus == false from
> > -		 * works that have been queued with *_work_on() functions and
> > -		 * those works are canceled during CPU_DOWN_PREPARE so they
> > -		 * can't possibly run on any other CPU.
> > -		 */
> 
> This was a useful comment and it should be moved along the logic it was supposed
> to explain and not just dropped.

Sigh

> > -		__gov_queue_work(raw_smp_processor_id(), dbs_data, delay);
> > -	} else {
> > -		for_each_cpu(i, policy->cpus)
> > -			__gov_queue_work(i, dbs_data, delay);
> > -	}
> > +	for_each_cpu(i, cpus)
> > +		__gov_queue_work(i, dbs_data, delay);
> >  
> >  out_unlock:
> >  	mutex_unlock(&cpufreq_governor_lock);
> > @@ -232,7 +221,8 @@ static void dbs_timer(struct work_struct *work)
> >  	struct cpufreq_policy *policy = shared->policy;
> >  	struct dbs_data *dbs_data = policy->governor_data;
> >  	unsigned int sampling_rate, delay;
> > -	bool modify_all = true;
> > +	const struct cpumask *cpus;
> 
> I don't think this local variable is necessary.
> 
> > +	bool load_eval;
> >  
> >  	mutex_lock(&shared->timer_mutex);
> >  
> > @@ -246,11 +236,11 @@ static void dbs_timer(struct work_struct *work)
> >  		sampling_rate = od_tuners->sampling_rate;
> >  	}
> >  
> > -	if (!need_load_eval(cdbs->shared, sampling_rate))
> > -		modify_all = false;
> > +	load_eval = need_load_eval(cdbs->shared, sampling_rate);
> > +	cpus = load_eval ? policy->cpus : cpumask_of(raw_smp_processor_id());
> >  
> > -	delay = dbs_data->cdata->gov_dbs_timer(cdbs, dbs_data, modify_all);
> > -	gov_queue_work(dbs_data, policy, delay, modify_all);
> > +	delay = dbs_data->cdata->gov_dbs_timer(cdbs, dbs_data, load_eval);
> > +	gov_queue_work(dbs_data, policy, delay, cpus);

Avoiding that local variable would have made this a little longer, but
I can surely drop it :)

        gov_queue_work(dbs_data, policy, delay,
                       load_eval ? policy->cpus :
                                   cpumask_of(raw_smp_processor_id());

-- 
viresh
