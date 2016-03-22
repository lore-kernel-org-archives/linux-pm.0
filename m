From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH 3/3] cpufreq: Always update current frequency before startig governor
Date: Tue, 22 Mar 2016 15:33:19 +0100
Message-ID: <7982875.5daSm6IB7M@vostro.rjw.lan>
References: <1780622.pJaGsuQWcI@vostro.rjw.lan> <1847835.ROHO9MEN8J@vostro.rjw.lan> <20160322033032.GT27778@vireshk-i7>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:60287 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1757881AbcCVObK (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 22 Mar 2016 10:31:10 -0400
In-Reply-To: <20160322033032.GT27778@vireshk-i7>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Linux PM list <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On Tuesday, March 22, 2016 09:00:32 AM Viresh Kumar wrote:
> On 21-03-16, 15:47, Rafael J. Wysocki wrote:
> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > 
> > Make policy->cur match the current frequency returned by the driver's
> > ->get() callback before starting the governor in case they went out of
> > sync in the meantime and drop the piece of code attempting to
> > resync policy->cur with the real frequency of the boot CPU from
> > cpufreq_resume() as it serves no purpose any more (and it's racy and
> > super-ugly anyway).
> > 
> > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > ---
> >  drivers/cpufreq/cpufreq.c |   14 +++-----------
> >  1 file changed, 3 insertions(+), 11 deletions(-)
> > 
> > Index: linux-pm/drivers/cpufreq/cpufreq.c
> > ===================================================================
> > --- linux-pm.orig/drivers/cpufreq/cpufreq.c
> > +++ linux-pm/drivers/cpufreq/cpufreq.c
> > @@ -1680,17 +1680,6 @@ void cpufreq_resume(void)
> >  				       __func__, policy);
> >  		}
> >  	}
> > -
> > -	/*
> > -	 * schedule call cpufreq_update_policy() for first-online CPU, as that
> > -	 * wouldn't be hotplugged-out on suspend. It will verify that the
> > -	 * current freq is in sync with what we believe it to be.
> > -	 */
> > -	policy = cpufreq_cpu_get_raw(cpumask_first(cpu_online_mask));
> > -	if (WARN_ON(!policy))
> > -		return;
> > -
> > -	schedule_work(&policy->update);
> >  }
> >  
> >  /**
> > @@ -2062,6 +2051,9 @@ static int cpufreq_start_governor(struct
> >  {
> >  	int ret;
> >  
> > +	if (cpufreq_driver->get && !cpufreq_driver->setpolicy)
> > +		cpufreq_update_current_freq(policy);
> > +
> >  	ret = cpufreq_governor(policy, CPUFREQ_GOV_START);
> >  	return ret ? ret : cpufreq_governor(policy, CPUFREQ_GOV_LIMITS);
> >  }
> 
> This looks fine, but I am searching for answers to few doubts, maybe
> you can help..
> 
> Why we did the same in process context earlier? And why it wouldn't be
> a problem now, when we do it in interrupt context? Will IRQs be
> disabled here? If so, then will you hit following ?

I'm not sure I'm following.

This is process context too.

Look at the call sites of cpufreq_start_governor() (patch [1/3]):
- cpufreq_offline() - process context
- cpufreq_resume() - process context
- cpufreq_set_policy() - process context
- cpufreq_add_policy_cpu() - process context

Besides, calling cpufreq_governor() from interrupt context wouldn't reall work,
because that acquires mutexes etc, like in cpufreq_governor_init().

> static void __cpufreq_notify_transition(struct cpufreq_policy *policy,
> 		struct cpufreq_freqs *freqs, unsigned int state)
> {
> 	BUG_ON(irqs_disabled());
> 
> ...
> }
> 
> And will calling notifiers from interrupt-context just fine ?

If your question is why the original code doesn't call cpufreq_update_policy()
directly, I think the reason is because cpufreq_resume() used to be one of the
syscore ops and *that* would have been run in interrupt context.

Thanks,
Rafael

