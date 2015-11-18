From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: Re: [TEST PATCH] cpufreq: intel_pstate: Workaround to for wrong
 ACPI perf table entry
Date: Tue, 17 Nov 2015 18:10:35 -0800
Message-ID: <1447812635.2778.90.camel@spandruv-desk3.jf.intel.com>
References: <1447801252-3626-1-git-send-email-srinivas.pandruvada@linux.intel.com>
	 <8524647.rknTxxgTfO@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:39189 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751768AbbKRCL3 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Tue, 17 Nov 2015 21:11:29 -0500
In-Reply-To: <8524647.rknTxxgTfO@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: bp@alien8.de, rafael.j.wysocki@intel.com, linux-pm@vger.kernel.org

On Wed, 2015-11-18 at 02:33 +0100, Rafael J. Wysocki wrote:
> On Tuesday, November 17, 2015 03:00:52 PM Srinivas Pandruvada wrote:
> > With the implementation of ACPI _PSS and _PPC processing in the Intel P
> > state driver, a bad ACPI configuration can impact max/min states. For
> > example as reported by Borislav Petkov <bp@alien8.de>, the log shows:
> > 
> > [    0.826119] intel_pstate: default limits 0xc 0x1d 0x24
> > [    0.827000] intel_pstate: CPU0 - ACPI _PSS perf data
> > [    0.827020]      *P0: 2901 MHz, 35000 mW, 0xff00
> > The above control value of 0xff00, is invalid. The first entry sets the
> > max control value for turbo with a max non turbo frequency + 1 MHz. Here
> > the control values should be 0x1d00.
> 
> I guess "the control value should not be greater than the one reported by the
> CPU itself".
Yes.
> 
> > intel_pstate_set_policy() depends on this control value in setting correct
> > max pstate.
> 
> This looks sort of fragile to me.
> 
> > Two fixes have been done here:
> > - If the control value is invalid then use the physical max turbo as the
> > max. Here 0xff00 will be changed to 0x1d00
> 
> It will be changed to whatever is reported by the CPU I suppose.
> 
> > - Always reset the limits->min_perf_ctl and limits->max_perf_ctl, so that
> > we will not use last value. In this case even if entry is not found the
> > _PSS it will fallback to limits->max_perf and limits-> limits->max_perf.
> > 
> > Reported-by: Borislav Petkov <bp@alien8.de>
> > Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> > ---
> >  drivers/cpufreq/intel_pstate.c | 9 +++++++++
> >  1 file changed, 9 insertions(+)
> > 
> > diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
> > index d3159f0..fc99e97 100644
> > --- a/drivers/cpufreq/intel_pstate.c
> > +++ b/drivers/cpufreq/intel_pstate.c
> > @@ -311,6 +311,13 @@ static int intel_pstate_init_perf_limits(struct cpufreq_policy *policy)
> >  		 * correct max turbo frequency based on the turbo ratio.
> >  		 * Also need to convert to MHz as _PSS freq is in MHz.
> >  		 */
> > +		if (turbo_pss_ctl > cpu->pstate.turbo_pstate) {
> > +			/* We hava an invalid control value here */
> > +			turbo_pss_ctl = cpu->pstate.turbo_pstate;
> > +			cpu->acpi_perf_data.states[0].control =
> > +							turbo_pss_ctl << 8;
> > +		}
> 
> Should we update pstate.turbo_pstate otherwise?
It will happen as the policy will reduce the frequency based on the
_PSS[PPC_INDEX] frequency. So if turbo_pstate is less then the
intel_pstate_set_policy will be called with reduced max->policy.
> 
> > +
> >  		cpu->acpi_perf_data.states[0].core_frequency =
> >  				turbo_pss_ctl * cpu->pstate.scaling / 1000;
> >  	}
> 
> We seem to have one more bug in this function, but it doesn't affect the case
> at hand.  Namely, if the turbo range is not present in the _PSS, we should
> set pstate.turbo_pstate to pstate.max_pstate after we've updated the latter
> and not before updating it.
Doing it before we have good known reference for max_sysf_pct. which is
either physical max turbo or physical max non turbo as 100%. The policy
will limit to actual pss max pstate frequency. which will be reflected
in reduced max_perf_pct.

> 
> I'm also wondering if turbo should be enabled when turbo_pass_ctl is less than
> pstate.min_state.  Perhaps not?
> 
This is too bad entry in that case. But we can disable the turbo.
> > @@ -1272,6 +1279,8 @@ static int intel_pstate_set_policy(struct cpufreq_policy *policy)
> >  
> >  #if IS_ENABLED(CONFIG_ACPI)
> >  	cpu = all_cpu_data[policy->cpu];
> > +	limits->min_perf_ctl = 0;
> > +	limits->max_perf_ctl = 0;
> 
> Wouldn't this re-introduce the problem fixed by commit 4ef451487019
> (cpufreq: intel_pstate: Avoid calculation for max/min) in corner cases?
If there is a match in _PSS, it will be correctly set in loop below. In
the current problem case we failed to match the _PSS for policy->max so
we were relying on the max_perf calculation. But later some thermal
issue happened, which reduced the policy to minimum. We stuck in that
because limits->max_perf_ctl was not reset even after when policy
changed to turbo max. With reset we should have used max pstate
calculated value, which will not be as bad as last value.
> 
> >  	for (i = 0; i < cpu->acpi_perf_data.state_count; i++) {
> >  		int control;
> 
> That whole loop is fragile.
Could you suggest or submit a change for this?  Trying to do get max and
min in one for-loop assuming not sorted.
With the reset of limits->[max|min]_perf_ctl, we can do 
	for (i = 0; i < cpu->acpi_perf_data.state_count; i++) {
		int control;

		control = convert_to_native_pstate_format(cpu, i);
		if (!limits->max_perf_ctl && control * cpu->pstate.scaling ==
policy->max)
			limits->max_perf_ctl = control;
		if (!limits->min_perf_ctl && control * cpu->pstate.scaling ==
policy->min)
			limits->min_perf_ctl = control;
	}


Thanks,
Srinivas
> To me, it should just pick the first state that is not greater than policy->max
> and the last one that is not less than policy->min.
> 
> Thanks,
> Rafael
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pm" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html


