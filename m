From: Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH v3 1/5] PM / OPP: Introduce a power estimation helper
Date: Fri, 1 Feb 2019 12:44:12 +0000
Message-ID: <20190201124412.GF10042@e107155-lin>
References: <20190201093101.31869-1-quentin.perret@arm.com>
 <20190201093101.31869-2-quentin.perret@arm.com>
 <20190201120453.GC10042@e107155-lin>
 <20190201120951.lqxy4u7kxfzfmmub@queper01-lin>
 <20190201122745.GE10042@e107155-lin>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190201122745.GE10042@e107155-lin>
Sender: linux-kernel-owner@vger.kernel.org
To: Quentin Perret <quentin.perret@arm.com>
Cc: viresh.kumar@linaro.org, rjw@rjwysocki.net, nm@ti.com, sboyd@kernel.org, mka@chromium.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, dietmar.eggemann@arm.com
List-Id: linux-pm@vger.kernel.org

On Fri, Feb 01, 2019 at 12:27:45PM +0000, Sudeep Holla wrote:
> On Fri, Feb 01, 2019 at 12:09:53PM +0000, Quentin Perret wrote:
> > Hi Sudeep,
> >
> > On Friday 01 Feb 2019 at 12:04:53 (+0000), Sudeep Holla wrote:
> > > On Fri, Feb 01, 2019 at 09:30:57AM +0000, Quentin Perret wrote:
> > > > +void dev_pm_opp_of_register_em(struct cpumask *cpus, int nr_opp)
> > > > +{
> > > > +	struct em_data_callback em_cb = EM_DATA_CB(_get_cpu_power);
> > > > +	int ret, cpu = cpumask_first(cpus);
> > > > +	struct device *cpu_dev;
> > > > +	struct device_node *np;
> > > > +	u32 cap;
> > > > +
> > > > +	cpu_dev = get_cpu_device(cpu);
> > > > +	if (!cpu_dev)
> > > > +		return;
> > > > +
> > > > +	np = of_node_get(cpu_dev->of_node);
> > > > +	if (!np)
> > > > +		return;
> > > > +
>
> Forgot earlier, you can use of_cpu_device_node_get to combine the above 2.
>

Scratch it, you need cpu_dev anyways. So ignore that.

--
Regards,
Sudeep
