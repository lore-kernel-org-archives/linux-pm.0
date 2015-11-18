From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [TEST PATCH] cpufreq: intel_pstate: Workaround to for wrong ACPI perf table entry
Date: Wed, 18 Nov 2015 02:33:36 +0100
Message-ID: <8524647.rknTxxgTfO@vostro.rjw.lan>
References: <1447801252-3626-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:54439 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751218AbbKRBEH (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 17 Nov 2015 20:04:07 -0500
In-Reply-To: <1447801252-3626-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: bp@alien8.de, rafael.j.wysocki@intel.com, linux-pm@vger.kernel.org

On Tuesday, November 17, 2015 03:00:52 PM Srinivas Pandruvada wrote:
> With the implementation of ACPI _PSS and _PPC processing in the Intel P
> state driver, a bad ACPI configuration can impact max/min states. For
> example as reported by Borislav Petkov <bp@alien8.de>, the log shows:
> 
> [    0.826119] intel_pstate: default limits 0xc 0x1d 0x24
> [    0.827000] intel_pstate: CPU0 - ACPI _PSS perf data
> [    0.827020]      *P0: 2901 MHz, 35000 mW, 0xff00
> The above control value of 0xff00, is invalid. The first entry sets the
> max control value for turbo with a max non turbo frequency + 1 MHz. Here
> the control values should be 0x1d00.

I guess "the control value should not be greater than the one reported by the
CPU itself".

> intel_pstate_set_policy() depends on this control value in setting correct
> max pstate.

This looks sort of fragile to me.

> Two fixes have been done here:
> - If the control value is invalid then use the physical max turbo as the
> max. Here 0xff00 will be changed to 0x1d00

It will be changed to whatever is reported by the CPU I suppose.

> - Always reset the limits->min_perf_ctl and limits->max_perf_ctl, so that
> we will not use last value. In this case even if entry is not found the
> _PSS it will fallback to limits->max_perf and limits-> limits->max_perf.
> 
> Reported-by: Borislav Petkov <bp@alien8.de>
> Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> ---
>  drivers/cpufreq/intel_pstate.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
> index d3159f0..fc99e97 100644
> --- a/drivers/cpufreq/intel_pstate.c
> +++ b/drivers/cpufreq/intel_pstate.c
> @@ -311,6 +311,13 @@ static int intel_pstate_init_perf_limits(struct cpufreq_policy *policy)
>  		 * correct max turbo frequency based on the turbo ratio.
>  		 * Also need to convert to MHz as _PSS freq is in MHz.
>  		 */
> +		if (turbo_pss_ctl > cpu->pstate.turbo_pstate) {
> +			/* We hava an invalid control value here */
> +			turbo_pss_ctl = cpu->pstate.turbo_pstate;
> +			cpu->acpi_perf_data.states[0].control =
> +							turbo_pss_ctl << 8;
> +		}

Should we update pstate.turbo_pstate otherwise?

> +
>  		cpu->acpi_perf_data.states[0].core_frequency =
>  				turbo_pss_ctl * cpu->pstate.scaling / 1000;
>  	}

We seem to have one more bug in this function, but it doesn't affect the case
at hand.  Namely, if the turbo range is not present in the _PSS, we should
set pstate.turbo_pstate to pstate.max_pstate after we've updated the latter
and not before updating it.

I'm also wondering if turbo should be enabled when turbo_pass_ctl is less than
pstate.min_state.  Perhaps not?

> @@ -1272,6 +1279,8 @@ static int intel_pstate_set_policy(struct cpufreq_policy *policy)
>  
>  #if IS_ENABLED(CONFIG_ACPI)
>  	cpu = all_cpu_data[policy->cpu];
> +	limits->min_perf_ctl = 0;
> +	limits->max_perf_ctl = 0;

Wouldn't this re-introduce the problem fixed by commit 4ef451487019
(cpufreq: intel_pstate: Avoid calculation for max/min) in corner cases?

>  	for (i = 0; i < cpu->acpi_perf_data.state_count; i++) {
>  		int control;

That whole loop is fragile.

To me, it should just pick the first state that is not greater than policy->max
and the last one that is not less than policy->min.

Thanks,
Rafael

