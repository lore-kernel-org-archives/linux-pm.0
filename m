From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH v2] cpufreq: powernv: Add checks to report cpu frequency
 throttling conditions
Date: Fri, 27 Mar 2015 10:05:45 +0530
Message-ID: <CAKohpokXx+PfBo7vDVcfLS1R1+5j7MaDHxK6QG+vtaG9LgSS4w@mail.gmail.com>
References: <1427395282-31875-1-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ob0-f180.google.com ([209.85.214.180]:35030 "EHLO
	mail-ob0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750753AbbC0Efp (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 27 Mar 2015 00:35:45 -0400
Received: by obcjt1 with SMTP id jt1so62958557obc.2
        for <linux-pm@vger.kernel.org>; Thu, 26 Mar 2015 21:35:45 -0700 (PDT)
In-Reply-To: <1427395282-31875-1-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

Hi Shilpa,

On 27 March 2015 at 00:11, Shilpasri G Bhat
<shilpa.bhat@linux.vnet.ibm.com> wrote:
> Cpu frequency can be throttled due to failures of components like OCC,
> power supply and fan. It can also be throttled due to temperature and
> power limit. We can detect the throttling by checking 1)if max frequency

Add these points in separate lines please, with a space after ). Its not
readable this way..

> is reduced, 2)if the core is put to safe frequency 3)if the SPR based
> frequency management is disabled.

All these three points refer to the state CPU has shifted to ? Sorry it wasn't
clear to the outsiders :), perhaps some more detail on why CPU would have
done that.

> The current status of the core is read from Power Management Status
> Register(PMSR) to check if any of the throttling condition is
> occurred and the appropriate throttling message is reported.

So, what do we want to do on throttling? Just print a warning? Is that
enough? What if CPU gets heated up to a point that it burns up ?

> Signed-off-by: Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>
> ---
> Changes from V1: Removed unused value of PMCR register
>
>  drivers/cpufreq/powernv-cpufreq.c | 39 ++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 38 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/cpufreq/powernv-cpufreq.c b/drivers/cpufreq/powernv-cpufreq.c
> index 2dfd4fd..4837eed 100644
> --- a/drivers/cpufreq/powernv-cpufreq.c
> +++ b/drivers/cpufreq/powernv-cpufreq.c
> @@ -36,7 +36,7 @@
>  #define POWERNV_MAX_PSTATES    256
>
>  static struct cpufreq_frequency_table powernv_freqs[POWERNV_MAX_PSTATES+1];
> -static bool rebooting;
> +static bool rebooting, throttled;
>
>  /*
>   * Note: The set of pstates consists of contiguous integers, the
> @@ -294,6 +294,40 @@ static inline unsigned int get_nominal_index(void)
>         return powernv_pstate_info.max - powernv_pstate_info.nominal;
>  }
>
> +static void powernv_cpufreq_throttle_check(unsigned int cpu)
> +{
> +       unsigned long pmsr;
> +       int pmsr_pmax, pmsr_lp;
> +
> +       pmsr = get_pmspr(SPRN_PMSR);
> +
> +       /* Check for Pmax Capping */
> +       pmsr_pmax = (s8)((pmsr >> 32) & 0xFF);

u8 ?

> +       if (pmsr_pmax != powernv_pstate_info.max) {
> +               throttled = true;
> +               pr_warn("Cpu %d Pmax is reduced to %d\n", cpu, pmsr_pmax);
> +       }
> +
> +       /* Check for Psafe by reading LocalPstate
> +        * or check if Psafe_mode_active- 34th bit is set in PMSR.
> +        */

Proper multi-line comment format is:

/*
 * ....
 */


> +       pmsr_lp = (s8)((pmsr >> 48) & 0xFF);
> +       if ((pmsr_lp < powernv_pstate_info.min) || ((pmsr >> 30) & 1)) {
> +               throttled = true;
> +               pr_warn("Cpu %d in Psafe %d PMSR[34]=%lx\n", cpu,
> +                               pmsr_lp, ((pmsr >> 30) & 1));
> +       }
> +
> +       /* Check if SPR_EM_DISABLED- 33rd bit is set in PMSR */
> +       if ((pmsr >> 31) & 1) {
> +               throttled = true;
> +               pr_warn("Frequency management disabled cpu %d PMSR[33]=%lx\n",
> +                               cpu, ((pmsr >> 31) & 1));
> +       }
> +       if (throttled)
> +               pr_warn("Cpu Frequency is throttled\n");
> +}
> +
>  /*
>   * powernv_cpufreq_target_index: Sets the frequency corresponding to
>   * the cpufreq table entry indexed by new_index on the cpus in the
> @@ -307,6 +341,9 @@ static int powernv_cpufreq_target_index(struct cpufreq_policy *policy,
>         if (unlikely(rebooting) && new_index != get_nominal_index())
>                 return 0;
>
> +       if (!throttled)
> +               powernv_cpufreq_throttle_check(smp_processor_id());

And CPU can't come out of throttling again ?

> +
>         freq_data.pstate_id = powernv_freqs[new_index].driver_data;
