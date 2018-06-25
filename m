From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH V9] powercap/drivers/idle_injection: Add an idle injection framework
Date: Mon, 25 Jun 2018 10:41:31 +0200
Message-ID: <CAJZ5v0gv9jWyKvhYXrL2a8CqdhrWsNDJ59EDci_ezmfku-2_Ww@mail.gmail.com>
References: <1529414627-5638-1-git-send-email-daniel.lezcano@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1529414627-5638-1-git-send-email-daniel.lezcano@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Eduardo Valentin <edubezval@gmail.com>, Javi Merino <javi.merino@kernel.org>, Leo Yan <leo.yan@linaro.org>, Kevin Wangtao <kevin.wangtao@linaro.org>, Vincent Guittot <vincent.guittot@linaro.org>, Rui Zhang <rui.zhang@intel.com>, Daniel Thompson <daniel.thompson@linaro.org>, Peter Zijlstra <peterz@infradead.org>, Andrea Parri <andrea.parri@amarulasolutions.com>, "open list:POWER MANAGEMENT CORE" <linux-pm@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Tue, Jun 19, 2018 at 3:23 PM, Daniel Lezcano
<daniel.lezcano@linaro.org> wrote:

[cut]

One more thing.

> +/**
> + * idle_injection_register - idle injection init routine
> + * @cpumask: the list of CPUs managed by the idle injection device
> + *
> + * This is the initialization function in charge of creating the
> + * initializing of the timer and allocate the structures. It does not
> + * starts the idle injection cycles.
> + *
> + * Return: NULL if an allocation fails.
> + */
> +struct idle_injection_device *idle_injection_register(struct cpumask *cpumask)
> +{
> +       struct idle_injection_device *ii_dev;
> +       int cpu, cpu_rb;
> +
> +       ii_dev = kzalloc(sizeof(*ii_dev) + cpumask_size(), GFP_KERNEL);
> +       if (!ii_dev)
> +               return NULL;
> +
> +       cpumask_copy(to_cpumask(ii_dev->cpumask), cpumask);
> +       hrtimer_init(&ii_dev->timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
> +       ii_dev->timer.function = idle_injection_wakeup_fn;
> +
> +       for_each_cpu(cpu, to_cpumask(ii_dev->cpumask)) {
> +
> +               if (per_cpu(idle_injection_device, cpu)) {
> +                       pr_err("cpu%d is already registered\n", cpu);

If you print something like this, it should be clear what it is about
and what piece of code it comes from as there will be no context
around it it the log.

> +                       goto out_rollback_per_cpu;

Shorten the label perhaps?

> +               }
> +
> +               per_cpu(idle_injection_device, cpu) = ii_dev;
> +       }
> +
> +       return ii_dev;
> +
> +out_rollback_per_cpu:
> +       for_each_cpu(cpu_rb, to_cpumask(ii_dev->cpumask)) {
> +               if (cpu == cpu_rb)
> +                       break;
> +               per_cpu(idle_injection_device, cpu_rb) = NULL;
> +       }
> +
> +       kfree(ii_dev);
> +
> +       return NULL;
> +}
> +
