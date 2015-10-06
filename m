From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v3 1/6] cpufreq: intel_p_state: Fix limiting turbo sub states
Date: Wed, 07 Oct 2015 01:27:32 +0200
Message-ID: <1965742.dzdCop9YiO@vostro.rjw.lan>
References: <1443567248-27134-1-git-send-email-srinivas.pandruvada@linux.intel.com> <1962931.XZqpddDuF8@vostro.rjw.lan> <1444092185.17895.99.camel@spandruv-desk3.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:62961 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1752879AbbJFW7C (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 6 Oct 2015 18:59:02 -0400
In-Reply-To: <1444092185.17895.99.camel@spandruv-desk3.jf.intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: kristen.c.accardi@intel.com, rafael.j.wysocki@intel.com, len.brown@intel.com, linux-pm@vger.kernel.org

On Monday, October 05, 2015 05:43:05 PM Srinivas Pandruvada wrote:
> On Tue, 2015-10-06 at 00:56 +0200, Rafael J. Wysocki wrote:
> > On Tuesday, September 29, 2015 03:54:03 PM Srinivas Pandruvada wrote:
> > > Although the max_perf_pct reflects sub states in turbo range, we can't
> > > really restrict to those states. This gives wrong impression that the
> > > performance is reduced.
> > > This can be achieved by restricting turbo ratio limits (MSR 0x1AD),
> > > when bit 28 of platform info MSR allows (MSR 0xCE) is 1.
> > > 
> > > Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> > > ---
> > >  drivers/cpufreq/intel_pstate.c | 92 +++++++++++++++++++++++++++++++++++++++++-
> > >  1 file changed, 91 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
> > > index 3af9dd7..576d9e8 100644
> > > --- a/drivers/cpufreq/intel_pstate.c
> > > +++ b/drivers/cpufreq/intel_pstate.c
> > > @@ -80,6 +80,7 @@ struct pstate_data {
> > >  	int	max_pstate;
> > >  	int	scaling;
> > >  	int	turbo_pstate;
> > > +	u64	turbo_ratio_limit;
> > 
> > Why does it have to be u64?
> turbo ratio limit is 64 bit value. On some models it will show ratio
> when up to 8 cores active like in Xeon E5 v3(SDM Table 35-27).
> > 
> > >  };
> > >  
> > >  struct vid_data {
> > > @@ -132,6 +133,8 @@ struct pstate_funcs {
> > >  	int (*get_scaling)(void);
> > >  	void (*set)(struct cpudata*, int pstate);
> > >  	void (*get_vid)(struct cpudata *);
> > > +	u64 (*get_turbo_ratio_limit)(struct cpudata *);
> > > +	int (*set_turbo_ratio_limit)(struct cpudata *, u64, u64);
> > 
> > An int is always passed as the last arg to this, so why is the arg u64?
> > 
> > >  };
> > >  
> > >  struct cpu_defaults {
> > > @@ -434,6 +437,23 @@ static ssize_t store_max_perf_pct(struct kobject *a, struct attribute *b,
> > >  	limits.max_perf_pct = max(limits.min_perf_pct, limits.max_perf_pct);
> > >  	limits.max_perf = div_fp(int_tofp(limits.max_perf_pct), int_tofp(100));
> > >  
> > > +	if (pstate_funcs.set_turbo_ratio_limit) {
> > > +		int max_perf_adj;
> > > +		struct cpudata *cpu = all_cpu_data[0];
> > > +
> > > +		if (limits.max_sysfs_pct == 100)
> > > +			max_perf_adj = cpu->pstate.turbo_ratio_limit;
> > 
> > This will cast the u64 to int anyway.
> I shouldn't have casted to int here, it will take care upto 4 core max
> only. But not sure people using Xeons want to reduce turbo range.
> > 
> > Also this is going to be the value read from the register at init which is
> > likely to be greater than 255 ->
> > 
> yes
> > > +		else
> > > +			max_perf_adj = fp_toint(mul_fp(int_tofp(
> > > +					cpu->pstate.turbo_ratio_limit & 0xff),
> > > +					limits.max_perf));
> > 
> > -> but this will never be greater than 255 if I'm not mistaken (limits.max_perf
> > is a representation of a fraction between 0 and 1 and the first value is
> > bounded by 255).
> limits.max_perf is a value between 0 and 255 (E.g. 100%=255, 90% 230).
> max_perf_adj will be scaled ratio based on limits.max_perf (E.g. if 1
> core max ratio is 1d, and max_perf is 230 (90%), then max_perf_adj = 1a)
> BTW I didn't invent this magic formula, it is copied from  existing
> function intel_pstate_get_min_max.
> > 
> > How are these two values related to each other?
> refer to above explanation.

Well, it looks like you always want to pass a single byte as the second arg of
pstate_funcs.set_turbo_ratio_limit(), because otherwise there are two cases
that are handled differently.

> > > +
> > > +		if (max_perf_adj > cpu->pstate.max_pstate)
> > > +			pstate_funcs.set_turbo_ratio_limit(cpu,
> > > +						cpu->pstate.turbo_ratio_limit,
> > > +						max_perf_adj);
> > 
> > I'm not really sure what this is supposed to achieve.  Care to explain a bit?
> We only care to set turbo ratio only when user ask to set ratio which is
> turbo range. Anything more than cpu->pstate.max_pstate is turbo range
> (as this value stores the maximum non turbo ratio)
> 
> > 
> > [BTW, the first arg of core_set/get_turbo_ratio_limit(() is never used, so why
> > bother with passing it at all?]
> > 
> To be consistent with the current .set pstate functions. We don't use. I
> can remove.

Yes, please.  It is better to avoid passing arguments that aren't used.

> > > +	}
> > > +
> > >  	if (hwp_active)
> > >  		intel_pstate_hwp_set();
> > >  	return count;
> > > @@ -628,6 +648,55 @@ static void core_set_pstate(struct cpudata *cpudata, int pstate)
> > >  	wrmsrl_on_cpu(cpudata->cpu, MSR_IA32_PERF_CTL, val);
> > >  }
> > >  
> > > +static u64 core_get_turbo_ratio_limit(struct cpudata *cpudata)
> > > +{
> > > +	u64 value;
> > > +
> > > +	rdmsrl(MSR_NHM_TURBO_RATIO_LIMIT, value);
> > > +
> > > +	return value;
> > > +}
> > > +
> > > +static int core_set_turbo_ratio_limit(struct cpudata *cpudata, u64 def_ratio,
> > > +			       u64 new_ratio)
> > > +{
> > > +	u64 value;
> > > +
> > 
> > What should happen if def_ratio and new_ratio are the same?
> > 
> It will not change the resultant, but we could have avoid loop below. I
> can add a check here  to return.

That was exactly my thought here. :-)

> > > +	rdmsrl(MSR_PLATFORM_INFO, value);
> > > +	if (value & BIT(28)) {
> > > +		u64 ratio = 0;
> > > +		u64 out_ratio = 0;
> > > +		u8 max_ratio = new_ratio & 0xff;
> > 
> > Why u8?
> 1C max ratio is the maximum value any ratio can have, which is stored in
> first byte.
> > > +		int i;
> > > +		/*
> > > +		 * If caller provided reduced max ratio (one core active)
> > > +		 * then use this for all other ratios, which are more
> > > +		 * than the default ratio for those many cores active
> > > +		 * for example if default ratio is 0x1a1b1c1d and new ratio
> > > +		 * is 0x1b, then resultant ratio will be 0x1a1b1b1b
> > > +		 */
> > 
> > This is a bit messy IMO. 
> Yes.
> >  Instead of shifting def_ratio and new_ratio in each
> > step, I'd shift max_ratio and the mask:
> > 
> > 	u64 mask = 0xff;
> > 	u64 max_ratio = new_ratio & mask;
> > 
> > 	while (mask) {
> > 		if (def_ratio & mask) {
> > 			u64 ratio;
> > 
> > 			if (new_ratio & mask) {
> > 				ratio = new_ratio & mask;
> > 			} else {
> > 				ratio = def_ratio & mask;
> > 				if (ratio > max_ratio)
> > 					ratio = max_ratio;
> > 			}
> > 			out_ratio |= ratio;
> > 		}
> > 		max_ratio <<= 8;
> > 		mask <<= 8;
> > 	}
> > 
> I will experiment with your algorithm and check.
> 
> > [I'm not sure why the least significant byte of new_ratio is special, though.]
> > 
> LS Byte is the max turbo you can ever achieve as this ratio is for 1
> core active turbo.

OK

> > > +		for (i = 0; i < sizeof(def_ratio); ++i) {
> > > +			if (def_ratio & 0xff) {
> > > +				if (new_ratio & 0xff)
> > > +					ratio = new_ratio & 0xff;
> > > +				else {
> > > +					if ((def_ratio & 0xff) > max_ratio)
> > > +						ratio = max_ratio;
> > > +					else
> > > +						ratio = def_ratio & 0xff;
> > > +				}
> > > +				out_ratio |= (ratio << (i * 8));
> > > +			}
> > > +			def_ratio >>= 8;
> > > +			new_ratio >>= 8;
> > > +		}
> > > +		wrmsrl(MSR_NHM_TURBO_RATIO_LIMIT, out_ratio);
> > > +		return 0;
> > > +	}
> > > +
> > > +	return -EPERM;
> > 
> > Why -EPERM?
> > 
> > That's not because the user has no permission to carry out the opreration, but
> > because there is no capability, right?
> > 
> Yes. Is there any better error code?

-ENXIO would be better IMO.

Thanks,
Rafael

