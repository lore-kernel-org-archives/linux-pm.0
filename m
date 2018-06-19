From: Quentin Perret <quentin.perret@arm.com>
Subject: Re: [RFC PATCH v3 10/10] arch_topology: Start Energy Aware Scheduling
Date: Tue, 19 Jun 2018 10:40:03 +0100
Message-ID: <20180619094002.GR17720@e108498-lin.cambridge.arm.com>
References: <20180521142505.6522-1-quentin.perret@arm.com>
 <20180521142505.6522-11-quentin.perret@arm.com>
 <20180619091841.GD9208@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180619091841.GD9208@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Pavan Kondeti <pkondeti@codeaurora.org>
Cc: peterz@infradead.org, rjw@rjwysocki.net, gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, mingo@redhat.com, dietmar.eggemann@arm.com, morten.rasmussen@arm.com, chris.redpath@arm.com, patrick.bellasi@arm.com, valentin.schneider@arm.com, vincent.guittot@linaro.org, thara.gopinath@linaro.org, viresh.kumar@linaro.org, tkjos@google.com, joelaf@google.com, smuckle@google.com, adharmap@quicinc.com, skannan@quicinc.com, juri.lelli@redhat.com, edubezval@gmail.com, srinivas.pandruvada@linux.intel.com, currojerez@riseup.net, javi.merino@kernel.org
List-Id: linux-pm@vger.kernel.org

Hi Pavan,

On Tuesday 19 Jun 2018 at 14:48:41 (+0530), Pavan Kondeti wrote:
> On Mon, May 21, 2018 at 03:25:05PM +0100, Quentin Perret wrote:
> 
> <snip>
> 
> > +static void start_eas_workfn(struct work_struct *work);
> > +static DECLARE_WORK(start_eas_work, start_eas_workfn);
> > +
> >  static int
> >  init_cpu_capacity_callback(struct notifier_block *nb,
> >  			   unsigned long val,
> > @@ -204,6 +209,7 @@ init_cpu_capacity_callback(struct notifier_block *nb,
> >  		free_raw_capacity();
> >  		pr_debug("cpu_capacity: parsing done\n");
> >  		schedule_work(&parsing_done_work);
> > +		schedule_work(&start_eas_work);
> >  	}
> >  
> >  	return 0;
> > @@ -249,6 +255,19 @@ static void parsing_done_workfn(struct work_struct *work)
> >  	free_cpumask_var(cpus_to_visit);
> >  }
> >  
> > +static void start_eas_workfn(struct work_struct *work)
> > +{
> > +	/* Make sure the EM knows about the updated CPU capacities. */
> > +	rcu_read_lock();
> > +	em_rescale_cpu_capacity();
> > +	rcu_read_unlock();
> > +
> > +	/* Inform the scheduler about the EM availability. */
> > +	cpus_read_lock();
> > +	rebuild_sched_domains();
> > +	cpus_read_unlock();
> > +}
> 
> Rebuilding the sched domains is unnecessary for the platform that don't have
> energy-model. In fact, we can completely avoid scheduling this work.

Good point, we might be able to save a little bit of work there.
Now, you will reach this point only if dmips-capacity-mhz values are
specified in DT for you platform, which is usually done only for
big.LITTLE-like Arm platforms. And there are good chances that you want
to have an Energy Model as well for these platforms, so in practice that
won't make a massive difference I suppose ...

> There seems to be a sysfs interface exposed by this driver to change cpu_scale.
> Should we worry about it? I don't know what is the usecase for changing the
> cpu_scale from user space.

This is something I've been wondering as well. TBH, I'm not sure what to
do in this case. And I'm not sure to know what is the use-case either.
Debugging purpose I assume ?

Juri, did you have a specific use-case for this feature when the
arch_topology driver was first introduced ? Or was it just to align
with the existing arm/arm64 code ?

The reason I didn't call the em_rescale_cpu_capacity() function when CPU
capacities are written from sysfs is because that interface allows to have
CPUs with different capacities in the same freq_domain, which is against
the assumptions we have in the EM framework.

> 
> Are we expecting that the energy-model is populated by this time? If it is
> not, should not we build the sched domains again after the energy-model is
> populated?

Yes, the assumption is that drivers have provided the EM by this time.
I'll send a v4 of this patch set very soon with an example of cpufreq
driver modification.

Thanks,
Quentin
