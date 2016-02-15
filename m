From: Guenter Roeck <linux@roeck-us.net>
Subject: Re: Crashes in arm qemu emulations due to 'cpufreq: governor: Replace
 timers with utilization ...'
Date: Mon, 15 Feb 2016 11:40:21 -0800
Message-ID: <56C229A5.8020901@roeck-us.net>
References: <20160215170527.GA24453@roeck-us.net>
 <CAJZ5v0gLankSuziQq25qTCyNqeOX43yD9jnJu_XXwbdyajfmKg@mail.gmail.com>
 <20160215190116.GX19432@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:55773 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751117AbcBOTk0 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 15 Feb 2016 14:40:26 -0500
In-Reply-To: <20160215190116.GX19432@atomide.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-next@vger.kernel.org, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On 02/15/2016 11:01 AM, Tony Lindgren wrote:
> * Rafael J. Wysocki <rafael@kernel.org> [160215 10:44]:
>> On Mon, Feb 15, 2016 at 6:05 PM, Guenter Roeck <linux@roeck-us.net> wrote:
>>> Rafael,
>>
>> Hi,
>>
>> Thanks for the report!
>>
>>> I see crashes in various arm qemu tests due to 'cpufreq: governor: Replace
>>> timers with utilization update callbacks' with next-20160215. An example
>>> crash log and bisect results are attached below.
>>>
>>> Please let me know if there is anything I can do to help tracking down
>>> the problem.
>>
>> It looks like we've uncovered some nastiness in the arch ARM code (see below).
>>
>> [cut]
>>
>>> [    1.340000] Unable to handle kernel NULL pointer dereference at virtual address 00000000
>>> [    1.340000] pgd = c0204000
>>> [    1.340000] [00000000] *pgd=00000000
>>> [    1.340000] Internal error: Oops: 80000005 [#1] SMP ARM
>>> [    1.340000] Modules linked in:
>>> [    1.340000] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 4.5.0-rc4-next-20160215 #1
>>> [    1.340000] Hardware name: Generic OMAP3-GP (Flattened Device Tree)
>>> [    1.340000] task: cb060000 ti: cb05a000 task.ti: cb05a000
>>> [    1.340000] PC is at 0x0
>>> [    1.340000] LR is at arch_send_call_function_single_ipi+0x34/0x38
>>
>> Since this is ARM, arch_send_call_function_single_ipi() looks like this:
>>
>> void arch_send_call_function_single_ipi(int cpu)
>> {
>>           smp_cross_call(cpumask_of(cpu), IPI_CALL_FUNC_SINGLE);
>> }
>>
>> so I'm not sure how the NULL pointer deref is possible even.
>>
>> The only thing coming to mind would be that cpumask_of(cpu) triggers
>> this, but I'm not sure how exactly that can happen.
>>
>> I need help from somebody who knows how this low-level stuff works on ARM.
>
> That's not even an SMP machine? I suspect a bunch of out of the
> 65 boot failures here are related to this:
>
> https://kernelci.org/boot/all/job/next/kernel/next-20160215/
>
> The SMP ones seem to fail with some regulator issues?
>

There is another problem, introduced with 6a0712f6f199e ("PM / OPP: Add
dev_pm_opp_set_rate()"). The kernelci boot log for next-20160212:omap3-overo-tobi
and others experience that problem.

Essentially, the code now assumes that a CPU clock always has a voltage
regulator attached to it, which is not correct. I sent out a patch to fix
that problem a minute ago.

Guenter

