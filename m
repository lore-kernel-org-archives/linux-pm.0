From: Quentin Perret <quentin.perret@arm.com>
Subject: Re: [RFC PATCH v3 03/10] PM: Introduce an Energy Model management
 framework
Date: Wed, 6 Jun 2018 17:59:46 +0100
Message-ID: <20180606165946.GK10870@e108498-lin.cambridge.arm.com>
References: <20180521142505.6522-1-quentin.perret@arm.com>
 <20180521142505.6522-4-quentin.perret@arm.com>
 <20180606164734.GC15894@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180606164734.GC15894@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
To: Juri Lelli <juri.lelli@redhat.com>
Cc: peterz@infradead.org, rjw@rjwysocki.net, gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, mingo@redhat.com, dietmar.eggemann@arm.com, morten.rasmussen@arm.com, chris.redpath@arm.com, patrick.bellasi@arm.com, valentin.schneider@arm.com, vincent.guittot@linaro.org, thara.gopinath@linaro.org, viresh.kumar@linaro.org, tkjos@google.com, joelaf@google.com, smuckle@google.com, adharmap@quicinc.com, skannan@quicinc.com, pkondeti@codeaurora.org, edubezval@gmail.com, srinivas.pandruvada@linux.intel.com, currojerez@riseup.net, javi.merino@kernel.org
List-Id: linux-pm@vger.kernel.org

On Wednesday 06 Jun 2018 at 18:47:34 (+0200), Juri Lelli wrote:
> Hi Quentin,
> 
> On 21/05/18 15:24, Quentin Perret wrote:
> 
> [...]
> 
> > +#ifdef CONFIG_ENERGY_MODEL
> 
> [...]
> 
> > +struct em_data_callback {
> > +	/**
> > +	 * active_power() - Provide power at the next capacity state of a CPU
> > +	 * @power	: Active power at the capacity state (modified)
> > +	 * @freq	: Frequency at the capacity state (modified)
> > +	 * @cpu		: CPU for which we do this operation
> > +	 *
> > +	 * active_power() must find the lowest capacity state of 'cpu' above
> > +	 * 'freq' and update 'power' and 'freq' to the matching active power
> > +	 * and frequency.
> > +	 *
> > +	 * Return 0 on success.
> > +	 */
> > +	int (*active_power) (unsigned long *power, unsigned long *freq, int cpu);
> > +};
> 
> [...]
> 
> > +#else
> > +struct em_freq_domain;
> > +struct em_data_callback;
> 
> This doesn't compile for CONFIG_ENERGY_MODEL=n:
> 
> drivers/cpufreq/cpufreq-dt.c:164:9: error: variable 'em_cb' has initializer but incomplete type                                                          
>   struct em_data_callback em_cb = { &dev_pm_opp_of_estimate_power };                       
>            ^~~~~~~~~~~~~~~~

Ah, this is an issue with a patch which isn't part of this patch-set ...
But yeah, that's a valid point :-)

> Guess you need some sort of macro to init the struct (w/o introducing
> ifdeffery into drivers code)?

Yes, the EM framework should provide a generic way of doing this
initialization with nice stubs for CONFIG_ENERGY_MODEL=n, otherwise we
risk wild fixes in the drivers I suppose. I'll fix that in v4.

Thanks for pointing that out !
Quentin
