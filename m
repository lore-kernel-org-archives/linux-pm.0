From: Joel Fernandes <joelaf@google.com>
Subject: Re: [PATCH 4/4] cpufreq: schedutil: Don't call sugov_get_util() unnecessarily
Date: Mon, 18 Dec 2017 19:26:21 -0800
Message-ID: <CAJWu+ooZLrX05=HaqSX3nExxkhGS-7jCjQvFOL7in_QEP8heKw@mail.gmail.com>
References: <cover.1513158452.git.viresh.kumar@linaro.org> <7b0698a61bcb959704f58dbabe8c70d657210301.1513158452.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-it0-f65.google.com ([209.85.214.65]:41528 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934635AbdLSD0X (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 18 Dec 2017 22:26:23 -0500
Received: by mail-it0-f65.google.com with SMTP id x28so1142105ita.0
        for <linux-pm@vger.kernel.org>; Mon, 18 Dec 2017 19:26:23 -0800 (PST)
In-Reply-To: <7b0698a61bcb959704f58dbabe8c70d657210301.1513158452.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Linux PM <linux-pm@vger.kernel.org>, Vincent Guittot <vincent.guittot@linaro.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>, Morten Rasmussen <morten.rasmussen@arm.com>, Juri Lelli <juri.lelli@redhat.com>, Todd Kjos <tkjos@android.com>, LKML <linux-kernel@vger.kernel.org>

On Wed, Dec 13, 2017 at 1:53 AM, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> sugov_update_shared() may get called to clear the scheduling class flags
> and we would return immediately in that case. Calling sugov_get_util()
> in that case isn't going to be of any use then. Move invocation of
> sugov_get_util() after the clear flag is checked.
>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>  kernel/sched/cpufreq_schedutil.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
> index 7edfdc59ee8f..b69c37c867fe 100644
> --- a/kernel/sched/cpufreq_schedutil.c
> +++ b/kernel/sched/cpufreq_schedutil.c
> @@ -349,8 +349,6 @@ static void sugov_update_shared(struct update_util_data *hook, u64 time,
>         unsigned long util, max;
>         unsigned int next_f;
>
> -       sugov_get_util(&util, &max, sg_cpu->cpu);
> -
>         raw_spin_lock(&sg_policy->update_lock);
>
>         if (unlikely(flags & SCHED_CPUFREQ_CLEAR)) {
> @@ -358,6 +356,8 @@ static void sugov_update_shared(struct update_util_data *hook, u64 time,
>                 goto unlock;
>         }
>
> +       sugov_get_util(&util, &max, sg_cpu->cpu);
> +
>         sg_cpu->util = util;

Reviewed-by: Joel Fernandes <joelaf@google.com>

Thanks,

- Joel
