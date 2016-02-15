From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: Crashes in arm qemu emulations due to 'cpufreq: governor: Replace
 timers with utilization ...'
Date: Mon, 15 Feb 2016 20:12:33 +0100
Message-ID: <CAJZ5v0gXGzzJ7CcbgNNO-ULrtd9Z2hbqHeuXRYJLFLrh+BWVWA@mail.gmail.com>
References: <20160215170527.GA24453@roeck-us.net>
	<CAJZ5v0gLankSuziQq25qTCyNqeOX43yD9jnJu_XXwbdyajfmKg@mail.gmail.com>
	<56C21DD0.40508@arm.com>
	<CAJZ5v0gfOVyoWeee5jg7NxLFm-xwdA6-sPQV+cJ=NWJOV-wYzg@mail.gmail.com>
	<56C22105.6050900@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-next-owner@vger.kernel.org>
In-Reply-To: <56C22105.6050900@arm.com>
Sender: linux-next-owner@vger.kernel.org
To: Marc Zyngier <marc.zyngier@arm.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Guenter Roeck <linux@roeck-us.net>, Viresh Kumar <viresh.kumar@linaro.org>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, linux-next@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>
List-Id: linux-pm@vger.kernel.org

On Mon, Feb 15, 2016 at 8:03 PM, Marc Zyngier <marc.zyngier@arm.com> wrote:
> On 15/02/16 18:54, Rafael J. Wysocki wrote:
>> On Mon, Feb 15, 2016 at 7:49 PM, Marc Zyngier <marc.zyngier@arm.com> wrote:
>>> On 15/02/16 18:41, Rafael J. Wysocki wrote:
>>>> On Mon, Feb 15, 2016 at 6:05 PM, Guenter Roeck <linux@roeck-us.net> wrote:
>>>>> Rafael,
>>>>
>>>> Hi,
>>>>
>>>> Thanks for the report!
>>>>
>>>>> I see crashes in various arm qemu tests due to 'cpufreq: governor: Replace
>>>>> timers with utilization update callbacks' with next-20160215. An example
>>>>> crash log and bisect results are attached below.
>>>>>
>>>>> Please let me know if there is anything I can do to help tracking down
>>>>> the problem.
>>>>
>>>> It looks like we've uncovered some nastiness in the arch ARM code (see below).
>>>>
>>>> [cut]
>>>>
>>>>> [    1.340000] Unable to handle kernel NULL pointer dereference at virtual address 00000000
>>>>> [    1.340000] pgd = c0204000
>>>>> [    1.340000] [00000000] *pgd=00000000
>>>>> [    1.340000] Internal error: Oops: 80000005 [#1] SMP ARM
>>>>> [    1.340000] Modules linked in:
>>>>> [    1.340000] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 4.5.0-rc4-next-20160215 #1
>>>>> [    1.340000] Hardware name: Generic OMAP3-GP (Flattened Device Tree)
>>>>> [    1.340000] task: cb060000 ti: cb05a000 task.ti: cb05a000
>>>>> [    1.340000] PC is at 0x0
>>>>> [    1.340000] LR is at arch_send_call_function_single_ipi+0x34/0x38
>>>>
>>>> Since this is ARM, arch_send_call_function_single_ipi() looks like this:
>>>>
>>>> void arch_send_call_function_single_ipi(int cpu)
>>>> {
>>>>          smp_cross_call(cpumask_of(cpu), IPI_CALL_FUNC_SINGLE);
>>>> }
>>>>
>>>> so I'm not sure how the NULL pointer deref is possible even.
>>>>
>>>> The only thing coming to mind would be that cpumask_of(cpu) triggers
>>>> this, but I'm not sure how exactly that can happen.
>>>>
>>>> I need help from somebody who knows how this low-level stuff works on ARM.
>>>
>>> Given that OMAP3 is a UP system, there is zero chance that it has
>>> registered the magic hook that delivers IPIs (its interrupt controller
>>> is not even capable of doing so).
>>>
>>> I don't really know the context, but IPIs on a UP system seem at best odd.
>>
>> That would explain it, thanks.
>>
>> So it looks like we should always use irq_work_queue() on UP even if
>> CONFIG_SMP is set, shouldn't we?
>
> Something like that, yes. CONFIG_SMP is not an indication of an SMP
> system anymore (we've even dropped the config option on arm64).
>
> Hopefully num_possible_cpus() is reliable enough to let you do the right
> thing...

Well, in fact I can always use irq_work_queue() in there at least for
the time being.

Let me prepare a patch.

Thanks,
Rafael
