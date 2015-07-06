From: Dietmar Eggemann <dietmar.eggemann@arm.com>
Subject: Re: [PATCH v3 3/4] sched: scheduler-driven cpu frequency selection
Date: Mon, 06 Jul 2015 21:06:38 +0100
Message-ID: <559ADFCE.3050103@arm.com>
References: <1435362824-26734-1-git-send-email-mturquette@linaro.org> <1435362824-26734-4-git-send-email-mturquette@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: 8BIT
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from eu-smtp-delivery-143.mimecast.com ([146.101.78.143]:27838 "EHLO
	eu-smtp-delivery-143.mimecast.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754441AbbGFUGl convert rfc822-to-8bit
	(ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Mon, 6 Jul 2015 16:06:41 -0400
In-Reply-To: <1435362824-26734-4-git-send-email-mturquette@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Michael Turquette <mturquette@baylibre.com>, "peterz@infradead.org" <peterz@infradead.org>, "mingo@kernel.org" <mingo@kernel.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "preeti@linux.vnet.ibm.com" <preeti@linux.vnet.ibm.com>, Morten Rasmussen <Morten.Rasmussen@arm.com>, "riel@redhat.com" <riel@redhat.com>, "efault@gmx.de" <efault@gmx.de>, "nicolas.pitre@linaro.org" <nicolas.pitre@linaro.org>, "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>, "vincent.guittot@linaro.org" <vincent.guittot@linaro.org>, "amit.kucheria@linaro.org" <amit.kucheria@linaro.org>, Juri Lelli <Juri.Lelli@arm.com>, "rjw@rjwysocki.net" <rjw@rjwysocki.net>, "viresh.kumar@linaro.org" <viresh.kumar@linaro.org>, "ashwin.chaugule@linaro.org" <ashwin.chaugule@linaro.org>, "alex.shi@linaro.org" <alex.shi@linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "abelvesa@gmail.com" <abelvesa@gmail.com>, "pebolle@tiscali.nl" <pebolle@tiscali.nl>

Hi Mike,

On 27/06/15 00:53, Michael Turquette wrote:
> From: Michael Turquette <mturquette@baylibre.com>
> 

[...]

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
>  #define CPUFREQ_DEFAULT_GOVERNOR       (&cpufreq_gov_conservative)
> +#elif defined(CONFIG_CPU_FREQ_DEFAULT_GOV_SCHED_GOV)
> +extern struct cpufreq_governor cpufreq_gov_sched_gov;

To get it building with CONFIG_CPU_FREQ_DEFAULT_GOV_SCHED=y .

-#elif defined(CONFIG_CPU_FREQ_DEFAULT_GOV_SCHED_GOV)
-extern struct cpufreq_governor cpufreq_gov_sched_gov;
+#elif defined(CONFIG_CPU_FREQ_DEFAULT_GOV_SCHED)
+extern struct cpufreq_governor cpufreq_gov_sched;

> +#define CPUFREQ_DEFAULT_GOVERNOR       (&cpufreq_gov_sched)
>  #endif

> +
> +/**
> + * cpufreq_sched_set_capacity - interface to scheduler for changing capacity values

[...]

minor nit:

s/cpufreq_sched_set_capacity/cpufreq_sched_set_cap

> + * @cpu: cpu whose capacity utilization has recently changed
> + * @capacity: the new capacity requested by cpu
> + *
> + * cpufreq_sched_sched_capacity is an interface exposed to the scheduler so
> + * that the scheduler may inform the governor of updates to capacity
> + * utilization and make changes to cpu frequency. Currently this interface is
> + * designed around PELT values in CFS. It can be expanded to other scheduling
> + * classes in the future if needed.
> + *
> + * cpufreq_sched_set_capacity raises an IPI. The irq_work handler for that IPI
> + * wakes up the thread that does the actual work, cpufreq_sched_thread.
> + *
> + * This functions bails out early if either condition is true:
> + * 1) this cpu did not the new maximum capacity for its frequency domain
> + * 2) no change in cpu frequency is necessary to meet the new capacity request
> + */
> +void cpufreq_sched_set_cap(int cpu, unsigned long capacity)
> +{
> +       unsigned int freq_new, cpu_tmp;
> +       struct cpufreq_policy *policy;
> +       struct gov_data *gd;
> +       unsigned long capacity_max = 0;

[...]

