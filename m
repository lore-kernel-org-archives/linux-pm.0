From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH] cpufreq: Record stats when fast switching is enabled
Date: Thu, 31 Jan 2019 11:02:12 +0100
Message-ID: <CAJZ5v0gJUx0MWtjJMK03dqgfotpDZ-TqOKi8=6Pg4dv=wV-5cg@mail.gmail.com>
References: <20190131015139.126890-1-mka@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190131015139.126890-1-mka@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Matthias Kaehlcke <mka@chromium.org>
Cc: "Rafael J . Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>, Linux PM <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Douglas Anderson <dianders@chromium.org>
List-Id: linux-pm@vger.kernel.org

On Thu, Jan 31, 2019 at 2:51 AM Matthias Kaehlcke <mka@chromium.org> wrote:
>
> When fast switching is enabled currently no cpufreq stats are
> recorded and the corresponding sysfs attributes appear empty (see
> also commit 1aefc75b2449 ("cpufreq: stats: Make the stats code
> non-modular")).
>
> Record the stats after a successful fast switch and re-enable access
> through sysfs when fast switching is enabled. Since
> cpufreq_stats_update() can now be called in interrupt context (during
> a fast switch) disable local IRQs while holding the stats spinlock.
>
> Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> ---
> The change is so simple that I wonder if I'm missing some important
> reason why the stats can't/shouldn't be updated during/after a fast
> switch ...
>
> I would expect that holding the stats spinlock briefly in
> cpufreq_stats_update() shouldn't be a problem. In theory it would
> also be an option to have a per stats lock, though it seems overkill
> from my (possibly ignorant) point of view.
> ---
>  drivers/cpufreq/cpufreq.c       |  8 +++++++-
>  drivers/cpufreq/cpufreq_stats.c | 11 +++--------
>  2 files changed, 10 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> index e35a886e00bcf..63aadb0bbddfe 100644
> --- a/drivers/cpufreq/cpufreq.c
> +++ b/drivers/cpufreq/cpufreq.c
> @@ -1857,9 +1857,15 @@ EXPORT_SYMBOL(cpufreq_unregister_notifier);
>  unsigned int cpufreq_driver_fast_switch(struct cpufreq_policy *policy,
>                                         unsigned int target_freq)
>  {
> +       unsigned int freq;
> +
>         target_freq = clamp_val(target_freq, policy->min, policy->max);
>
> -       return cpufreq_driver->fast_switch(policy, target_freq);
> +       freq = cpufreq_driver->fast_switch(policy, target_freq);
> +       if (freq)
> +               cpufreq_stats_record_transition(policy, freq);

No extra locking in the fast switch path, pretty please.

This runs in the scheduler context and it adds enough overhead in there already.

> +
> +       return freq;
>  }
>  EXPORT_SYMBOL_GPL(cpufreq_driver_fast_switch);
