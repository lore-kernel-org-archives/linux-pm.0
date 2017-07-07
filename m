From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [RFC PATCH v1 3/8] sched/cpufreq_schedutil: make worker kthread
 be SCHED_DEADLINE
Date: Fri, 7 Jul 2017 12:51:47 +0530
Message-ID: <20170707072147.GH1523@vireshk-i7>
References: <20170705085905.6558-1-juri.lelli@arm.com>
 <20170705085905.6558-4-juri.lelli@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pg0-f51.google.com ([74.125.83.51]:33879 "EHLO
        mail-pg0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750977AbdGGHVu (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 7 Jul 2017 03:21:50 -0400
Received: by mail-pg0-f51.google.com with SMTP id t186so13116251pgb.1
        for <linux-pm@vger.kernel.org>; Fri, 07 Jul 2017 00:21:50 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20170705085905.6558-4-juri.lelli@arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Juri Lelli <juri.lelli@arm.com>
Cc: peterz@infradead.org, mingo@redhat.com, rjw@rjwysocki.net, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, tglx@linutronix.de, vincent.guittot@linaro.org, rostedt@goodmis.org, luca.abeni@santannapisa.it, claudio@evidence.eu.com, tommaso.cucinotta@santannapisa.it, bristot@redhat.com, mathieu.poirier@linaro.org, tkjos@android.com, joelaf@google.com, andresoportus@google.com, morten.rasmussen@arm.com, dietmar.eggemann@arm.com, patrick.bellasi@arm.com, Ingo Molnar <mingo@kernel.org>, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>

On 05-07-17, 09:59, Juri Lelli wrote:
> diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
> index f2494d1fc8ef..ba6227625f24 100644
> --- a/kernel/sched/cpufreq_schedutil.c
> +++ b/kernel/sched/cpufreq_schedutil.c
> @@ -424,7 +424,16 @@ static void sugov_policy_free(struct sugov_policy *sg_policy)
>  static int sugov_kthread_create(struct sugov_policy *sg_policy)
>  {
>  	struct task_struct *thread;
> -	struct sched_param param = { .sched_priority = MAX_USER_RT_PRIO / 2 };
> +	struct sched_attr attr = {
> +		.size = sizeof(struct sched_attr),
> +		.sched_policy = SCHED_DEADLINE,
> +		.sched_flags = SCHED_FLAG_SPECIAL,
> +		.sched_nice = 0,
> +		.sched_priority = 0,
> +		.sched_runtime = 0,
> +		.sched_deadline = 0,
> +		.sched_period = 0,
> +	};
>  	struct cpufreq_policy *policy = sg_policy->policy;
>  	int ret;
>  
> @@ -442,10 +451,10 @@ static int sugov_kthread_create(struct sugov_policy *sg_policy)
>  		return PTR_ERR(thread);
>  	}
>  
> -	ret = sched_setscheduler_nocheck(thread, SCHED_FIFO, &param);
> +	ret = sched_setattr_nocheck(thread, &attr);
>  	if (ret) {
>  		kthread_stop(thread);
> -		pr_warn("%s: failed to set SCHED_FIFO\n", __func__);
> +		pr_warn("%s: failed to set SCHED_DEADLINE\n", __func__);
>  		return ret;
>  	}

Acked-by: Viresh Kumar <viresh.kumar@linaro.org> (schedutil)

-- 
viresh
