From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH V9] powercap/drivers/idle_injection: Add an idle injection
 framework
Date: Mon, 25 Jun 2018 13:48:26 +0200
Message-ID: <126b6192-cacc-5f99-105e-98fbc8409b0c@linaro.org>
References: <1529414627-5638-1-git-send-email-daniel.lezcano@linaro.org>
 <CAJZ5v0gv9jWyKvhYXrL2a8CqdhrWsNDJ59EDci_ezmfku-2_Ww@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAJZ5v0gv9jWyKvhYXrL2a8CqdhrWsNDJ59EDci_ezmfku-2_Ww@mail.gmail.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Eduardo Valentin <edubezval@gmail.com>, Javi Merino <javi.merino@kernel.org>, Leo Yan <leo.yan@linaro.org>, Kevin Wangtao <kevin.wangtao@linaro.org>, Vincent Guittot <vincent.guittot@linaro.org>, Rui Zhang <rui.zhang@intel.com>, Daniel Thompson <daniel.thompson@linaro.org>, Peter Zijlstra <peterz@infradead.org>, Andrea Parri <andrea.parri@amarulasolutions.com>, "open list:POWER MANAGEMENT CORE" <linux-pm@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On 25/06/2018 10:41, Rafael J. Wysocki wrote:
> On Tue, Jun 19, 2018 at 3:23 PM, Daniel Lezcano
> <daniel.lezcano@linaro.org> wrote:
> 
> [cut]
> 
> One more thing.
> 
>> +/**
>> + * idle_injection_register - idle injection init routine
>> + * @cpumask: the list of CPUs managed by the idle injection device
>> + *
>> + * This is the initialization function in charge of creating the
>> + * initializing of the timer and allocate the structures. It does not
>> + * starts the idle injection cycles.
>> + *
>> + * Return: NULL if an allocation fails.
>> + */
>> +struct idle_injection_device *idle_injection_register(struct cpumask *cpumask)
>> +{
>> +       struct idle_injection_device *ii_dev;
>> +       int cpu, cpu_rb;
>> +
>> +       ii_dev = kzalloc(sizeof(*ii_dev) + cpumask_size(), GFP_KERNEL);
>> +       if (!ii_dev)
>> +               return NULL;
>> +
>> +       cpumask_copy(to_cpumask(ii_dev->cpumask), cpumask);
>> +       hrtimer_init(&ii_dev->timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
>> +       ii_dev->timer.function = idle_injection_wakeup_fn;
>> +
>> +       for_each_cpu(cpu, to_cpumask(ii_dev->cpumask)) {
>> +
>> +               if (per_cpu(idle_injection_device, cpu)) {
>> +                       pr_err("cpu%d is already registered\n", cpu);
> 
> If you print something like this, it should be clear what it is about
> and what piece of code it comes from as there will be no context
> around it it the log.

Is the prefix as pointed by Viresh enough ? Or do want me to add a trace
like:

pr_err("Failed to register 'cpu%d', it is already registered", cpu);
(where "ii_dev:" gives the context)

?


-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
