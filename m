From: Matthias Kaehlcke <mka@chromium.org>
Subject: Re: [PATCH v3 1/5] PM / OPP: Introduce a power estimation helper
Date: Fri, 1 Feb 2019 10:16:24 -0800
Message-ID: <20190201181624.GQ81583@google.com>
References: <20190201093101.31869-1-quentin.perret@arm.com>
 <20190201093101.31869-2-quentin.perret@arm.com>
 <20190201120453.GC10042@e107155-lin>
 <20190201120951.lqxy4u7kxfzfmmub@queper01-lin>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20190201120951.lqxy4u7kxfzfmmub@queper01-lin>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Quentin Perret <quentin.perret@arm.com>
Cc: nm@ti.com, linux-pm@vger.kernel.org, sboyd@kernel.org, viresh.kumar@linaro.org, rjw@rjwysocki.net, linux-kernel@vger.kernel.org, Sudeep Holla <sudeep.holla@arm.com>, dietmar.eggemann@arm.com, linux-arm-kernel@lists.infradead.org
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
> But yeah, that's one less thing to worry about on the driver side so
> I'll move the OPP count in there for v4 and we'll see if people ask me
> to move it out to optimize things ;-)

>From an API perspective it would be nice to get rid of the nr_opp
parameter, it seems somewhat arbitrary. Moving dev_pm_opp_get_opp_count()
from the drivers into dev_pm_opp_of_register_em() (instead of calling
it twice) also sounds good in general, as long as the error handling
doesn't become too messy. In the current version
dev_pm_opp_of_register_em() doesn't return a value, with the change it
would have to return one to catch an empty OPP table, and it needs
to be distinguished from other cases where the EM registration fails
but the cpufreq driver is still functional (e.g. no
'dynamic-power-coefficient'). Maybe return -ENOTSUPP in those cases?

Well, let's see how it looks like :)
