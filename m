From: Punit Agrawal <punit.agrawal@arm.com>
Subject: Re: [RFCv5 PATCH 38/46] sched: scheduler-driven cpu frequency selection
Date: Mon, 28 Sep 2015 17:48:41 +0100
Message-ID: <9hh8u7qa3rq.fsf@e105922-lin.cambridge.arm.com>
References: <1436293469-25707-1-git-send-email-morten.rasmussen@arm.com>
	<1436293469-25707-39-git-send-email-morten.rasmussen@arm.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from fw-tnat.cambridge.arm.com ([217.140.96.140]:58813 "EHLO
	cam-smtp0.cambridge.arm.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S933924AbbI1Qtn (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 28 Sep 2015 12:49:43 -0400
In-Reply-To: <1436293469-25707-39-git-send-email-morten.rasmussen@arm.com>
	(Morten Rasmussen's message of "Tue, 7 Jul 2015 19:24:21 +0100")
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: mturquette@baylibre.com
Cc: Morten Rasmussen <morten.rasmussen@arm.com>, peterz@infradead.org, mingo@redhat.com, vincent.guittot@linaro.org, daniel.lezcano@linaro.org, Dietmar Eggemann <Dietmar.Eggemann@arm.com>, yuyang.du@intel.com, rjw@rjwysocki.net, Juri Lelli <Juri.Lelli@arm.com>, sgurrappadi@nvidia.com, pang.xunlei@zte.com.cn, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org

Hi Mike,

I ran into an issue when using this patch. Posting it here as this is
the latest posting I can find.

Morten Rasmussen <morten.rasmussen@arm.com> writes:

> From: Michael Turquette <mturquette@baylibre.com>
>
> Scheduler-driven cpu frequency selection is desirable as part of the
> on-going effort to make the scheduler better aware of energy
> consumption.  No piece of the Linux kernel has a better view of the
> factors that affect a cpu frequency selection policy than the
> scheduler[0], and this patch is an attempt to converge on an initial
> solution.
>
> This patch implements a simple shim layer between the Linux scheduler
> and the cpufreq subsystem. This interface accepts a capacity request
> from the Completely Fair Scheduler and honors the max request from all
> cpus in the same frequency domain.
>
> The policy magic comes from choosing the cpu capacity request from cfs
> and is not contained in this cpufreq governor. This code is
> intentionally dumb.
>
> Note that this "governor" is event-driven. There is no polling loop to
> check cpu idle time nor any other method which is unsynchronized with
> the scheduler.
>
> Thanks to Juri Lelli <juri.lelli@arm.com> for contributing design ideas,
> code and test results.
>
> [0] http://article.gmane.org/gmane.linux.kernel/1499836
>
> Signed-off-by: Michael Turquette <mturquette@baylibre.com>
> Signed-off-by: Juri Lelli <juri.lelli@arm.com>
> ---
>  drivers/cpufreq/Kconfig      |  24 ++++
>  include/linux/cpufreq.h      |   3 +
>  kernel/sched/Makefile        |   1 +
>  kernel/sched/cpufreq_sched.c | 308 +++++++++++++++++++++++++++++++++++++++++++
>  kernel/sched/sched.h         |   8 ++
>  5 files changed, 344 insertions(+)
>  create mode 100644 kernel/sched/cpufreq_sched.c
>
> diff --git a/drivers/cpufreq/Kconfig b/drivers/cpufreq/Kconfig
> index 659879a..9bbf44c 100644
> --- a/drivers/cpufreq/Kconfig
> +++ b/drivers/cpufreq/Kconfig
> @@ -102,6 +102,15 @@ config CPU_FREQ_DEFAULT_GOV_CONSERVATIVE
>  	  Be aware that not all cpufreq drivers support the conservative
>  	  governor. If unsure have a look at the help section of the
>  	  driver. Fallback governor will be the performance governor.
> +
> +config CPU_FREQ_DEFAULT_GOV_SCHED
> +	bool "sched"
> +	select CPU_FREQ_GOV_SCHED
> +	select CPU_FREQ_GOV_PERFORMANCE
> +	help
> +	  Use the CPUfreq governor 'sched' as default. This scales
> +	  cpu frequency from the scheduler as per-entity load tracking
> +	  statistics are updated.
>  endchoice
>  
>  config CPU_FREQ_GOV_PERFORMANCE
> @@ -183,6 +192,21 @@ config CPU_FREQ_GOV_CONSERVATIVE
>  
>  	  If in doubt, say N.
>  
> +config CPU_FREQ_GOV_SCHED
> +	tristate "'sched' cpufreq governor"
> +	depends on CPU_FREQ
> +	select CPU_FREQ_GOV_COMMON
> +	help
> +	  'sched' - this governor scales cpu frequency from the
> +	  scheduler as a function of cpu capacity utilization. It does
> +	  not evaluate utilization on a periodic basis (as ondemand
> +	  does) but instead is invoked from the completely fair
> +	  scheduler when updating per-entity load tracking statistics.
> +	  Latency to respond to changes in load is improved over polling
> +	  governors due to its event-driven design.
> +
> +	  If in doubt, say N.
> +
>  comment "CPU frequency scaling drivers"
>  
>  config CPUFREQ_DT
> diff --git a/include/linux/cpufreq.h b/include/linux/cpufreq.h
> index 1f2c9a1..30241c9 100644
> --- a/include/linux/cpufreq.h
> +++ b/include/linux/cpufreq.h
> @@ -494,6 +494,9 @@ extern struct cpufreq_governor cpufreq_gov_ondemand;
>  #elif defined(CONFIG_CPU_FREQ_DEFAULT_GOV_CONSERVATIVE)
>  extern struct cpufreq_governor cpufreq_gov_conservative;
>  #define CPUFREQ_DEFAULT_GOVERNOR	(&cpufreq_gov_conservative)
> +#elif defined(CONFIG_CPU_FREQ_DEFAULT_GOV_SCHED_GOV)
> +extern struct cpufreq_governor cpufreq_gov_sched_gov;
> +#define CPUFREQ_DEFAULT_GOVERNOR	(&cpufreq_gov_sched)
>  #endif

You have extra 'gov' in CONFIG_CPU_FREQ_DEFAULT_GOV_SCHED_GOV and
cpufreq_gov_sched_gov above.


[...]

