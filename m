From: Doug Anderson <dianders@chromium.org>
Subject: Re: [PATCH V3 1/4] cpufreq: handle calls to ->target_index() in
 separate routine
Date: Tue, 20 May 2014 09:44:15 -0700
Message-ID: <CAD=FV=U8Q39qaE8Avk51LJDnBWLBXX_MqyoQV-jjpYUNwpJcrQ@mail.gmail.com>
References: <cover.1400302114.git.viresh.kumar@linaro.org>
	<914cddcb07a8aa1a9ec984f436dd2bba69cfd128.1400302114.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-vc0-f172.google.com ([209.85.220.172]:43368 "EHLO
	mail-vc0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753470AbaETQoQ (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 20 May 2014 12:44:16 -0400
Received: by mail-vc0-f172.google.com with SMTP id hr9so964315vcb.3
        for <linux-pm@vger.kernel.org>; Tue, 20 May 2014 09:44:15 -0700 (PDT)
In-Reply-To: <914cddcb07a8aa1a9ec984f436dd2bba69cfd128.1400302114.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Lists linaro-kernel <linaro-kernel@lists.linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Arvind Chauhan <arvind.chauhan@arm.com>, Stephen Warren <swarren@nvidia.com>, Nicolas Pitre <nicolas.pitre@linaro.org>, Stephen Warren <swarren@wwwdotorg.org>, Russell King <linux@arm.linux.org.uk>, Thomas Abraham <thomas.abraham@linaro.org>, Peter De Schrijver <pdeschrijver@nvidia.com>

Viresh,

On Fri, May 16, 2014 at 9:51 PM, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> Handling calls to ->target_index() has got complex over time and might become
> more complex. So, its better to take target_index() bits out in another routine
> __target_index() for better code readability. Shouldn't have any functional
> impact.
>
> Tested-by: Stephen Warren <swarren@nvidia.com>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>  drivers/cpufreq/cpufreq.c | 56 ++++++++++++++++++++++++++++-------------------
>  1 file changed, 33 insertions(+), 23 deletions(-)
>
> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> index a05c921..9bf12a2 100644
> --- a/drivers/cpufreq/cpufreq.c
> +++ b/drivers/cpufreq/cpufreq.c
> @@ -1816,12 +1816,43 @@ EXPORT_SYMBOL(cpufreq_unregister_notifier);
>   *                              GOVERNORS                            *
>   *********************************************************************/
>
> +static int __target_index(struct cpufreq_policy *policy,
> +                         struct cpufreq_frequency_table *freq_table, int index)
> +{
> +       struct cpufreq_freqs freqs;
> +       int retval = -EINVAL;
> +       bool notify;
> +
> +       notify = !(cpufreq_driver->flags & CPUFREQ_ASYNC_NOTIFICATION);
> +
> +       if (notify) {
> +               freqs.old = policy->cur;
> +               freqs.new = freq_table[index].frequency;
> +               freqs.flags = 0;
> +
> +               pr_debug("%s: cpu: %d, oldfreq: %u, new freq: %u\n",
> +                               __func__, policy->cpu, freqs.old, freqs.new);
> +
> +               cpufreq_freq_transition_begin(policy, &freqs);
> +       }
> +
> +       retval = cpufreq_driver->target_index(policy, index);
> +       if (retval)
> +               pr_err("%s: Failed to change cpu frequency: %d\n",
> +                               __func__, retval);
> +
> +       if (notify)
> +               cpufreq_freq_transition_end(policy, &freqs, retval);
> +
> +       return retval;
> +}
> +
>  int __cpufreq_driver_target(struct cpufreq_policy *policy,
>                             unsigned int target_freq,
>                             unsigned int relation)
>  {
> -       int retval = -EINVAL;
>         unsigned int old_target_freq = target_freq;
> +       int retval = -EINVAL;

I'm not sure that this shuffling was really necessary, but I guess it
doesn't hurt.  ...and I guess a CL that's shuffling code anyway is the
place to put it...

Reviewed-by: Doug Anderson <dianders@chromium.org>
