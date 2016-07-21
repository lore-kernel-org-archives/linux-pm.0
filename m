From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH v3 1/3] cpufreq: add cpufreq_driver_resolve_freq()
Date: Thu, 21 Jul 2016 16:31:22 -0700
Message-ID: <20160721233122.GN3122@ubuntu>
References: <1468441527-23534-1-git-send-email-smuckle@linaro.org>
 <1468441527-23534-2-git-send-email-smuckle@linaro.org>
 <20160721195926.GF3122@ubuntu>
 <2012245.HQXNKhffmu@vostro.rjw.lan>
 <20160721203041.GH3122@ubuntu>
 <20160721232131.GS27987@graphite.smuckle.net>
 <20160721232952.GU27987@graphite.smuckle.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f49.google.com ([209.85.220.49]:36420 "EHLO
	mail-pa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751951AbcGUXbY (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 21 Jul 2016 19:31:24 -0400
Received: by mail-pa0-f49.google.com with SMTP id pp5so33278148pac.3
        for <linux-pm@vger.kernel.org>; Thu, 21 Jul 2016 16:31:24 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20160721232952.GU27987@graphite.smuckle.net>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Steve Muckle <steve.muckle@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, Morten Rasmussen <morten.rasmussen@arm.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, Juri Lelli <Juri.Lelli@arm.com>, Patrick Bellasi <patrick.bellasi@arm.com>

On 21-07-16, 16:29, Steve Muckle wrote:
> On Thu, Jul 21, 2016 at 04:21:31PM -0700, Steve Muckle wrote:
> > On Thu, Jul 21, 2016 at 01:30:41PM -0700, Viresh Kumar wrote:
> > > Okay, but in that case shouldn't we do something like this:
> > > 
> > > unsigned int cpufreq_driver_resolve_freq(struct cpufreq_policy *policy,
> > >                                         unsigned int target_freq)
> > > {
> > >        target_freq = clamp_val(target_freq, policy->min, policy->max);
> > >        policy->cached_target_freq = target_freq;
> > > 
> > >        if (cpufreq_driver->target_index) {
> > >        		policy->cached_resolved_idx =
> > >        		        cpufreq_frequency_table_target(policy, target_freq,
> > >        		                                       CPUFREQ_RELATION_L);
> > >        		return policy->freq_table[policy->cached_resolved_idx].frequency;
> > >        }
> > > 
> > >        if (cpufreq_driver->resolve_freq)
> > >                return cpufreq_driver->resolve_freq(policy, target_freq);
> > > }
> > 
> > Thanks for the review.
> > 
> > My thinking (noted in the commit text) was that the caller of
> > cpufreq_driver_resolve_freq() would verify that the driver supported the
> > proper calls before using this API. This way it can be checked once,
> > presumably in a governor's init routine. Checking the pointer over and
> > over again in a fast path is wasteful.
> 
> I guess this isn't immediately possible as the governor can't see
> cpufreq_driver. I was hoping to change that however to allow
> cpufreq_driver_resolve_freq() to be inlined in schedutil to get rid of
> another function call...

Well, you can do that by moving the newly created routine to
cpufreq.h.

-- 
viresh
