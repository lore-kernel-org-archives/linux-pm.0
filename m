From: Quentin Perret <quentin.perret@arm.com>
Subject: Re: [PATCH v3 4/5] cpufreq: arm_big_little: Register an Energy Model
Date: Fri, 1 Feb 2019 12:11:25 +0000
Message-ID: <20190201121123.ir4iodxj6iovsknn@queper01-lin>
References: <20190201093101.31869-1-quentin.perret@arm.com>
 <20190201093101.31869-5-quentin.perret@arm.com>
 <20190201115357.GB10042@e107155-lin>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190201115357.GB10042@e107155-lin>
Sender: linux-kernel-owner@vger.kernel.org
To: Sudeep Holla <sudeep.holla@arm.com>
Cc: viresh.kumar@linaro.org, rjw@rjwysocki.net, nm@ti.com, sboyd@kernel.org, mka@chromium.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, dietmar.eggemann@arm.com
List-Id: linux-pm@vger.kernel.org

On Friday 01 Feb 2019 at 11:53:57 (+0000), Sudeep Holla wrote:
> On Fri, Feb 01, 2019 at 09:31:00AM +0000, Quentin Perret wrote:
> > From: Dietmar Eggemann <dietmar.eggemann@arm.com>
> >
> > Now that PM_OPP provides a helper function to estimate the power
> > consumed by CPUs, make sure to try and register an Energy Model (EM)
> > from the arm_big_little CPUFreq driver, hence ensuring interested
> > subsystems (the task scheduler, for example) can make use of that
> > information when available.
> >
> > Signed-off-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
> > Signed-off-by: Quentin Perret <quentin.perret@arm.com>
> > ---
> >  drivers/cpufreq/arm_big_little.c | 8 ++++++++
> >  1 file changed, 8 insertions(+)
> >
> > diff --git a/drivers/cpufreq/arm_big_little.c b/drivers/cpufreq/arm_big_little.c
> > index cf62a1f64dd7..18b05bcb2614 100644
> > --- a/drivers/cpufreq/arm_big_little.c
> > +++ b/drivers/cpufreq/arm_big_little.c
> > @@ -487,6 +487,14 @@ static int bL_cpufreq_init(struct cpufreq_policy *policy)
> >  	policy->cpuinfo.transition_latency =
> >  				arm_bL_ops->get_transition_latency(cpu_dev);
> >
> > +	ret = dev_pm_opp_get_opp_count(cpu_dev);
> > +	if (ret <= 0) {
> > +		dev_dbg(cpu_dev, "OPP table is not ready, deferring probe\n");
> > +		return -EPROBE_DEFER;
> > +	}
> 
> The only user of this has the check in init_opp_table that gets called from
> get_cluster_clk_and_freq_table. So the above is not necessary, you can drop
> it.

Will do.

Thanks,
Quentin
