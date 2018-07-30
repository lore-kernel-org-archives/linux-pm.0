From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: Re: [PATCH 4/4] cpufreq: intel_pstate: enable boost for Skylake Xeon
Date: Mon, 30 Jul 2018 06:38:46 -0700
Message-ID: <3d2b0725feb67a270e7976d191b65acaf14315fe.camel@linux.intel.com>
References: <20180605214242.62156-1-srinivas.pandruvada@linux.intel.com>
         <20180605214242.62156-5-srinivas.pandruvada@linux.intel.com>
         <87bmarhqk4.fsf@riseup.net>
         <3afad4b13370fe0ba6ed5020f86ce1b8ff46c603.camel@linux.intel.com>
         <e1dab3e0-3e75-b50d-7e50-13dc752150c4@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <e1dab3e0-3e75-b50d-7e50-13dc752150c4@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Eero Tamminen <eero.t.tamminen@intel.com>, Francisco Jerez <currojerez@riseup.net>, lenb@kernel.org, rjw@rjwysocki.net, mgorman@techsingularity.net
Cc: peterz@infradead.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, juri.lelli@redhat.com, viresh.kumar@linaro.org, ggherdovich@suse.cz, Chris Wilson <chris@chris-wilson.co.uk>, Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>, Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
List-Id: linux-pm@vger.kernel.org

Hi Eero,
On Mon, 2018-07-30 at 11:33 +0300, Eero Tamminen wrote:
> Hi,
> 
> On 28.07.2018 17:14, Srinivas Pandruvada wrote:
> > On Fri, 2018-07-27 at 22:34 -0700, Francisco Jerez wrote:
> > > Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com> writes:
> > > 
> > > > Enable HWP boost on Skylake server and workstations.
> > > > 
> > > 
> > > Please revert this series, it led to significant energy usage and
> > > graphics performance regressions [1].
> > 
> > Which SKX platform is targeted to graphics?
> 
> Patch that Chris pointed out is this:
> +static const struct x86_cpu_id intel_pstate_hwp_boost_ids[] = {
> +       ICPU(INTEL_FAM6_SKYLAKE_X, core_funcs),
> +       ICPU(INTEL_FAM6_SKYLAKE_DESKTOP, core_funcs),
> +       {}
> +};
> 
> The regressing platforms in our test system were:
> - SKL 6600K i5 / GT2
> - SKL 6770HQ i7 / GT4e
> 
> SKL-U i5 / GT3e device wasn't impacted, so I assume U devices don't 
> match INTEL_FAM6_SKYLAKE_DESKTOP.

I have updated some steps in the bugzilla. Can you try that?
Also add one workload which will show this issue immediately including
any parameters you need to add.

Thanks,
Srinivas


> 
> 
> 
> 	- Eero
> 
> > >   The reasons are roughly the ones
> > > we discussed by e-mail off-list last April: This causes the
> > > intel_pstate
> > > driver to decrease the EPP to zero
> > 
> > No. You didn't check this series. We are not using EPP at all.
> > The boost mechanism used here is not boost to max.
> > 
> > Thanks,
> > Srinivas
> > 
> > > when the workload blocks on IO
> > > frequently enough, which for the regressing benchmarks detailed
> > > in
> > > [1]
> > > is a symptom of the workload being heavily IO-bound, which means
> > > they
> > > won't benefit at all from the EPP boost since they aren't
> > > significantly
> > > CPU-bound, and they will suffer a decrease in parallelism due to
> > > the
> > > active CPU core using a larger fraction of the TDP in order to
> > > achieve
> > > the same work, causing the GPU to have a lower power budget
> > > available,
> > > leading to a decrease in system performance.
> > > 
> > > You may want to give a shot to my previous suggestion of using
> > > [2] in
> > > order to detect whether the system is IO-bound, which you can use
> > > as
> > > an
> > > indicator that the optimization implemented in this series cannot
> > > possibly improve performance and can be expected to hurt energy
> > > usage.
> > > 
> > > Thanks.
> > > 
> > > [1] https://bugs.freedesktop.org/show_bug.cgi?id=107410
> > > [2] https://patchwork.kernel.org/patch/10312259/
> > > 
> > > > Reported-by: Mel Gorman <mgorman@techsingularity.net>
> > > > Tested-by: Giovanni Gherdovich <ggherdovich@suse.cz>
> > > > Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.i
> > > > ntel
> > > > .com>
> > > > ---
> > > >   drivers/cpufreq/intel_pstate.c | 10 ++++++++++
> > > >   1 file changed, 10 insertions(+)
> > > > 
> > > > diff --git a/drivers/cpufreq/intel_pstate.c
> > > > b/drivers/cpufreq/intel_pstate.c
> > > > index 70bf63bb4e0e..01c8da1f99db 100644
> > > > --- a/drivers/cpufreq/intel_pstate.c
> > > > +++ b/drivers/cpufreq/intel_pstate.c
> > > > @@ -1794,6 +1794,12 @@ static const struct x86_cpu_id
> > > > intel_pstate_cpu_ee_disable_ids[] = {
> > > >   	{}
> > > >   };
> > > >   
> > > > +static const struct x86_cpu_id intel_pstate_hwp_boost_ids[]
> > > > __initconst = {
> > > > +	ICPU(INTEL_FAM6_SKYLAKE_X, core_funcs),
> > > > +	ICPU(INTEL_FAM6_SKYLAKE_DESKTOP, core_funcs),
> > > > +	{}
> > > > +};
> > > > +
> > > >   static int intel_pstate_init_cpu(unsigned int cpunum)
> > > >   {
> > > >   	struct cpudata *cpu;
> > > > @@ -1824,6 +1830,10 @@ static int
> > > > intel_pstate_init_cpu(unsigned
> > > > int cpunum)
> > > >   			intel_pstate_disable_ee(cpunum);
> > > >   
> > > >   		intel_pstate_hwp_enable(cpu);
> > > > +
> > > > +		id =
> > > > x86_match_cpu(intel_pstate_hwp_boost_ids);
> > > > +		if (id)
> > > > +			hwp_boost = true;
> > > >   	}
> > > >   
> > > >   	intel_pstate_get_cpu_pstates(cpu);
> > > > -- 
> > > > 2.13.6
> 
> 
