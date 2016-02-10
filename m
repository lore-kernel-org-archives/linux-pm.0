From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH] irq_work: unhide irq_work_queue_on declaration on non-SMP
Date: Wed, 10 Feb 2016 16:27:42 +0100
Message-ID: <CAJZ5v0h41Xm4LAZB_XiDjZih6g7W5aJjA-t3f=HFo1zGkAPSgA@mail.gmail.com>
References: <E1aTQoy-0005cH-Tr@optimist>
	<20160210095252.GS13270@sirena.org.uk>
	<CAJZ5v0iamr-b5h=eS1SWo6WMj_NNOqnXoxnC6R03VmtLBG5dEA@mail.gmail.com>
	<4447865.IoQjlk8ngP@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <4447865.IoQjlk8ngP@wuerfel>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, Lists linaro-kernel <linaro-kernel@lists.linaro.org>, "Rafael J. Wysocki" <rafael@kernel.org>, Mark Brown <broonie@kernel.org>, "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>, kernel-build-reports@lists.linaro.org, Viresh Kumar <viresh.kumar@linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, linux-next@vger.kernel.org, Frederic Weisbecker <fweisbec@gmail.com>, Thomas Gleixner <tglx@linutronix.de>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Wed, Feb 10, 2016 at 4:07 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> The cpufreq code uses 'if (IS_ENABLED(CONFIG_SMP))' to check
> whether it should queue a task on the local CPU or a remote
> one, however the irq_work_queue_on() function is not declared
> when CONFIG_SMP is not set:
>
> drivers/cpufreq/cpufreq_governor.c: In function 'gov_queue_irq_work':
> drivers/cpufreq/cpufreq_governor.c:251:3: error: implicit declaration of function 'irq_work_queue_on' [-Werror=implicit-function-declaration]
>    irq_work_queue_on(&policy_dbs->irq_work, smp_processor_id());
>
> This changes the conditional declaration so that irq_work_queue_on
> just queues the irq work on the only available CPU when CONFIG_SMP
> is not set, which is presumably what most people need anyway.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Fixes: 0144fa03ef46 ("cpufreq: governor: Replace timers with utilization update callbacks")
>
> diff --git a/include/linux/irq_work.h b/include/linux/irq_work.h
> index 47b9ebd4a74f..c9bde50ef317 100644
> --- a/include/linux/irq_work.h
> +++ b/include/linux/irq_work.h
> @@ -33,9 +33,13 @@ void init_irq_work(struct irq_work *work, void (*func)(struct irq_work *))
>  #define DEFINE_IRQ_WORK(name, _f) struct irq_work name = { .func = (_f), }
>
>  bool irq_work_queue(struct irq_work *work);
> -
>  #ifdef CONFIG_SMP
>  bool irq_work_queue_on(struct irq_work *work, int cpu);
> +#else
> +static inline bool irq_work_queue_on(struct irq_work *work, int cpu)
> +{
> +       return irq_work_queue(work);
> +}
>  #endif
>
>  void irq_work_tick(void);

I was thinking about this too, but then cpufreq will be the only user of it.

In any case can do it at any time later. :-)

Thanks,
Rafael
