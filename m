From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [RFC 7/9] cpufreq: governor: support scheduler cpufreq callbacks on remote CPUs
Date: Thu, 30 Mar 2017 00:14:30 +0200
Message-ID: <3331999.EqKcTVSiQr@aspire.rjw.lan>
References: <cover.1489058244.git.viresh.kumar@linaro.org> <49216ebaad6b26a1d5916350d07654181662b15b.1489058244.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:44956 "EHLO
        cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753985AbdC2WUN (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 29 Mar 2017 18:20:13 -0400
In-Reply-To: <49216ebaad6b26a1d5916350d07654181662b15b.1489058244.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, smuckle.linux@gmail.com, juri.lelli@arm.com, Morten.Rasmussen@arm.com, patrick.bellasi@arm.com, eas-dev@lists.linaro.org

On Thursday, March 09, 2017 05:15:17 PM Viresh Kumar wrote:
> From: Steve Muckle <smuckle.linux@gmail.com>
> 
> In preparation for the scheduler cpufreq callback happening on remote
> CPUs, add support for this in the legacy (ondemand and conservative)
> governors. The legacy governors make assumptions about the callback
> occurring on the CPU being updated.
> 
> Signed-off-by: Steve Muckle <smuckle.linux@gmail.com>
> [ vk: minor updates in commit log ]
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>  drivers/cpufreq/cpufreq_governor.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/cpufreq/cpufreq_governor.c b/drivers/cpufreq/cpufreq_governor.c
> index 47e24b5384b3..c9e786e7ee1f 100644
> --- a/drivers/cpufreq/cpufreq_governor.c
> +++ b/drivers/cpufreq/cpufreq_governor.c
> @@ -315,7 +315,7 @@ static void dbs_update_util_handler(struct update_util_data *data, u64 time,
>  
>  	policy_dbs->last_sample_time = time;
>  	policy_dbs->work_in_progress = true;
> -	irq_work_queue(&policy_dbs->irq_work);
> +	irq_work_queue_on(&policy_dbs->irq_work, data->cpu);

I'm totally unconvinced that this is sufficient.

This function carries out lockless computations with the assumption that it
will always run on the CPU being updated.

For instance, how is it prevented from being run on two CPUs in parallel in
the single-CPU policy case if cross-CPU updates are allowed to happen?

Second, is accessing rq_clock(rq) of a remote runqueue a good idea entirely?

Thanks,
Rafael
