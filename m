From: Ashwin Chaugule <ashwin.chaugule@linaro.org>
Subject: Re: [PATCH 5/6] cpufreq: governor: replace per-cpu delayed work with timers
Date: Fri, 30 Oct 2015 16:46:33 -0400
Message-ID: <CAJ5Y-ebyMg1KUSCJ9+5UVN=6TNAMufGP9S4PqQWS0vnfX6XXOg@mail.gmail.com>
References: <cover.1446121217.git.viresh.kumar@linaro.org> <e83291bcb6fcb69280f265194801510cf2e02c41.1446121217.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-lf0-f42.google.com ([209.85.215.42]:36724 "EHLO
	mail-lf0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753563AbbJ3Uqz (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 30 Oct 2015 16:46:55 -0400
Received: by lffz202 with SMTP id z202so39181321lff.3
        for <linux-pm@vger.kernel.org>; Fri, 30 Oct 2015 13:46:53 -0700 (PDT)
In-Reply-To: <e83291bcb6fcb69280f265194801510cf2e02c41.1446121217.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, Linaro Kernel Mailman List <linaro-kernel@lists.linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, open list <linux-kernel@vger.kernel.org>

Hi Viresh,

On 29 October 2015 at 08:27, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> cpufreq governors evaluate load at sampling rate and based on that they
> update frequency for a group of CPUs belonging to the same cpufreq
> policy.
>
> This is required to be done in a single thread for all policy->cpus, but
> because we don't want to wakeup idle CPUs to do just that, we use
> deferrable work for this. If we would have used a single delayed
> deferrable work for the entire policy, there were chances that the CPU
> required to run the handler can be in idle and we might end up not
> changing the frequency for the entire group with load variations.
>
> And so we were forced to keep per-cpu works, and only the one that
> expires first need to do the real work and others are rescheduled for
> next sampling time.
>
> We have been using the more complex solution until now, where we used a
> delayed deferrable work for this, which is a combination of a timer and
> a work.
>
> This could be made lightweight by keeping per-cpu deferred timers with a
> single work item, which is scheduled by the first timer that expires.

Single shared work item - would perhaps make it a bit more clear.

>
> This patch does just that and here are important changes:
> - The timer handler will run in irq context and so we need to use a
>   spin_lock instead of the timer_mutex. And so a separate timer_lock is
>   created. This also makes the use of the mutex and lock quite clear, as
>   we know what exactly they are protecting.
> - A new field 'skip_work' is added to track when the timer handlers can
>   queue a work. More comments present in code.
>
> Suggested-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>  drivers/cpufreq/cpufreq_governor.c | 139 +++++++++++++++++++++----------------
>  drivers/cpufreq/cpufreq_governor.h |  20 ++++--
>  drivers/cpufreq/cpufreq_ondemand.c |   8 +--
>  3 files changed, 98 insertions(+), 69 deletions(-)
>
> diff --git a/drivers/cpufreq/cpufreq_governor.c b/drivers/cpufreq/cpufreq_governor.c
> index 999e1f6addf9..a3f9bc9b98e9 100644
> --- a/drivers/cpufreq/cpufreq_governor.c
> +++ b/drivers/cpufreq/cpufreq_governor.c

[..]

>
> +void gov_cancel_work(struct cpu_common_dbs_info *shared)
> +{
> +       unsigned long flags;
> +
> +       /*
> +        * No work will be queued from timer handlers after skip_work is
> +        * updated. And so we can safely cancel the work first and then the
> +        * timers.
> +        */
> +       spin_lock_irqsave(&shared->timer_lock, flags);
> +       shared->skip_work++;
> +       spin_unlock_irqrestore(&shared->timer_lock, flags);
> +
> +       cancel_work_sync(&shared->work);
> +
> +       gov_cancel_timers(shared->policy);
> +
> +       shared->skip_work = 0;

Why doesnt this require the spin_lock protection?

> +}
> +
>  /* Will return if we need to evaluate cpu load again or not */
>  static bool need_load_eval(struct cpu_common_dbs_info *shared,
>                            unsigned int sampling_rate)
> @@ -217,29 +222,21 @@ static bool need_load_eval(struct cpu_common_dbs_info *shared,
>         return true;
>  }
>
> -static void dbs_timer(struct work_struct *work)
> +static void dbs_work_handler(struct work_struct *work)
>  {
> -       struct cpu_dbs_info *cdbs = container_of(work, struct cpu_dbs_info,
> -                                                dwork.work);
> -       struct cpu_common_dbs_info *shared = cdbs->shared;
> +       struct cpu_common_dbs_info *shared = container_of(work, struct
> +                                       cpu_common_dbs_info, work);
>         struct cpufreq_policy *policy;
>         struct dbs_data *dbs_data;
>         unsigned int sampling_rate, delay;
> -       bool modify_all = true;
> -
> -       mutex_lock(&shared->timer_mutex);
> +       bool eval_load;
>
>         policy = shared->policy;
> -
> -       /*
> -        * Governor might already be disabled and there is no point continuing
> -        * with the work-handler.
> -        */
> -       if (!policy)
> -               goto unlock;
> -
>         dbs_data = policy->governor_data;
>
> +       /* Kill all timers */
> +       gov_cancel_timers(policy);
> +
>         if (dbs_data->cdata->governor == GOV_CONSERVATIVE) {
>                 struct cs_dbs_tuners *cs_tuners = dbs_data->tuners;
>
> @@ -250,14 +247,44 @@ static void dbs_timer(struct work_struct *work)
>                 sampling_rate = od_tuners->sampling_rate;
>         }
>
> -       if (!need_load_eval(cdbs->shared, sampling_rate))
> -               modify_all = false;
> +       eval_load = need_load_eval(shared, sampling_rate);
>
> -       delay = dbs_data->cdata->gov_dbs_timer(policy, modify_all);
> -       gov_queue_work(dbs_data, policy, delay, modify_all);
> +       /*
> +        * Make sure cpufreq_governor_limits() isn't evaluating load in
> +        * parallel.
> +        */
> +       mutex_lock(&shared->timer_mutex);
> +       delay = dbs_data->cdata->gov_dbs_timer(policy, eval_load);
> +       mutex_unlock(&shared->timer_mutex);
> +
> +       shared->skip_work--;

Ditto.

> +       gov_add_timers(policy, delay);
> +}
> +
> +static void dbs_timer_handler(unsigned long data)
> +{
> +       struct cpu_dbs_info *cdbs = (struct cpu_dbs_info *)data;
> +       struct cpu_common_dbs_info *shared = cdbs->shared;
> +       struct cpufreq_policy *policy;
> +       unsigned long flags;
> +
> +       spin_lock_irqsave(&shared->timer_lock, flags);
> +       policy = shared->policy;
> +
> +       /*
> +        * Timer handler isn't allowed to queue work at the moment, because:
> +        * - Another timer handler has done that
> +        * - We are stopping the governor
> +        * - Or we are updating the sampling rate of ondemand governor
> +        */
> +       if (shared->skip_work)
> +               goto unlock;
> +
> +       shared->skip_work++;
> +       queue_work(system_wq, &shared->work);
>

So, IIUC, in the event that this function gets called back to back and
the first Work hasn't dequeued yet, then this queue_work() will not
really enqueue, since queue_work_on() will return False? If so, then
does it mean we're skipping more recent CPU freq requests? Should we
cancel past Work if it hasn't been serviced?

Regards,
Ashwin.
