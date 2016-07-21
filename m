From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH] cpufreq: Disallow ->resolve_freq() for drivers providing ->target_index()
Date: Thu, 21 Jul 2016 23:37:12 +0200
Message-ID: <CAJZ5v0jW=RHuOrJcw4+bvxLHP+v=FRksdgVE=qOnwSVcvQPEzw@mail.gmail.com>
References: <a49fb95b6186dc041f5a64f0c38d9ebc92fade83.1469136204.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wm0-f67.google.com ([74.125.82.67]:35188 "EHLO
	mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754349AbcGUVhO (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 21 Jul 2016 17:37:14 -0400
In-Reply-To: <a49fb95b6186dc041f5a64f0c38d9ebc92fade83.1469136204.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, Lists linaro-kernel <linaro-kernel@lists.linaro.org>, Linux PM <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Steve Muckle <steve.muckle@linaro.org>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>, Morten Rasmussen <morten.rasmussen@arm.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, Juri Lelli <Juri.Lelli@arm.com>, Patrick Bellasi <patrick.bellasi@arm.com>

On Thu, Jul 21, 2016 at 11:23 PM, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> The handlers provided by cpufreq core are sufficient for resolving the
> frequency for drivers providing ->target_index(), as the core already
> has the frequency table and so ->resolve_freq() isn't required for such
> platforms.
>
> This patch disallows drivers with ->target_index() callback to use the
> ->resolve_freq() callback.
>
> Also, it fixes a potential kernel crash for drivers providing ->target()
> but no ->resolve_freq().
>
> Fixes: e3c062360870 ("cpufreq: add cpufreq_driver_resolve_freq()")
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>  drivers/cpufreq/cpufreq.c | 16 ++++++++++++----
>  1 file changed, 12 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> index b696baeb249d..342bbee8d0e1 100644
> --- a/drivers/cpufreq/cpufreq.c
> +++ b/drivers/cpufreq/cpufreq.c
> @@ -507,12 +507,20 @@ unsigned int cpufreq_driver_resolve_freq(struct cpufreq_policy *policy,
>  {
>         target_freq = clamp_val(target_freq, policy->min, policy->max);
>         policy->cached_target_freq = target_freq;
> +
> +       if (cpufreq_driver->target_index) {
> +               int idx;
> +
> +               idx = cpufreq_frequency_table_target(policy, target_freq,
> +                                                    CPUFREQ_RELATION_L);
> +               policy->cached_resolved_idx = idx;
> +               return policy->freq_table[idx].frequency;
> +       }
> +
>         if (cpufreq_driver->resolve_freq)
>                 return cpufreq_driver->resolve_freq(policy, target_freq);
> -       policy->cached_resolved_idx =
> -               cpufreq_frequency_table_target(policy, target_freq,
> -                                              CPUFREQ_RELATION_L);
> -       return policy->freq_table[policy->cached_resolved_idx].frequency;
> +
> +       return UINT_MAX;

I think it should just return target_freq in this case or the UINT_MAX
will confuse things in schedutil.

Thanks,
Rafael
