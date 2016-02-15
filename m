From: Marc Zyngier <marc.zyngier@arm.com>
Subject: Re: Crashes in arm qemu emulations due to 'cpufreq: governor: Replace
 timers with utilization ...'
Date: Mon, 15 Feb 2016 18:49:52 +0000
Message-ID: <56C21DD0.40508@arm.com>
References: <20160215170527.GA24453@roeck-us.net>
 <CAJZ5v0gLankSuziQq25qTCyNqeOX43yD9jnJu_XXwbdyajfmKg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:47346 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751952AbcBOStz (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Mon, 15 Feb 2016 13:49:55 -0500
In-Reply-To: <CAJZ5v0gLankSuziQq25qTCyNqeOX43yD9jnJu_XXwbdyajfmKg@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>, Guenter Roeck <linux@roeck-us.net>, Viresh Kumar <viresh.kumar@linaro.org>
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, linux-next@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>

On 15/02/16 18:41, Rafael J. Wysocki wrote:
> On Mon, Feb 15, 2016 at 6:05 PM, Guenter Roeck <linux@roeck-us.net> wrote:
>> Rafael,
> 
> Hi,
> 
> Thanks for the report!
> 
>> I see crashes in various arm qemu tests due to 'cpufreq: governor: Replace
>> timers with utilization update callbacks' with next-20160215. An example
>> crash log and bisect results are attached below.
>>
>> Please let me know if there is anything I can do to help tracking down
>> the problem.
> 
> It looks like we've uncovered some nastiness in the arch ARM code (see below).
> 
> [cut]
> 
>> [    1.340000] Unable to handle kernel NULL pointer dereference at virtual address 00000000
>> [    1.340000] pgd = c0204000
>> [    1.340000] [00000000] *pgd=00000000
>> [    1.340000] Internal error: Oops: 80000005 [#1] SMP ARM
>> [    1.340000] Modules linked in:
>> [    1.340000] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 4.5.0-rc4-next-20160215 #1
>> [    1.340000] Hardware name: Generic OMAP3-GP (Flattened Device Tree)
>> [    1.340000] task: cb060000 ti: cb05a000 task.ti: cb05a000
>> [    1.340000] PC is at 0x0
>> [    1.340000] LR is at arch_send_call_function_single_ipi+0x34/0x38
> 
> Since this is ARM, arch_send_call_function_single_ipi() looks like this:
> 
> void arch_send_call_function_single_ipi(int cpu)
> {
>          smp_cross_call(cpumask_of(cpu), IPI_CALL_FUNC_SINGLE);
> }
> 
> so I'm not sure how the NULL pointer deref is possible even.
> 
> The only thing coming to mind would be that cpumask_of(cpu) triggers
> this, but I'm not sure how exactly that can happen.
> 
> I need help from somebody who knows how this low-level stuff works on ARM.

Given that OMAP3 is a UP system, there is zero chance that it has
registered the magic hook that delivers IPIs (its interrupt controller
is not even capable of doing so).

I don't really know the context, but IPIs on a UP system seem at best odd.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
