From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 06/10] PM / OPP: Add dev_pm_opp_get_sharing_cpus()
Date: Wed, 27 Apr 2016 08:29:22 +0530
Message-ID: <20160427025922.GC22326@vireshk-i7>
References: <cover.1461228504.git.viresh.kumar@linaro.org>
 <63f1a01a5a5a93a316ce95953efdd320a20a9cc6.1461228504.git.viresh.kumar@linaro.org>
 <20160422222106.GP13149@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f169.google.com ([209.85.192.169]:36126 "EHLO
	mail-pf0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751710AbcD0C70 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 26 Apr 2016 22:59:26 -0400
Received: by mail-pf0-f169.google.com with SMTP id c189so14559942pfb.3
        for <linux-pm@vger.kernel.org>; Tue, 26 Apr 2016 19:59:26 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20160422222106.GP13149@codeaurora.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Stephen Boyd <sboyd@codeaurora.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, arnd.bergmann@linaro.org, andrew@lunn.ch, gregory.clement@free-electrons.com, jason@lakedaemon.net, sebastian.hesselbarth@gmail.com, thomas.petazzoni@free-electrons.com, linux-kernel@vger.kernel.org

On 22-04-16, 15:21, Stephen Boyd wrote:
> On 04/21, Viresh Kumar wrote:
> > diff --git a/drivers/base/power/opp/cpu.c b/drivers/base/power/opp/cpu.c
> > index 55cbf9bd8707..9c4eb90759fb 100644
> > --- a/drivers/base/power/opp/cpu.c
> > +++ b/drivers/base/power/opp/cpu.c
> > @@ -329,3 +329,48 @@ int dev_pm_opp_set_sharing_cpus(struct device *cpu_dev, cpumask_var_t cpumask)
> >  	return ret;
> >  }
> >  EXPORT_SYMBOL_GPL(dev_pm_opp_set_sharing_cpus);
> > +
> > +/**
> > + * dev_pm_opp_get_sharing_cpus() - Get cpumask of CPUs sharing OPPs with @cpu_dev
> > + * @cpu_dev:	CPU device for which we do this operation
> > + * @cpumask:	cpumask to update with information of sharing CPUs
> > + *
> > + * This updates the @cpumask with CPUs that are sharing OPPs with @cpu_dev.
> > + *
> > + * Returns -ENODEV if OPP table isn't already present.
> > + *
> > + * Locking: The internal opp_table and opp structures are RCU protected.
> > + * Hence this function internally uses RCU updater strategy with mutex locks
> > + * to keep the integrity of the internal data structures. Callers should ensure
> > + * that this function is *NOT* called under RCU protection or in contexts where
> > + * mutex cannot be locked.
> > + */
> > +int dev_pm_opp_get_sharing_cpus(struct device *cpu_dev, cpumask_var_t cpumask)
> 
> Is there a reason we use cpumask_var_t instead of struct cpumask *
> here? My understanding is that cpumask_var_t is for stack
> declarations.

Just because we have been using that *consistently* everywhere in cpufreq and
OPP core.

I am fine with cpumask * as well, but we should be consistent.

So, I will keep it cpumask_var_t for this patch, and lets see if we want to
change all occurrences of the same in cpufreq and OPP core.

Sounds reasonable ?

-- 
viresh
