From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH V4 7/7] cpufreq: ondemand: Rearrange od_dbs_timer() to
 void updating delay
Date: Wed, 10 Feb 2016 01:28:12 +0100
Message-ID: <CAJZ5v0jnzMV59V+aisb2W9xxh8SaBjx7bpPXWN-663c0wSC0aw@mail.gmail.com>
References: <cover.1454988792.git.viresh.kumar@linaro.org>
	<853c8f6925a75e3750d3f0a0facd0d1d3f4325ba.1454988792.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-lf0-f65.google.com ([209.85.215.65]:34757 "EHLO
	mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752830AbcBJA2N (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 9 Feb 2016 19:28:13 -0500
In-Reply-To: <853c8f6925a75e3750d3f0a0facd0d1d3f4325ba.1454988792.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, Juri Lelli <juri.lelli@arm.com>, Lists linaro-kernel <linaro-kernel@lists.linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

s/void/avoid/ in the subject.

Apart from that it looks good.

On Tue, Feb 9, 2016 at 4:46 AM, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> 'delay' is updated properly in all paths of the routine od_dbs_timer(),
> leaving just one. And can be 0 only in that case.
>
> Move the update to 'delay' as an else part of the if block.
>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>  drivers/cpufreq/cpufreq_ondemand.c | 9 ++++-----
>  1 file changed, 4 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/cpufreq/cpufreq_ondemand.c b/drivers/cpufreq/cpufreq_ondemand.c
> index d9f323f150c4..388ae07ce413 100644
> --- a/drivers/cpufreq/cpufreq_ondemand.c
> +++ b/drivers/cpufreq/cpufreq_ondemand.c
> @@ -194,7 +194,7 @@ static unsigned int od_dbs_timer(struct cpufreq_policy *policy)
>         struct policy_dbs_info *policy_dbs = policy->governor_data;
>         struct dbs_data *dbs_data = policy_dbs->dbs_data;
>         struct od_cpu_dbs_info_s *dbs_info = &per_cpu(od_cpu_dbs_info, policy->cpu);
> -       int delay = 0, sample_type = dbs_info->sample_type;
> +       int delay, sample_type = dbs_info->sample_type;
>
>         /* Common NORMAL_SAMPLE setup */
>         dbs_info->sample_type = OD_NORMAL_SAMPLE;
> @@ -208,13 +208,12 @@ static unsigned int od_dbs_timer(struct cpufreq_policy *policy)
>                         /* Setup timer for SUB_SAMPLE */
>                         dbs_info->sample_type = OD_SUB_SAMPLE;
>                         delay = dbs_info->freq_hi_jiffies;
> +               } else {
> +                       delay = delay_for_sampling_rate(dbs_data->sampling_rate
> +                                                       * dbs_info->rate_mult);
>                 }
>         }
>
> -       if (!delay)
> -               delay = delay_for_sampling_rate(dbs_data->sampling_rate
> -                               * dbs_info->rate_mult);
> -
>         return delay;
>  }
>
> --
> 2.7.1.370.gb2aa7f8
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pm" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
