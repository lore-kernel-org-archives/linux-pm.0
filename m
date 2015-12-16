From: Leo Yan <leo.yan@linaro.org>
Subject: Re: [RFCv6 PATCH 03/10] sched: scheduler-driven cpu frequency
 selection
Date: Wed, 16 Dec 2015 11:48:25 +0800
Message-ID: <20151216034825.GA11303@leoy-linaro>
References: <1449641971-20827-1-git-send-email-smuckle@linaro.org>
 <1449641971-20827-4-git-send-email-smuckle@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f41.google.com ([209.85.220.41]:35707 "EHLO
	mail-pa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753612AbbLPDsk (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 15 Dec 2015 22:48:40 -0500
Received: by mail-pa0-f41.google.com with SMTP id hk6so16249408pad.2
        for <linux-pm@vger.kernel.org>; Tue, 15 Dec 2015 19:48:40 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1449641971-20827-4-git-send-email-smuckle@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Steve Muckle <steve.muckle@linaro.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, Morten Rasmussen <morten.rasmussen@arm.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, Juri Lelli <Juri.Lelli@arm.com>, Patrick Bellasi <patrick.bellasi@arm.com>, Michael Turquette <mturquette@baylibre.com>, Ricky Liang <jcliang@chromium.org>

Hi Steve,

On Tue, Dec 08, 2015 at 10:19:24PM -0800, Steve Muckle wrote:

[...]

> +static int cpufreq_sched_thread(void *data)
> +{
> +	struct sched_param param;
> +	struct cpufreq_policy *policy;
> +	struct gov_data *gd;
> +	unsigned int new_request = 0;
> +	unsigned int last_request = 0;
> +	int ret;
> +
> +	policy = (struct cpufreq_policy *) data;
> +	gd = policy->governor_data;
> +
> +	param.sched_priority = 50;
> +	ret = sched_setscheduler_nocheck(gd->task, SCHED_FIFO, &param);
> +	if (ret) {
> +		pr_warn("%s: failed to set SCHED_FIFO\n", __func__);
> +		do_exit(-EINVAL);
> +	} else {
> +		pr_debug("%s: kthread (%d) set to SCHED_FIFO\n",
> +				__func__, gd->task->pid);
> +	}
> +
> +	do {
> +		set_current_state(TASK_INTERRUPTIBLE);
> +		new_request = gd->requested_freq;
> +		if (new_request == last_request) {
> +			schedule();
> +		} else {
> +			/*
> +			 * if the frequency thread sleeps while waiting to be
> +			 * unthrottled, start over to check for a newer request
> +			 */
> +			if (finish_last_request(gd))
> +				continue;
> +			last_request = new_request;
> +			cpufreq_sched_try_driver_target(policy, new_request);
> +		}

I also think "set_current_state(TASK_INTERRUPTIBLE)" will introduce
logic error when software flow run into "else" block. The reason is
after you set state with TASK_INTERRUPTIBLE, if there have some
scheduling happen within cpufreq_sched_try_driver_target(), then the
thread will be remove from rq. But generally we suppose the thread
will be on rq and can continue run after next tick.

Juri's suggestion can fix this issue. And we can use atomic_t to
safely accessing gd->requested_freq.

[...]

Thanks,
Leo Yan
