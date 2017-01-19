From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH 3/3] cpuidle/menu: add per cpu pm_qos_resume_latency consideration
Date: Thu, 19 Jan 2017 22:43:23 +0100
Message-ID: <CAJZ5v0ifEfqN04XdDjjMQhuo6eznqgnj+VQEGFCUxzjzAxb2=g@mail.gmail.com>
References: <1484227624-6740-1-git-send-email-alex.shi@linaro.org>
 <1484227624-6740-4-git-send-email-alex.shi@linaro.org> <20170117093837.GA2085@mai>
 <01f9b016-0b7c-44ac-70e5-8cd9b8bd1500@linaro.org> <20170119102158.GA1827@mai>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ot0-f194.google.com ([74.125.82.194]:33059 "EHLO
        mail-ot0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751751AbdASVnh (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 19 Jan 2017 16:43:37 -0500
In-Reply-To: <20170119102158.GA1827@mai>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Alex Shi <alex.shi@linaro.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, Vincent Guittot <vincent.guittot@linaro.org>, Linux PM <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, Rasmus Villemoes <linux@rasmusvillemoes.dk>, Arjan van de Ven <arjan@linux.intel.com>, Rik van Riel <riel@redhat.com>

On Thu, Jan 19, 2017 at 11:21 AM, Daniel Lezcano
<daniel.lezcano@linaro.org> wrote:
> On Thu, Jan 19, 2017 at 05:25:37PM +0800, Alex Shi wrote:
>>
>> > That said, I have the feeling that is taking the wrong direction. Each time we
>> > are entering idle, we check the latencies. Entering idle can be done thousand
>> > of times per second. Wouldn't make sense to disable the states not fulfilling
>> > the constraints at the moment the latencies are changed ? As the idle states
>> > have increasing exit latencies, setting an idle state limit to disable all
>> > states after that limit may be more efficient than checking again and again in
>> > the idle path, no ?
>>
>> You'r right. save some checking is good thing to do.
>
> Hi Alex,
>
> I think you missed the point.
>
> What I am proposing is to change the current approach by disabling all the
> states after a specific latency.
>
> We add a specific internal function:
>
> static int cpuidle_set_latency(struct cpuidle_driver *drv,
>                                 struct cpuidle_device *dev,
>                                 int latency)
> {
>         int i, idx;
>
>         for (i = 0, idx = 0; i < drv->state_count; i++) {
>
>                 struct cpuidle_state *s = &drv->states[i];
>
>                 if (s->latency > latency)
>                         break;
>
>                 idx = i;
>         }
>
>         dev->state_count = idx;
>
>         return 0;
> }
>
> This function is called from the notifier callback:
>
> static int cpuidle_latency_notify(struct notifier_block *b,
>                 unsigned long l, void *v)
>  {
> -       wake_up_all_idle_cpus();
> +       struct cpuidle_device *dev;
> +       struct cpuidle_driver *drv;
> +
> +       cpuidle_pause_and_lock();
> +       for_each_possible_cpu(cpu) {
> +               dev = &per_cpu(cpuidle_dev, cpu);
> +               drv = = cpuidle_get_cpu_driver(dev);
> +               cpuidle_set_latency(drv, dev, l)
> +       }
> +       cpuidle_resume_and_unlock();
> +
>         return NOTIFY_OK;
>  }

The above may be problematic if the constraints change relatively
often.  It is global and it will affect all of the CPUs in the system
every time and now think about systems with hundreds of them.

Thanks,
Rafael
