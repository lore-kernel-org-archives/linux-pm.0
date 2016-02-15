From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: Crashes in arm qemu emulations due to 'cpufreq: governor: Replace
 timers with utilization ...'
Date: Mon, 15 Feb 2016 21:41:09 +0100
Message-ID: <CAJZ5v0iC6H9Br21u4=3ykSHJzSJUb7ZMBY_iZNyu74WKO6gnYw@mail.gmail.com>
References: <20160215170527.GA24453@roeck-us.net>
	<CAJZ5v0gLankSuziQq25qTCyNqeOX43yD9jnJu_XXwbdyajfmKg@mail.gmail.com>
	<56C21DD0.40508@arm.com>
	<CAJZ5v0gfOVyoWeee5jg7NxLFm-xwdA6-sPQV+cJ=NWJOV-wYzg@mail.gmail.com>
	<56C22105.6050900@arm.com>
	<20160215192316.GO10826@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-lf0-f44.google.com ([209.85.215.44]:33255 "EHLO
	mail-lf0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751697AbcBOUlL (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 15 Feb 2016 15:41:11 -0500
In-Reply-To: <20160215192316.GO10826@n2100.arm.linux.org.uk>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Marc Zyngier <marc.zyngier@arm.com>, "Rafael J. Wysocki" <rafael@kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, Viresh Kumar <viresh.kumar@linaro.org>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-next@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On Mon, Feb 15, 2016 at 8:23 PM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Mon, Feb 15, 2016 at 07:03:33PM +0000, Marc Zyngier wrote:
>> On 15/02/16 18:54, Rafael J. Wysocki wrote:
>> > That would explain it, thanks.
>> >
>> > So it looks like we should always use irq_work_queue() on UP even if
>> > CONFIG_SMP is set, shouldn't we?
>>
>> Something like that, yes. CONFIG_SMP is not an indication of an SMP
>> system anymore (we've even dropped the config option on arm64).
>>
>> Hopefully num_possible_cpus() is reliable enough to let you do the right
>> thing...
>
> CONFIG_SMP just says whether to include support for SMP.  It doesn't
> mandate running on a SMP system. :)
>
> I've been looking around the usages of irq_work_queue_on in kernel/
> in -rc4, and some places seem to check for "this CPU":
>
>         /*
>          * It is possible that a restart caused this CPU to be
>          * chosen again. Don't bother with an IPI, just see if we
>          * have more to push.
>          */
>         if (unlikely(cpu == rq->cpu))
>                 goto again;
>
>         /* Try the next RT overloaded CPU */
>         irq_work_queue_on(&rt_rq->push_work, cpu);
>
> I'm not sure about tell_cpu_to_push().
>
> It's also called via tick_nohz_full_kick_cpu(), and the core scheduler
> avoids calling this for the current CPU:
>
>         if (tick_nohz_full_cpu(cpu)) {
>                 if (cpu != smp_processor_id() ||
>                     tick_nohz_tick_stopped())
>                         tick_nohz_full_kick_cpu(cpu);
>
> I'm not sure about add_nr_running() in kernel/sched/sched.h - I think
> that _could_ be a problem even without Rafael's cpufreq change.
>
> So... the question is what do we do with irq_work_queue_on() in general
> when called on non-SMP systems.

I guess it might fall back to arch_irq_work_raise() when asked to
queue on the same CPU, so long as that will always do the right thing
(ie. actually queue on the same one).

Thanks,
Rafael
