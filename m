From: Juri Lelli <juri.lelli@redhat.com>
Subject: Re: [PATCH v8 10/15] sched: Introduce a sysctl for Energy Aware
 Scheduling
Date: Tue, 16 Oct 2018 15:46:36 +0200
Message-ID: <20181016134636.GE9130@localhost.localdomain>
References: <20181016101513.26919-1-quentin.perret@arm.com>
 <20181016101513.26919-11-quentin.perret@arm.com>
 <20181016125058.GD9130@localhost.localdomain>
 <20181016133451.w2y3gwj2c56cvy5c@queper01-lin>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181016133451.w2y3gwj2c56cvy5c@queper01-lin>
Sender: linux-kernel-owner@vger.kernel.org
To: Quentin Perret <quentin.perret@arm.com>
Cc: peterz@infradead.org, rjw@rjwysocki.net, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, gregkh@linuxfoundation.org, mingo@redhat.com, dietmar.eggemann@arm.com, morten.rasmussen@arm.com, chris.redpath@arm.com, patrick.bellasi@arm.com, valentin.schneider@arm.com, vincent.guittot@linaro.org, thara.gopinath@linaro.org, viresh.kumar@linaro.org, tkjos@google.com, joel@joelfernandes.org, smuckle@google.com, adharmap@codeaurora.org, skannan@codeaurora.org, pkondeti@codeaurora.org, edubezval@gmail.com, srinivas.pandruvada@linux.intel.com, currojerez@riseup.net, javi.merino@kernel.org
List-Id: linux-pm@vger.kernel.org

On 16/10/18 14:36, Quentin Perret wrote:
> Hi,
> 
> On Tuesday 16 Oct 2018 at 14:50:58 (+0200), Juri Lelli wrote:
> > Hi,
> > 
> > On 16/10/18 11:15, Quentin Perret wrote:
> > 
> > [...]
> > 
> > > diff --git a/kernel/sysctl.c b/kernel/sysctl.c
> > > index cc02050fd0c4..481309a11174 100644
> > > --- a/kernel/sysctl.c
> > > +++ b/kernel/sysctl.c
> > > @@ -466,6 +466,17 @@ static struct ctl_table kern_table[] = {
> > >  		.extra1		= &one,
> > >  	},
> > >  #endif
> > > +#if defined(CONFIG_ENERGY_MODEL) && defined(CONFIG_CPU_FREQ_GOV_SCHEDUTIL)
> > > +	{
> > > +		.procname	= "sched_energy_aware",
> > > +		.data		= &sysctl_sched_energy_aware,
> > > +		.maxlen		= sizeof(unsigned int),
> > > +		.mode		= 0644,
> > > +		.proc_handler	= sched_energy_aware_handler,
> > > +		.extra1		= &zero,
> > > +		.extra2		= &one,
> > > +	},
> > > +#endif
> > 
> > Doesn't this need to be documented in Documentation/sysctl/kernel.txt?
> 
> Right, that'd be a good practice indeed. What do you think about the
> patch below ?

LGTM.

> > Also, do we want a kernel parameter as well to be able to disable this
> > at boot?
> 
> Yeah, why not. But I guess we could always add that later if need be ?

Sure. Works with me.

Thanks,

- Juri
