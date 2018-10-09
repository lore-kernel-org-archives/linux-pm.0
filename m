From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH] cpufreq: conservative: Fix requested_freq handling
Date: Tue, 9 Oct 2018 09:47:40 +0200
Message-ID: <CAJZ5v0j0GLHgKS9+mafm3eoFMuNEo6VPa3LhRthg+H5OKHhFqA@mail.gmail.com>
References: <20181008150901.19667-1-waldemar.rymarkiewicz@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181008150901.19667-1-waldemar.rymarkiewicz@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Waldemar Rymarkiewicz <waldemar.rymarkiewicz@gmail.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>, Waldemar Rymarkiewicz <waldemarx.rymarkiewicz@intel.com>, Linux PM <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Mon, Oct 8, 2018 at 5:11 PM Waldemar Rymarkiewicz
<waldemar.rymarkiewicz@gmail.com> wrote:
>
> From: Waldemar Rymarkiewicz <waldemarx.rymarkiewicz@intel.com>
>
> The governor updates dbs_info->requested_freq only after increasing or
> decreasing frequency. There is, however, an use case when this is not
> sufficient.
>
> Imagine, external module constraining cpufreq policy in a way that policy->max

Is the "external module" here a utility or a demon running in user space?

> = policy->min = max_available_freq (eg. 1Ghz). CPUfreq will set freq to
> max_freq and conservative gov will not try downscale/upscale due to the
> limits. It will just exit instead
>
>     if (requested_freq > policy->max || requested_freq < policy->min)
>             //max=min=1Ghz -> requested_freq=cur=1Ghz
>             requested_freq = policy->cur;
>     [...]
>     if (requested_freq == policy->max)
>              goto out;
>
> In a result, dbs_info->requested_freq is not updated with newly calculated
> requested_freq=1Ghz. Next, execution of update routine will use again
> previously stored requested_freq (in my case it was min_available_freq)
>
>     [...]
>     unsigned int requested_freq = dbs_info->requested_freq;
>     [....]
>
> Now, when external module returns to previous policy limits that is
> policy->min = min_available_freq and policy->max = max_available_freq,
> conservative governor is not able to decrease frequency because stored
> requested_freq is still or rather already set to min_available_freq so
> the check (for decreasing)
>
>     [...]
>     if (load < cs_tuners->down_threshold) {
>     [....]
>            if (requested_freq == policy->min)
>                    goto out;
>     [...]
>
> returns from routine before it does any freq change. To fix that just update
> dbs_info->requested_freq every time we go out from the update routine.
>
> Signed-off-by: Waldemar Rymarkiewicz <waldemarx.rymarkiewicz@intel.com>
> ---
>  drivers/cpufreq/cpufreq_conservative.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/drivers/cpufreq/cpufreq_conservative.c b/drivers/cpufreq/cpufreq_conservative.c
> index f20f20a..7f90f6e 100644
> --- a/drivers/cpufreq/cpufreq_conservative.c
> +++ b/drivers/cpufreq/cpufreq_conservative.c
> @@ -113,7 +113,6 @@ static unsigned int cs_dbs_update(struct cpufreq_policy *policy)
>                         requested_freq = policy->max;
>
>                 __cpufreq_driver_target(policy, requested_freq, CPUFREQ_RELATION_H);
> -               dbs_info->requested_freq = requested_freq;
>                 goto out;
>         }
>
> @@ -136,10 +135,10 @@ static unsigned int cs_dbs_update(struct cpufreq_policy *policy)
>                         requested_freq = policy->min;
>
>                 __cpufreq_driver_target(policy, requested_freq, CPUFREQ_RELATION_L);
> -               dbs_info->requested_freq = requested_freq;
>         }
>
>   out:
> +       dbs_info->requested_freq = requested_freq;

This will have a side effect when requested_freq is updated before the
thresholds checks due to the policy_dbs->idle_periods < UINT_MAX
check.

Shouldn't that be avoided?

>         return dbs_data->sampling_rate;
>  }
