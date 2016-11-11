From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH 1/3] cpufreq: schedutil: enable fast switch earlier
Date: Fri, 11 Nov 2016 22:58:08 +0100
Message-ID: <CAJZ5v0gMDoLrdCqxnyUQqWydqj6Ot0ssf=P9=hOk_bOG9gCi0Q@mail.gmail.com>
References: <cover.1478858983.git.viresh.kumar@linaro.org> <1acfffe798c0371e69ec1171f485499e7b49ed6d.1478858983.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-qt0-f195.google.com ([209.85.216.195]:36122 "EHLO
        mail-qt0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934163AbcKKV6J (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 11 Nov 2016 16:58:09 -0500
In-Reply-To: <1acfffe798c0371e69ec1171f485499e7b49ed6d.1478858983.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Lists linaro-kernel <linaro-kernel@lists.linaro.org>, Linux PM <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Vincent Guittot <vincent.guittot@linaro.org>, Juri Lelli <Juri.Lelli@arm.com>, Robin Randhawa <robin.randhawa@arm.com>

On Fri, Nov 11, 2016 at 11:22 AM, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> The fast_switch_enabled flag will be used a bit earlier while converting
> the schedutil governor to use kthread worker.
>
> Prepare for that by moving the call to enable it to the beginning of
> sugov_init().

Fair enough ->

> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>  kernel/sched/cpufreq_schedutil.c | 17 +++++++++++------
>  1 file changed, 11 insertions(+), 6 deletions(-)
>
> diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
> index 69e06898997d..ccb2ab89affb 100644
> --- a/kernel/sched/cpufreq_schedutil.c
> +++ b/kernel/sched/cpufreq_schedutil.c
> @@ -416,9 +416,13 @@ static int sugov_init(struct cpufreq_policy *policy)
>         if (policy->governor_data)
>                 return -EBUSY;
>
> +       cpufreq_enable_fast_switch(policy);
> +
>         sg_policy = sugov_policy_alloc(policy);
> -       if (!sg_policy)
> -               return -ENOMEM;
> +       if (!sg_policy) {
> +               ret = -ENOMEM;
> +               goto disable_fast_switch;
> +       }
>
>         mutex_lock(&global_tunables_lock);
>
> @@ -456,8 +460,6 @@ static int sugov_init(struct cpufreq_policy *policy)
>
>   out:
>         mutex_unlock(&global_tunables_lock);
> -
> -       cpufreq_enable_fast_switch(policy);
>         return 0;
>
>   fail:
> @@ -468,6 +470,10 @@ static int sugov_init(struct cpufreq_policy *policy)
>         mutex_unlock(&global_tunables_lock);
>
>         sugov_policy_free(sg_policy);
> +
> + disable_fast_switch:
> +       cpufreq_disable_fast_switch(policy);
> +
>         pr_err("initialization failed (error %d)\n", ret);
>         return ret;
>  }
> @@ -478,8 +484,6 @@ static void sugov_exit(struct cpufreq_policy *policy)
>         struct sugov_tunables *tunables = sg_policy->tunables;
>         unsigned int count;
>
> -       cpufreq_disable_fast_switch(policy);
> -

->but why is this change necessary?

sugov_stop() has been called already, so the ordering here shouldn't matter.

>         mutex_lock(&global_tunables_lock);
>
>         count = gov_attr_set_put(&tunables->attr_set, &sg_policy->tunables_hook);
> @@ -490,6 +494,7 @@ static void sugov_exit(struct cpufreq_policy *policy)
>         mutex_unlock(&global_tunables_lock);
>
>         sugov_policy_free(sg_policy);
> +       cpufreq_disable_fast_switch(policy);
>  }
>
>  static int sugov_start(struct cpufreq_policy *policy)
> --

Thanks,
Rafael
