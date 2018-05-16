From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: Re: [RFC/RFT] [PATCH 05/10] cpufreq: intel_pstate: HWP boost
 performance on IO Wake
Date: Wed, 16 May 2018 10:55:13 -0700
Message-ID: <1526493313.61700.61.camel@linux.intel.com>
References: <20180516044911.28797-1-srinivas.pandruvada@linux.intel.com>
         <20180516044911.28797-6-srinivas.pandruvada@linux.intel.com>
         <20180516073701.GW12217@hirez.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180516073701.GW12217@hirez.programming.kicks-ass.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>
Cc: tglx@linutronix.de, mingo@redhat.com, bp@suse.de, lenb@kernel.org, rjw@rjwysocki.net, mgorman@techsingularity.net, x86@kernel.org, linux-pm@vger.kernel.org, viresh.kumar@linaro.org, juri.lelli@arm.com, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Wed, 2018-05-16 at 09:37 +0200, Peter Zijlstra wrote:
> On Tue, May 15, 2018 at 09:49:06PM -0700, Srinivas Pandruvada wrote:

[...]

> > 
@@ -258,6 +261,8 @@ struct cpudata {
> >  	s16 epp_saved;
> >  	u64 hwp_req_cached;
> >  	call_single_data_t csd;
> > +	bool hwp_boost_active;
> > +	u64 last_io_update;
> 
> This structure has abysmal layout; you should look at that.
> Also, mandatory complaint about using _Bool in composites.
> 
I will take care about this in next version.

[...]

> > +/* Default: This will roughly around P1 on SKX */
> > +#define BOOST_PSTATE_THRESHOLD	(SCHED_CAPACITY_SCALE / 2)
> 
> Yuck.. why the need to hardcode this? Can't you simply read the P1
> value
> for the part at hand?
Done later in the series. So need to reorder.

[..]
> 
+	if (cpu->iowait_boost) {
> > +		cpu->hwp_boost_active = true;
> > +		if (smp_processor_id() == cpu->cpu)
> > +			intel_pstate_hwp_boost_up(cpu);
> > +		else
> > +			smp_call_function_single_async(cpu->cpu,
> > &cpu->csd);
> > +	}
> >  }
> 
> Hurmph, this looks like you're starting to duplicate the schedutil
> iowait logic. Why didn't you copy the gradual boosting thing?
I tried what we implemented in intel_pstate in legacy mode, which gave
the best performance for servers (ramp up faster and slow ramp down).
This caused regression on some workloads, as each time we can call
HWP_REQUEST, we spend 1200+ cycles in issuing MSR. So keeping it at max
for timeout. Even keeping at P1 didn't help in power numbers.
