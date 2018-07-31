From: skannan@codeaurora.org
Subject: Re: [PATCH v5 10/14] sched/cpufreq: Refactor the utilization
 aggregation method
Date: Tue, 31 Jul 2018 12:31:17 -0700
Message-ID: <75f415911ccdd02d6fd217ca1c7d8902@codeaurora.org>
References: <20180724122521.22109-1-quentin.perret@arm.com>
 <20180724122521.22109-11-quentin.perret@arm.com>
 <331552975e858911db66bc78c2c8e720@codeaurora.org>
 <20180731075950.tfvxef6yuja3ad2k@queper01-lin>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180731075950.tfvxef6yuja3ad2k@queper01-lin>
Sender: linux-kernel-owner@vger.kernel.org
To: Quentin Perret <quentin.perret@arm.com>
Cc: peterz@infradead.org, rjw@rjwysocki.net, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, gregkh@linuxfoundation.org, mingo@redhat.com, dietmar.eggemann@arm.com, morten.rasmussen@arm.com, chris.redpath@arm.com, patrick.bellasi@arm.com, valentin.schneider@arm.com, vincent.guittot@linaro.org, thara.gopinath@linaro.org, viresh.kumar@linaro.org, tkjos@google.com, joel@joelfernandes.org, smuckle@google.com, adharmap@quicinc.com, skannan@quicinc.com, pkondeti@codeaurora.org, juri.lelli@redhat.com, edubezval@gmail.com, srinivas.pandruvada@linux.intel.com, currojerez@riseup.net, javi.merino@kernel.org, linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On 2018-07-31 00:59, Quentin Perret wrote:
> On Monday 30 Jul 2018 at 12:35:27 (-0700), skannan@codeaurora.org 
> wrote:
> [...]
>> If it's going to be a different aggregation from what's done for 
>> frequency
>> guidance, I don't see the point of having this inside schedutil. Why 
>> not
>> keep it inside the scheduler files?
> 
> This code basically results from a discussion we had with Peter on v4.
> Keeping everything centralized can make sense from a maintenance
> perspective, I think. That makes it easy to see the impact of any 
> change
> to utilization signals for both EAS and schedutil.

In that case, I'd argue it makes more sense to keep the code centralized 
in the scheduler. The scheduler can let schedutil know about the 
utilization after it aggregates them. There's no need for a cpufreq 
governor to know that there are scheduling classes or how many there 
are. And the scheduler can then choose to aggregate one way for task 
packing and another way for frequency guidance.

It just seems so weird to have logic that's very essential for task 
placement to be inside a cpufreq governor.

>> Also, it seems weird to use a governor's
>> code when it might not actually be in use. What if someone is using
>> ondemand, conservative, performance, etc?
> 
> Yeah I thought about that too ... I would say that even if you don't
> use schedutil, it is probably a fair assumption from the scheduler's
> standpoint to assume that somewhat OPPs follow utilization (in a very
> loose way). So yes, if you use ondemand with EAS you won't have a
> perfectly consistent match between the frequency requests and what EAS
> predicts, and that might result in sub-optimal decisions in some cases,
> but I'm not sure if we can do anything better at this stage.
> 
> Also, if you do use schedutil, EAS will accurately predict what will be
> the frequency _request_, but that gives you no guarantee whatsoever 
> that
> you'll actually get it for real (because you're throttled, or because 
> of
> thermal capping, or simply because the HW refuses it for some reason 
> ...).
> 
> There will be inconsistencies between EAS' predictions and the actual
> frequencies, and we have to live with that. The best we can do is make
> sure we're at least internally consistent from the scheduler's
> standpoint, and that's why I think it can make sense to factorize as
> many things as possible with schedutil where applicable.
> 
>> > +	if (type == frequency_util) {
>> > +		/*
>> > +		 * Bandwidth required by DEADLINE must always be granted
>> > +		 * while, for FAIR and RT, we use blocked utilization of
>> > +		 * IDLE CPUs as a mechanism to gracefully reduce the
>> > +		 * frequency when no tasks show up for longer periods of
>> > +		 * time.
>> > +		 *
>> > +		 * Ideally we would like to set bw_dl as min/guaranteed
>> > +		 * freq and util + bw_dl as requested freq. However,
>> > +		 * cpufreq is not yet ready for such an interface. So,
>> > +		 * we only do the latter for now.
>> > +		 */
>> > +		util += cpu_bw_dl(rq);
>> > +	}
>> 
>> Instead of all this indentation, can't you just return early without 
>> doing
>> the code inside the if?
> 
> But then I'll need to duplicate the 'min' below, so not sure if it's
> worth it ?

I feel like less indentation where reasonably possible leads to more 
readability. But I don't have a strong opinion in this specific case.

>> > +enum schedutil_type {
>> > +	frequency_util,
>> > +	energy_util,
>> > +};
>> 
>> Please don't use lower case for enums. It's extremely confusing.
> 
> Ok, I'll change that in v6.

Thanks.

-Saravana
