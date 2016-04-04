From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH] cpufreq: intel_pstate: fix inconsistency in setting
 policy limits
Date: Mon, 4 Apr 2016 03:16:09 +0200
Message-ID: <CAJZ5v0iA7r6yP-dViiXjOuKuvED2eNWZdVACe=ByrzLR47QEMQ@mail.gmail.com>
References: <1459713972-5654-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-lf0-f66.google.com ([209.85.215.66]:36214 "EHLO
	mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754082AbcDDBQL (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sun, 3 Apr 2016 21:16:11 -0400
In-Reply-To: <1459713972-5654-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On Sun, Apr 3, 2016 at 10:06 PM, Srinivas Pandruvada
<srinivas.pandruvada@linux.intel.com> wrote:
> When user sets performance policy using cpufreq interface, it is possible
> that because of policy->max limits, the actual performance is still
> limited. But the current implementation will silently switch the
> policy to powersave and start using powersave limits. If user modifies
> any limits using intel_pstate sysfs, this is actually changing powersave
> limits.
>
> The current implementation tracks limits under powersave and performance
> policy using two different variables. When policy->max is less than
> policy->cpuinfo.max_freq, only powersave limit variable is used.
>
> This fix involves uses performance limits variable always when policy
> is performance.
>
> Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> ---
>  drivers/cpufreq/intel_pstate.c | 40 ++++++++++++++++++++++++++++++++--------
>  1 file changed, 32 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
> index 4b64452..776cea7 100644
> --- a/drivers/cpufreq/intel_pstate.c
> +++ b/drivers/cpufreq/intel_pstate.c
> @@ -1122,22 +1122,46 @@ static unsigned int intel_pstate_get(unsigned int cpu_num)
>         return get_avg_frequency(cpu);
>  }
>
> +static void intel_pstate_set_performance_limits(struct perf_limits *limits)
> +{
> +       limits->no_turbo = 0;
> +       limits->turbo_disabled = 0;
> +       limits->max_perf_pct = 100;
> +       limits->max_perf = int_tofp(1);
> +       limits->min_perf_pct = 100;
> +       limits->min_perf = int_tofp(1);
> +       limits->max_policy_pct = 100;
> +       limits->max_sysfs_pct = 100;
> +       limits->min_policy_pct = 0;
> +       limits->min_sysfs_pct = 0;
> +}
> +
>  static int intel_pstate_set_policy(struct cpufreq_policy *policy)
>  {
>         if (!policy->cpuinfo.max_freq)
>                 return -ENODEV;
>
> -       if (policy->policy == CPUFREQ_POLICY_PERFORMANCE &&
> -           policy->max >= policy->cpuinfo.max_freq) {
> -               pr_debug("intel_pstate: set performance\n");
> +       if (policy->policy == CPUFREQ_POLICY_PERFORMANCE) {
>                 limits = &performance_limits;
> -               if (hwp_active)
> -                       intel_pstate_hwp_set(policy->cpus);

Can you please rebase this on top of my linux-next branch?  This
change in particular will conflict with one commit already in there.
