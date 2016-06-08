From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH 2/2] cpufreq: intel_pstate: Fix set_policy interface for no_turbo
Date: Wed, 8 Jun 2016 03:06:01 +0200
Message-ID: <CAJZ5v0g+9HAhfcdB30J16OugfbyvmS7eQokB9V0UCOjBuLDW-A@mail.gmail.com>
References: <1465346333-3104-1-git-send-email-srinivas.pandruvada@linux.intel.com>
 <1465346333-3104-2-git-send-email-srinivas.pandruvada@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wm0-f66.google.com ([74.125.82.66]:32958 "EHLO
	mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754184AbcFHBGE (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 7 Jun 2016 21:06:04 -0400
Received: by mail-wm0-f66.google.com with SMTP id r5so9908680wmr.0
        for <linux-pm@vger.kernel.org>; Tue, 07 Jun 2016 18:06:03 -0700 (PDT)
In-Reply-To: <1465346333-3104-2-git-send-email-srinivas.pandruvada@linux.intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>

On Wed, Jun 8, 2016 at 2:38 AM, Srinivas Pandruvada
<srinivas.pandruvada@linux.intel.com> wrote:
> When turbo is disabled, the set_policy interface is broken.
> For example, when turbo is disabled and
> cpuinfo.max = 2900000 (full max turbo frequency)
> Setting the limits results in frequency less than settings:
> Set 1000000 KHz results in 0700000 KHz
> Set 1500000 KHz results in 1100000 KHz
> Set 2000000 KHz results in  1500000 KHz
>
> This is because limits->max_perf fraction is calculated using max
> turbo frequency as the reference, but when the max P-State is
> capped in the function intel_pstate_get_min_max, the reference
> is not the max turbo P-State. This results in reducing max
> P-State.
>
> One option is to always use max turbo as reference for calculating
> limits. But this will not be correct. By definition the intel_pstate
> sysfs limits, shows percentage of available performance. So when
> BIOS has disabled turbo, the available performance is max non turbo.
> So the max_perf_pct should still show 100%.
>
> Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> ---
>  drivers/cpufreq/intel_pstate.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
> index 724b905..2116666 100644
> --- a/drivers/cpufreq/intel_pstate.c
> +++ b/drivers/cpufreq/intel_pstate.c
> @@ -1561,8 +1561,14 @@ static int intel_pstate_cpu_init(struct cpufreq_policy *policy)
>
>         /* cpuinfo and default policy values */
>         policy->cpuinfo.min_freq = cpu->pstate.min_pstate * cpu->pstate.scaling;
> -       policy->cpuinfo.max_freq =
> -               cpu->pstate.turbo_pstate * cpu->pstate.scaling;
> +       update_turbo_state();
> +       if (limits->turbo_disabled)
> +               policy->cpuinfo.max_freq =
> +                       cpu->pstate.max_pstate * cpu->pstate.scaling;
> +       else
> +               policy->cpuinfo.max_freq =
> +                       cpu->pstate.turbo_pstate * cpu->pstate.scaling;
> +
>         intel_pstate_init_acpi_perf_limits(policy);
>         policy->cpuinfo.transition_latency = CPUFREQ_ETERNAL;
>         cpumask_set_cpu(policy->cpu, policy->cpus);
> --

BTW, I would write this slightly differently.  What about:

policy->cpuinfo.max_freq = limits->turbo_disabled ?
cpu->pstate.max_pstate : cpu->pstate.turbo_pstate;
policy->cpuinfo.max_freq *= cpu->pstate.scaling;
