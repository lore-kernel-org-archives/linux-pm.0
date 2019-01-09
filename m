From: Matthias Kaehlcke <mka@chromium.org>
Subject: Re: [PATCH v10 15/15] OPTIONAL: cpufreq: dt: Register an Energy Model
Date: Wed, 9 Jan 2019 10:14:51 -0800
Message-ID: <20190109181451.GT261387@google.com>
References: <20181203095628.11858-1-quentin.perret@arm.com>
 <20181203095628.11858-16-quentin.perret@arm.com>
 <20190108203813.GS261387@google.com>
 <20190109105757.2rowxn3anzyycuod@queper01-lin>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190109105757.2rowxn3anzyycuod@queper01-lin>
Sender: linux-kernel-owner@vger.kernel.org
To: Quentin Perret <quentin.perret@arm.com>
Cc: peterz@infradead.org, rjw@rjwysocki.net, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, gregkh@linuxfoundation.org, mingo@redhat.com, dietmar.eggemann@arm.com, morten.rasmussen@arm.com, chris.redpath@arm.com, patrick.bellasi@arm.com, valentin.schneider@arm.com, vincent.guittot@linaro.org, thara.gopinath@linaro.org, viresh.kumar@linaro.org, tkjos@google.com, joel@joelfernandes.org, smuckle@google.com, adharmap@codeaurora.org, skannan@codeaurora.org, pkondeti@codeaurora.org, juri.lelli@redhat.com, edubezval@gmail.com, srinivas.pandruvada@linux.intel.com, currojerez@riseup.net, javi.merino@kernel.org
List-Id: linux-pm@vger.kernel.org

On Wed, Jan 09, 2019 at 10:57:57AM +0000, Quentin Perret wrote:
> Hi Matthias ,
> 
> On Tuesday 08 Jan 2019 at 12:38:13 (-0800), Matthias Kaehlcke wrote:
> > >  static int cpufreq_init(struct cpufreq_policy *policy)
> > >  {
> > > +	struct em_data_callback em_cb = EM_DATA_CB(of_est_power);
> > >  	struct cpufreq_frequency_table *freq_table;
> > >  	struct opp_table *opp_table = NULL;
> > >  	struct private_data *priv;
> > > @@ -160,7 +203,7 @@ static int cpufreq_init(struct cpufreq_policy *policy)
> > >  	unsigned int transition_latency;
> > >  	bool fallback = false;
> > >  	const char *name;
> > > -	int ret;
> > > +	int ret, nr_opp;
> > >  
> > >  	cpu_dev = get_cpu_device(policy->cpu);
> > >  	if (!cpu_dev) {
> > > @@ -237,6 +280,7 @@ static int cpufreq_init(struct cpufreq_policy *policy)
> > >  		ret = -EPROBE_DEFER;
> > >  		goto out_free_opp;
> > >  	}
> > > +	nr_opp = ret;
> > >  
> > >  	if (fallback) {
> > >  		cpumask_setall(policy->cpus);
> > > @@ -280,6 +324,8 @@ static int cpufreq_init(struct cpufreq_policy *policy)
> > >  	policy->cpuinfo.transition_latency = transition_latency;
> > >  	policy->dvfs_possible_from_any_cpu = true;
> > >  
> > > +	em_register_perf_domain(policy->cpus, nr_opp, &em_cb);
> > 
> > Shouldn't there also be a function to unregister a perf domain to be
> > called from cpufreq_exit()?
> > 
> > ->exit() is called on suspend when the CPUs are taken offline, and
> > ->init() on resume, hence em_register_perf_domain() is called multiple
> > times, but without doing any cleanup.
> 
> Right, but this is safe to do as em_register_perf_domain() checks for
> the existence of the domain straight away. So the second time you call
> this em_register_perf_domain() should just bail out. Are you seeing an
> issue with this ?
> 
> As of now, the EM framework is really simple -- it justs allocates the
> pd tables once during boot, and they stay in memory forever. While
> arguably less than optimal, that makes things a whole lot easier to
> manage on the client side (i.e. the scheduler) w/o needing RCU
> protection or so.

I think registering the perf domain only once is fine, since the info
isn't supposed to change and will likely be used again after
_exit(). However since we have em_cpu_get() I'd suggest to use it and
only call em_register_perf_domain() if no perf domain is registered
yet for the CPU. This makes it more evident that the registration is
only done once and simplifies error handling (currently not done at
all), since it's not necessary to check for the special case -EEXIST.

Cheers

Matthias
