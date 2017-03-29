From: Kevin Hilman <khilman@baylibre.com>
Subject: Re: [PATCH V5 3/9] kernel/cpu_pm: Add runtime PM support for CPUs
Date: Wed, 29 Mar 2017 16:54:53 -0700
Message-ID: <m2tw6b4p0y.fsf@baylibre.com>
References: <1488573695-106680-1-git-send-email-lina.iyer@linaro.org>
        <1488573695-106680-4-git-send-email-lina.iyer@linaro.org>
        <CAPDyKFqXLzuge6+pQV-UzotENTV2gxZUCT6eU4CLtckdNZoYSw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <CAPDyKFqXLzuge6+pQV-UzotENTV2gxZUCT6eU4CLtckdNZoYSw@mail.gmail.com>
        (Ulf Hansson's message of "Tue, 14 Mar 2017 08:45:00 +0100")
Sender: linux-arm-msm-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Lina Iyer <lina.iyer@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Andy Gross <andy.gross@linaro.org>, Stephen Boyd <sboyd@codeaurora.org>, "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>, Brendan Jackman <brendan.jackman@arm.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Sudeep Holla <sudeep.holla@arm.com>, Juri Lelli <Juri.Lelli@arm.com>
List-Id: linux-pm@vger.kernel.org

Ulf Hansson <ulf.hansson@linaro.org> writes:

> On 3 March 2017 at 21:41, Lina Iyer <lina.iyer@linaro.org> wrote:
>> Notify runtime PM when the CPU is going to be powered off in the idle
>> state. This allows for runtime PM suspend/resume of the CPU as well as
>> its PM domain.
>>
>> Cc: Kevin Hilman <khilman@kernel.org>
>> Cc: Rafael J. Wysocki <rjw@rjwysocki.net>
>> Signed-off-by: Lina Iyer <lina.iyer@linaro.org>

[...]

>> @@ -99,6 +102,7 @@ int cpu_pm_enter(void)
>>  {
>>         int nr_calls;
>>         int ret = 0;
>> +       struct device *dev = get_cpu_device(smp_processor_id());
>>
>>         read_lock(&cpu_pm_notifier_lock);
>>         ret = cpu_pm_notify(CPU_PM_ENTER, -1, &nr_calls);
>> @@ -110,6 +114,10 @@ int cpu_pm_enter(void)
>>                 cpu_pm_notify(CPU_PM_ENTER_FAILED, nr_calls - 1, NULL);
>>         read_unlock(&cpu_pm_notifier_lock);
>>
>> +       /* Notify Runtime PM that we are suspending the CPU */
>> +       if (!ret && dev)
>> +               RCU_NONIDLE(pm_runtime_put_sync_suspend(dev));
>> +
>
> I am trying to understand how the runtime PM usage count becomes
> properly balanced.
>
> I believe you could you end up first calling a
> pm_runtime_put_sync_suspend(), without earlier having called
> pm_runtime_get*(). I am not sure though, but perhaps you can
> elaborate.
>
> Anyway, in patch2/9, where you enable runtime PM there is only a call
> to pm_runtime_set_active(), which doesn't increase the usage count. To
> me, it seems like that change also needs a pm_runtime_get_noresume().

IIUC, the CPU hotplug callback below (cpu_pm_cpu_starting) will do the
first _get_sync(), and I'm assuming that will happen before any of the
CPU PM notifiers get called, so I think the usecount will always be at
least 1 by the time any CPU PM callbacks happen.

[...]

>> +#ifdef CONFIG_HOTPLUG_CPU
>> +static int cpu_pm_cpu_dying(unsigned int cpu)
>> +{
>> +       struct device *dev = get_cpu_device(cpu);
>> +
>> +       if (dev)
>> +               pm_runtime_put_sync_suspend(dev);
>> +
>> +       return 0;
>> +}
>> +
>> +static int cpu_pm_cpu_starting(unsigned int cpu)
>> +{
>> +       struct device *dev = get_cpu_device(cpu);
>> +
>> +       if (dev)
>> +               pm_runtime_get_sync(dev);
>
> I assume that according to my comment above, you somehow need to
> compensate for either of the cases when CONFIG_HOTPLUG_CPU is set or
> unset. Right?

Right, if for some reason CONFIG_HOTPLUG_CPU=n, we'll have a problem
where there is never an initial _get() so the usecount will be zero when
CPU PM notifiers get called the first time.

Kevin
