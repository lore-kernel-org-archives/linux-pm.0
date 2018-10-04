From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v7 08/14] sched/topology: Disable EAS on inappropriate
 platforms
Date: Thu, 4 Oct 2018 11:38:48 +0200
Message-ID: <20181004093848.GM19272@hirez.programming.kicks-ass.net>
References: <20180912091309.7551-1-quentin.perret@arm.com>
 <20180912091309.7551-9-quentin.perret@arm.com>
 <20181003162719.GB19252@hirez.programming.kicks-ass.net>
 <20181004091046.7nn2odqrjy7tp5vx@queper01-lin>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181004091046.7nn2odqrjy7tp5vx@queper01-lin>
Sender: linux-kernel-owner@vger.kernel.org
To: Quentin Perret <quentin.perret@arm.com>
Cc: rjw@rjwysocki.net, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, gregkh@linuxfoundation.org, mingo@redhat.com, dietmar.eggemann@arm.com, morten.rasmussen@arm.com, chris.redpath@arm.com, patrick.bellasi@arm.com, valentin.schneider@arm.com, vincent.guittot@linaro.org, thara.gopinath@linaro.org, viresh.kumar@linaro.org, tkjos@google.com, joel@joelfernandes.org, smuckle@google.com, adharmap@codeaurora.org, skannan@codeaurora.org, pkondeti@codeaurora.org, juri.lelli@redhat.com, edubezval@gmail.com, srinivas.pandruvada@linux.intel.com, currojerez@riseup.net, javi.merino@kernel.org
List-Id: linux-pm@vger.kernel.org

On Thu, Oct 04, 2018 at 10:10:48AM +0100, Quentin Perret wrote:
> On Wednesday 03 Oct 2018 at 18:27:19 (+0200), Peter Zijlstra wrote:
> > On Wed, Sep 12, 2018 at 10:13:03AM +0100, Quentin Perret wrote:
> > > @@ -288,6 +321,21 @@ static void build_perf_domains(const struct cpumask *cpu_map)
> > >  			goto free;
> > >  		tmp->next = pd;
> > >  		pd = tmp;
> > > +
> > > +		/*
> > > +		 * Count performance domains and capacity states for the
> > > +		 * complexity check.
> > > +		 */
> > > +		nr_pd++;
> > > +		nr_cs += em_pd_nr_cap_states(pd->obj);
> > > +	}
> > > +
> > > +	/* Bail out if the Energy Model complexity is too high. */
> > > +	if (nr_pd * (nr_cs + nr_cpus) > EM_MAX_COMPLEXITY) {
> > > +		if (sched_debug())
> > > +			pr_info("rd %*pbl: EM complexity is too high\n ",
> > > +						cpumask_pr_args(cpu_map));
> > > +		goto free;
> > >  	}
> > 
> > I would make than an unconditional WARN, we do not really expect that to
> > trigger, but then it does, we really don't want to hide it.
> 
> OTOH that also means that some people with big asymmetric machines can
> get a WARN message every time they boot, and even if they don't want to
> use EAS.
> 
> Now, that shouldn't happen any time soon, so it's maybe a good thing if
> we get reports when/if people start to hit that one, so why not ...

Right, and if becomes a real problem we can think of a solution (like
maybe a DT thingy that says to not use EAS, or a 'better' EAS
algorithm).
