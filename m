From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH V2] cpufreq: Disallow ->resolve_freq() for drivers providing ->target_index()
Date: Fri, 22 Jul 2016 23:11:39 +0200
Message-ID: <1635689.iZWBWcBJ5f@vostro.rjw.lan>
References: <065301260510fbca81f5481b27b0de956073068a.1469137133.git.viresh.kumar@linaro.org> <20160722003405.GZ27987@graphite.smuckle.net> <20160722151327.GP3122@ubuntu>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:64546 "HELO
	cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1750796AbcGVVGm (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 22 Jul 2016 17:06:42 -0400
In-Reply-To: <20160722151327.GP3122@ubuntu>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Steve Muckle <steve.muckle@linaro.org>, "Rafael J. Wysocki" <rafael@kernel.org>, Lists linaro-kernel <linaro-kernel@lists.linaro.org>, Linux PM <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>, Morten Rasmussen <morten.rasmussen@arm.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, Juri Lelli <Juri.Lelli@arm.com>, Patrick Bellasi <patrick.bellasi@arm.com>

On Friday, July 22, 2016 08:13:27 AM Viresh Kumar wrote:
> On 21-07-16, 17:34, Steve Muckle wrote:
> > On Fri, Jul 22, 2016 at 02:18:54AM +0200, Rafael J. Wysocki wrote:
> > > > My thinking was that one of these two would be preferable:
> > > >
> > > > - Forcing ->target() drivers to install a ->resolve_freq callback,
> > > >   enforcing this at cpufreq driver init time.
> > > 
> > > That would have been possible, but your series didn't do that.
> > > 
> > > >   My understanding is
> > > >   ->target() drivers are deprecated anyway
> > > 
> > > No, they aren't.
> > 
> > Ok. I didn't follow Documentation/cpu-freq/cpu-drivers.txt section 1.5
> > then - it suggests something about target() is deprecated, perhaps it's
> > out of date.
> 
> They are kind of deprecated for the new uesrs, but we still have
> handful of users of it.

No, they aren't deprecated, not even sort of.

Of course, stuff that can use frequency tables should implement ->target_index,
because there's no valid reason for it not to do that.

However, there are cases (and not legacy) where frequency tables are simply
impractical and those drivers have no choice but to implement ->target.

And if you want to try to force them into the frequency tables model
regardless, then think twice, because I'm not going to let you do that.

> > Sorry, that should've been "check that either ->target_index() or
> > ->resolve_freq() is implemented." 
> > 
> > Implementing resolve_freq for the target() drivers and requiring it at
> > driver init time is probably the better way to go though. Perhaps I can
> > work on this at some point.
> 
> As I said earlier as well in one of the emails, if you are worried
> about the extra 'if' check in the hot path, then wouldn't this fix it
> for you?
> 
> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> index 3dd4884c6f9e..91d8ec4c8eb7 100644
> --- a/drivers/cpufreq/cpufreq.c
> +++ b/drivers/cpufreq/cpufreq.c
> @@ -517,7 +517,7 @@ unsigned int cpufreq_driver_resolve_freq(struct cpufreq_policy *policy,
>                 return policy->freq_table[idx].frequency;
>         }
>  
> -       if (cpufreq_driver->resolve_freq)
> +       if (likely(cpufreq_driver->resolve_freq))
>                 return cpufreq_driver->resolve_freq(policy, target_freq);
>  
>         return target_freq;

A CPU with good enough branch prediction logic should be able to figure out
whether or not the test is "likely" after a few repetitions of it.

Thanks,
Rafael

