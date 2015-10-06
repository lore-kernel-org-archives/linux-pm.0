From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: Re: [PATCH v3 1/6] cpufreq: intel_p_state: Fix limiting turbo sub
 states
Date: Mon, 05 Oct 2015 17:43:05 -0700
Message-ID: <1444092185.17895.99.camel@spandruv-desk3.jf.intel.com>
References: <1443567248-27134-1-git-send-email-srinivas.pandruvada@linux.intel.com>
	 <1443567248-27134-2-git-send-email-srinivas.pandruvada@linux.intel.com>
	 <1962931.XZqpddDuF8@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:8892 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751139AbbJFAni (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Mon, 5 Oct 2015 20:43:38 -0400
In-Reply-To: <1962931.XZqpddDuF8@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: kristen.c.accardi@intel.com, rafael.j.wysocki@intel.com, len.brown@intel.com, linux-pm@vger.kernel.org

On Tue, 2015-10-06 at 00:56 +0200, Rafael J. Wysocki wrote:
> On Tuesday, September 29, 2015 03:54:03 PM Srinivas Pandruvada wrote:
> > Although the max_perf_pct reflects sub states in turbo range, we can't
> > really restrict to those states. This gives wrong impression that the
> > performance is reduced.
> > This can be achieved by restricting turbo ratio limits (MSR 0x1AD),
> > when bit 28 of platform info MSR allows (MSR 0xCE) is 1.
> > 
> > Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> > ---
> >  drivers/cpufreq/intel_pstate.c | 92 +++++++++++++++++++++++++++++++++++++++++-
> >  1 file changed, 91 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
> > index 3af9dd7..576d9e8 100644
> > --- a/drivers/cpufreq/intel_pstate.c
> > +++ b/drivers/cpufreq/intel_pstate.c
> > @@ -80,6 +80,7 @@ struct pstate_data {
> >  	int	max_pstate;
> >  	int	scaling;
> >  	int	turbo_pstate;
> > +	u64	turbo_ratio_limit;
> 
> Why does it have to be u64?
turbo ratio limit is 64 bit value. On some models it will show ratio
when up to 8 cores active like in Xeon E5 v3(SDM Table 35-27).
> 
> >  };
> >  
> >  struct vid_data {
> > @@ -132,6 +133,8 @@ struct pstate_funcs {
> >  	int (*get_scaling)(void);
> >  	void (*set)(struct cpudata*, int pstate);
> >  	void (*get_vid)(struct cpudata *);
> > +	u64 (*get_turbo_ratio_limit)(struct cpudata *);
> > +	int (*set_turbo_ratio_limit)(struct cpudata *, u64, u64);
> 
> An int is always passed as the last arg to this, so why is the arg u64?
> 
> >  };
> >  
> >  struct cpu_defaults {
> > @@ -434,6 +437,23 @@ static ssize_t store_max_perf_pct(struct kobject *a, struct attribute *b,
> >  	limits.max_perf_pct = max(limits.min_perf_pct, limits.max_perf_pct);
> >  	limits.max_perf = div_fp(int_tofp(limits.max_perf_pct), int_tofp(100));
> >  
> > +	if (pstate_funcs.set_turbo_ratio_limit) {
> > +		int max_perf_adj;
> > +		struct cpudata *cpu = all_cpu_data[0];
> > +
> > +		if (limits.max_sysfs_pct == 100)
> > +			max_perf_adj = cpu->pstate.turbo_ratio_limit;
> 
> This will cast the u64 to int anyway.
I shouldn't have casted to int here, it will take care upto 4 core max
only. But not sure people using Xeons want to reduce turbo range.
> 
> Also this is going to be the value read from the register at init which is
> likely to be greater than 255 ->
> 
yes
> > +		else
> > +			max_perf_adj = fp_toint(mul_fp(int_tofp(
> > +					cpu->pstate.turbo_ratio_limit & 0xff),
> > +					limits.max_perf));
> 
> -> but this will never be greater than 255 if I'm not mistaken (limits.max_perf
> is a representation of a fraction between 0 and 1 and the first value is
> bounded by 255).
limits.max_perf is a value between 0 and 255 (E.g. 100%=255, 90% 230).
max_perf_adj will be scaled ratio based on limits.max_perf (E.g. if 1
core max ratio is 1d, and max_perf is 230 (90%), then max_perf_adj = 1a)
BTW I didn't invent this magic formula, it is copied from  existing
function intel_pstate_get_min_max.
> 
> How are these two values related to each other?
refer to above explanation.
> > +
> > +		if (max_perf_adj > cpu->pstate.max_pstate)
> > +			pstate_funcs.set_turbo_ratio_limit(cpu,
> > +						cpu->pstate.turbo_ratio_limit,
> > +						max_perf_adj);
> 
> I'm not really sure what this is supposed to achieve.  Care to explain a bit?
We only care to set turbo ratio only when user ask to set ratio which is
turbo range. Anything more than cpu->pstate.max_pstate is turbo range
(as this value stores the maximum non turbo ratio)

> 
> [BTW, the first arg of core_set/get_turbo_ratio_limit(() is never used, so why
> bother with passing it at all?]
> 
To be consistent with the current .set pstate functions. We don't use. I
can remove.
> > +	}
> > +
> >  	if (hwp_active)
> >  		intel_pstate_hwp_set();
> >  	return count;
> > @@ -628,6 +648,55 @@ static void core_set_pstate(struct cpudata *cpudata, int pstate)
> >  	wrmsrl_on_cpu(cpudata->cpu, MSR_IA32_PERF_CTL, val);
> >  }
> >  
> > +static u64 core_get_turbo_ratio_limit(struct cpudata *cpudata)
> > +{
> > +	u64 value;
> > +
> > +	rdmsrl(MSR_NHM_TURBO_RATIO_LIMIT, value);
> > +
> > +	return value;
> > +}
> > +
> > +static int core_set_turbo_ratio_limit(struct cpudata *cpudata, u64 def_ratio,
> > +			       u64 new_ratio)
> > +{
> > +	u64 value;
> > +
> 
> What should happen if def_ratio and new_ratio are the same?
> 
It will not change the resultant, but we could have avoid loop below. I
can add a check here  to return.
> > +	rdmsrl(MSR_PLATFORM_INFO, value);
> > +	if (value & BIT(28)) {
> > +		u64 ratio = 0;
> > +		u64 out_ratio = 0;
> > +		u8 max_ratio = new_ratio & 0xff;
> 
> Why u8?
1C max ratio is the maximum value any ratio can have, which is stored in
first byte.
> > +		int i;
> > +		/*
> > +		 * If caller provided reduced max ratio (one core active)
> > +		 * then use this for all other ratios, which are more
> > +		 * than the default ratio for those many cores active
> > +		 * for example if default ratio is 0x1a1b1c1d and new ratio
> > +		 * is 0x1b, then resultant ratio will be 0x1a1b1b1b
> > +		 */
> 
> This is a bit messy IMO. 
Yes.
>  Instead of shifting def_ratio and new_ratio in each
> step, I'd shift max_ratio and the mask:
> 
> 	u64 mask = 0xff;
> 	u64 max_ratio = new_ratio & mask;
> 
> 	while (mask) {
> 		if (def_ratio & mask) {
> 			u64 ratio;
> 
> 			if (new_ratio & mask) {
> 				ratio = new_ratio & mask;
> 			} else {
> 				ratio = def_ratio & mask;
> 				if (ratio > max_ratio)
> 					ratio = max_ratio;
> 			}
> 			out_ratio |= ratio;
> 		}
> 		max_ratio <<= 8;
> 		mask <<= 8;
> 	}
> 
I will experiment with your algorithm and check.

> [I'm not sure why the least significant byte of new_ratio is special, though.]
> 
LS Byte is the max turbo you can ever achieve as this ratio is for 1
core active turbo.
> > +		for (i = 0; i < sizeof(def_ratio); ++i) {
> > +			if (def_ratio & 0xff) {
> > +				if (new_ratio & 0xff)
> > +					ratio = new_ratio & 0xff;
> > +				else {
> > +					if ((def_ratio & 0xff) > max_ratio)
> > +						ratio = max_ratio;
> > +					else
> > +						ratio = def_ratio & 0xff;
> > +				}
> > +				out_ratio |= (ratio << (i * 8));
> > +			}
> > +			def_ratio >>= 8;
> > +			new_ratio >>= 8;
> > +		}
> > +		wrmsrl(MSR_NHM_TURBO_RATIO_LIMIT, out_ratio);
> > +		return 0;
> > +	}
> > +
> > +	return -EPERM;
> 
> Why -EPERM?
> 
> That's not because the user has no permission to carry out the opreration, but
> because there is no capability, right?
> 
Yes. Is there any better error code?
> > +}
> > +
> >  static int knl_get_turbo_pstate(void)
> >  {
> >  	u64 value;
> > @@ -656,6 +725,8 @@ static struct cpu_defaults core_params = {
> >  		.get_turbo = core_get_turbo_pstate,
> >  		.get_scaling = core_get_scaling,
> >  		.set = core_set_pstate,
> > +		.get_turbo_ratio_limit = core_get_turbo_ratio_limit,
> > +		.set_turbo_ratio_limit = core_set_turbo_ratio_limit,
> >  	},
> >  };
> >  
> > @@ -745,7 +816,10 @@ static void intel_pstate_get_cpu_pstates(struct cpudata *cpu)
> >  	cpu->pstate.max_pstate = pstate_funcs.get_max();
> >  	cpu->pstate.turbo_pstate = pstate_funcs.get_turbo();
> >  	cpu->pstate.scaling = pstate_funcs.get_scaling();
> > -
> > +	if (pstate_funcs.get_turbo_ratio_limit &&
> > +	    !cpu->pstate.turbo_ratio_limit)
> > +		cpu->pstate.turbo_ratio_limit =
> > +			pstate_funcs.get_turbo_ratio_limit(cpu);
> 
> So we read MSR_NHM_TURBO_RATIO_LIMIT and store it into pstate.turbo_ratio_limit
> unless alread populated.  This means we do it only once during initialization.
> 
> What if the value we have in there is stale after, say, system suspend-resume?
> 
Did I mess up here? You mean data stored in a variable
cpu->pstate.turbo_ratio_limit is corrupted after suspend/resume. This is
a vzalloc memory.. 
all_cpu_data = vzalloc(sizeof(void *) * num_possible_cpus()) one time
during __init intel_pstate_init
We re-adjust the ratio value after suspend/resume from the value stored
during init if user has changed this, because msr will be reset to
default after resume.
> Don't we need to re-adjust then?
> 
> >  	if (pstate_funcs.get_vid)
> >  		pstate_funcs.get_vid(cpu);
> >  	intel_pstate_set_pstate(cpu, cpu->pstate.min_pstate, false);
> > @@ -949,6 +1023,20 @@ static int intel_pstate_init_cpu(unsigned int cpunum)
> >  		intel_pstate_hwp_enable(cpu);
> >  
> >  	intel_pstate_get_cpu_pstates(cpu);
> > +	/* readjust turbo limit ratio after resume or hotplug */
> > +	if (limits.max_sysfs_pct != 100 &&
> > +	    pstate_funcs.set_turbo_ratio_limit) {
> > +		int max_perf_adj;
> > +
> > +		max_perf_adj = fp_toint(mul_fp(int_tofp(
> > +					cpu->pstate.turbo_ratio_limit & 0xff),
> > +					limits.max_perf));
> > +
> > +		if (max_perf_adj > cpu->pstate.max_pstate)
> > +			pstate_funcs.set_turbo_ratio_limit(cpu,
> > +						cpu->pstate.turbo_ratio_limit,
> > +						max_perf_adj);
> > +	}
> >  
> >  	init_timer_deferrable(&cpu->timer);
> >  	cpu->timer.data = (unsigned long)cpu;
> > @@ -1118,6 +1206,8 @@ static void copy_cpu_funcs(struct pstate_funcs *funcs)
> >  	pstate_funcs.get_scaling = funcs->get_scaling;
> >  	pstate_funcs.set       = funcs->set;
> >  	pstate_funcs.get_vid   = funcs->get_vid;
> > +	pstate_funcs.set_turbo_ratio_limit = funcs->set_turbo_ratio_limit;
> > +	pstate_funcs.get_turbo_ratio_limit = funcs->get_turbo_ratio_limit;
> 
> These are defined for Core only, right?  Might be good to write about that in
> the changelog.
Yes. I will.

Thanks,
Srinivas
> 
> >  }
> >  
> >  #if IS_ENABLED(CONFIG_ACPI)
> > 
> 
> Thanks,
> Rafael
> 


