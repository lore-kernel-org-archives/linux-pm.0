From: Brendan Jackman <brendan.jackman@arm.com>
Subject: Re: [PATCH] cpufreq: dt: Set default policy->transition_delay_ns
Date: Mon, 22 May 2017 11:45:53 +0100
Message-ID: <87h90d2mqm.fsf@arm.com>
References: <16157eb75bb26cca73a0da930e49f2549b96fd65.1495429745.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:34740 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1757403AbdEVKp4 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 22 May 2017 06:45:56 -0400
In-reply-to: <16157eb75bb26cca73a0da930e49f2549b96fd65.1495429745.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>

Hi Viresh,

On Mon, May 22 2017 at 05:10, Viresh Kumar wrote:
> The rate_limit_us for the schedutil governor is getting set to 500 ms by
> default for the ARM64 hikey board. And its way too much, even for the
> default value. Lets set the default transition_delay_ns to something
> more realistic (10 ms), while the userspace always have a chance to set
> something it wants.

Just a thought - do you think we can treat the reported transition
latency as a proxy for the "cost" of freq transitions?  I.e. assume that
on platforms with very fast frequency switching it's probably cheap to
switch frequency and we want schedutil to respond quickly, whereas on
platforms with big latencies, frequency switches might be expensive and
we probably want hysteresis.

If that makes sense then maybe we could use 10 * transition_latency /
NSEC_PER_USEC, when transition_latency is reported? Otherwise 10ms seems
sensible to me..

Cheers,
Brendan

>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>  drivers/cpufreq/cpufreq-dt.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/drivers/cpufreq/cpufreq-dt.c b/drivers/cpufreq/cpufreq-dt.c
> index c943787d761e..70eac3fd89ac 100644
> --- a/drivers/cpufreq/cpufreq-dt.c
> +++ b/drivers/cpufreq/cpufreq-dt.c
> @@ -275,6 +275,9 @@ static int cpufreq_init(struct cpufreq_policy *policy)
>
>  	policy->cpuinfo.transition_latency = transition_latency;
>
> +	/* Set the default transition delay to 10ms */
> +	policy->transition_delay_us = 10 * USEC_PER_MSEC;
> +
>  	return 0;
>
>  out_free_cpufreq_table:
