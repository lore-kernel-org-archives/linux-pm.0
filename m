From: Steve Muckle <steve.muckle@linaro.org>
Subject: Re: [PATCH v3 1/3] cpufreq: add cpufreq_driver_resolve_freq()
Date: Thu, 21 Jul 2016 16:41:34 -0700
Message-ID: <20160721234134.GW27987@graphite.smuckle.net>
References: <1468441527-23534-1-git-send-email-smuckle@linaro.org>
 <1468441527-23534-2-git-send-email-smuckle@linaro.org>
 <20160721195926.GF3122@ubuntu>
 <2012245.HQXNKhffmu@vostro.rjw.lan>
 <20160721203041.GH3122@ubuntu>
 <20160721232131.GS27987@graphite.smuckle.net>
 <20160721233003.GM3122@ubuntu>
 <20160721233648.GV27987@graphite.smuckle.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160721233648.GV27987@graphite.smuckle.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Steve Muckle <steve.muckle@linaro.org>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, Morten Rasmussen <morten.rasmussen@arm.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, Juri Lelli <Juri.Lelli@arm.com>, Patrick Bellasi <patrick.bellasi@arm.com>
List-Id: linux-pm@vger.kernel.org

On Thu, Jul 21, 2016 at 04:36:48PM -0700, Steve Muckle wrote:
> On Thu, Jul 21, 2016 at 04:30:03PM -0700, Viresh Kumar wrote:
> > On 21-07-16, 16:21, Steve Muckle wrote:
> > > On Thu, Jul 21, 2016 at 01:30:41PM -0700, Viresh Kumar wrote:
> > > > Okay, but in that case shouldn't we do something like this:
> > > > 
> > > > unsigned int cpufreq_driver_resolve_freq(struct cpufreq_policy *policy,
> > > >                                         unsigned int target_freq)
> > > > {
> > > >        target_freq = clamp_val(target_freq, policy->min, policy->max);
> > > >        policy->cached_target_freq = target_freq;
> > > > 
> > > >        if (cpufreq_driver->target_index) {
> > > >        		policy->cached_resolved_idx =
> > > >        		        cpufreq_frequency_table_target(policy, target_freq,
> > > >        		                                       CPUFREQ_RELATION_L);
> > > >        		return policy->freq_table[policy->cached_resolved_idx].frequency;
> > > >        }
> > > > 
> > > >        if (cpufreq_driver->resolve_freq)
> > > >                return cpufreq_driver->resolve_freq(policy, target_freq);
> > > > }
> > > 
> > > Thanks for the review.
> > > 
> > > My thinking (noted in the commit text) was that the caller of
> > > cpufreq_driver_resolve_freq() would verify that the driver supported the
> > > proper calls before using this API.
> > 
> > Okay, but the caller isn't doing that today. Right?
> 
> There is no caller yet.

Sorry, of course this is not true.

I'm still of the opinion that modifying the governor (I could fix up
schedutil now) or adding a check in driver init would be better than any
unnecessary logic in the fast path.
