From: Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH v3 1/5] PM / OPP: Introduce a power estimation helper
Date: Fri, 1 Feb 2019 12:27:45 +0000
Message-ID: <20190201122745.GE10042@e107155-lin>
References: <20190201093101.31869-1-quentin.perret@arm.com>
 <20190201093101.31869-2-quentin.perret@arm.com>
 <20190201120453.GC10042@e107155-lin>
 <20190201120951.lqxy4u7kxfzfmmub@queper01-lin>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190201120951.lqxy4u7kxfzfmmub@queper01-lin>
Sender: linux-kernel-owner@vger.kernel.org
To: Quentin Perret <quentin.perret@arm.com>
Cc: viresh.kumar@linaro.org, rjw@rjwysocki.net, nm@ti.com, sboyd@kernel.org, mka@chromium.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, dietmar.eggemann@arm.com
List-Id: linux-pm@vger.kernel.org

On Fri, Feb 01, 2019 at 12:09:53PM +0000, Quentin Perret wrote:
> Hi Sudeep,
>
> On Friday 01 Feb 2019 at 12:04:53 (+0000), Sudeep Holla wrote:
> > On Fri, Feb 01, 2019 at 09:30:57AM +0000, Quentin Perret wrote:
> > > +void dev_pm_opp_of_register_em(struct cpumask *cpus, int nr_opp)
> > > +{
> > > +	struct em_data_callback em_cb = EM_DATA_CB(_get_cpu_power);
> > > +	int ret, cpu = cpumask_first(cpus);
> > > +	struct device *cpu_dev;
> > > +	struct device_node *np;
> > > +	u32 cap;
> > > +
> > > +	cpu_dev = get_cpu_device(cpu);
> > > +	if (!cpu_dev)
> > > +		return;
> > > +
> > > +	np = of_node_get(cpu_dev->of_node);
> > > +	if (!np)
> > > +		return;
> > > +

Forgot earlier, you can use of_cpu_device_node_get to combine the above 2.

> >
> > Does it make sense to add the check for OPP count here. You need not pass
> > that as parameter. Just makes one less thing to check in new drivers adding
> > this support. Thoughts ?
>
> Yeah Matthias had the same suggestion. I don't mind moving it here TBH.
> It's just that some users already do the opp count before calling this
> function, so I figured I could as well use that data instead of counting
> again.
>

Indeed, I was under same opinion after seeing in 2 patches and then 3rd
made me think why not. Also since you fetch cpu_dev already there, it
should be fine.

> But yeah, that's one less thing to worry about on the driver side so
> I'll move the OPP count in there for v4 and we'll see if people ask me
> to move it out to optimize things ;-)
>

Yes, but I will leave it to Viresh's taste :)

--
Regards,
Sudeep
