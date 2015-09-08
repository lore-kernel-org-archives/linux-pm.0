From: Grygorii Strashko <grygorii.strashko@ti.com>
Subject: Re: [PATCH v2 7/7] ARM: smp: Add runtime PM support for CPU hotplug
Date: Tue, 8 Sep 2015 11:21:53 +0300
Message-ID: <55EE9AA1.8020200@ti.com>
References: <Pine.LNX.4.44L0.1509051133100.30865-100000@netrider.rowland.org>
 <2657565.lxWtPmdjyp@vostro.rjw.lan> <55ED9328.2010501@ti.com>
 <2355864.I8qZFusWfm@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:38611 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752193AbbIHIWz (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 8 Sep 2015 04:22:55 -0400
In-Reply-To: <2355864.I8qZFusWfm@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Alan Stern <stern@rowland.harvard.edu>, Thomas Gleixner <tglx@linutronix.de>, Lina Iyer <lina.iyer@linaro.org>, Russell King - ARM Linux <linux@arm.linux.org.uk>, Mark Rutland <mark.rutland@arm.com>, ulf.hansson@linaro.org, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, linux-pm@vger.kernel.org, Catalin Marinas <catalin.marinas@arm.com>, k.kozlowski@samsung.com, msivasub@codeaurora.org, khilman@linaro.org, geert@linux-m68k.org, agross@codeaurora.org, sboyd@codeaurora.org, linux-arm-kernel@lists.infradead.org, Ingo Molnar <mingo@kernel.org>

On 09/07/2015 11:42 PM, Rafael J. Wysocki wrote:
> On Monday, September 07, 2015 04:37:44 PM Grygorii Strashko wrote:
>> On 09/07/2015 04:04 PM, Rafael J. Wysocki wrote:
>>> On Saturday, September 05, 2015 11:39:20 AM Alan Stern wrote:
>>>> On Sat, 5 Sep 2015, Grygorii Strashko wrote:
>>>>
>>>>> On 09/04/2015 09:45 PM, Alan Stern wrote:
>>>>>> On Fri, 4 Sep 2015, Grygorii Strashko wrote:
>>>>>>
>>>>>>> There is one "small" problem with such approach :(
>>>>>>>
>>>>>>> - It's incompatible with -RT kernel, because PM runtime can't be used
>>>>>>> in atomic context on -RT.
>>>>>>
>>>>>> Can you explain this more fully?  Why can't runtime PM be used in
>>>>>> atomic context in the -rt kernels?
>>>>>>    
>>>>>
>>>>> See:
>>>>>    http://lwn.net/Articles/146861/
>>>>>    https://rt.wiki.kernel.org/index.php/Frequently_Asked_Questions#How_does_the_CONFIG_PREEMPT_RT_patch_work.3F
>>>>>
>>>>> spinlock_t
>>>>>       Critical sections are preemptible. The _irq operations (e.g., spin_lock_irqsave())
>>>>>    do -not- disable hardware interrupts. Priority inheritance is used to prevent priority
>>>>>    inversion. An underlying rt_mutex is used to implement spinlock_t in PREEMPT_RT.
>>>>>
>>>>> As result, have to do things like:
>>>>> https://lkml.org/lkml/2015/8/18/161
>>>>> https://lkml.org/lkml/2015/8/18/162
>>>>>
>>>>> Sorry for brief reply - Friday/Sat night :)
>>>>
>>>> I see.  Although we normally think of interrupt contexts as being
>>>> atomic, in an -rt kernel this isn't true any more because things like
>>>> spin_lock_irq don't actually disable interrupts.
>>>>
>>>> Therefore it would be correct to say that in -rt kernels, runtime PM
>>>> can be used in interrupt context (if the device is marked as irq-safe),
>>>> but not in atomic context.  Right?
>>>
>>> Right.
>>>
>>> Whatever is suitable for interrupt context in the mainline, will be suitable
>>> for that in -rt kernels too.
>>
>> Not exactly true :(, since spinlock is converted to [rt_] mutex.
>> Usually, this difference can't be seen because on -RT kernel all or
>> mostly all HW IRQ handlers will be forced to be threaded.
> 
> Exactly.  And that's what I'm talking about.
> 
>> For the cases, where such automatic conversion is not working,
>> (like chained irq handlers or HW-handler+Threaded handler) the code
>> has to be carefully patched to work properly as for non-RT as for -RT.
> 
> Right.
> 
>> Also, this triggers some -RT incompatibility issues, like with PM runtime or
> 
> That I'm not sure about.  Why would runtime PM cause problems with -RT (apart
> from attempts to use it from the idle loop, but that's not happening in the
> mainline anyway)?


I have to be more specific - sorry. "irq_safe" mode of PM runtime is incompatible with -RT.

Here is an example:
- HW IRQ handler in TI OMAP GPIO driver is implemented as chained IRQ handler and
  contains pm_runtime_get_sync()/pm_runtime_put(). This works properly with vanilla kernel
  because OMAP GPIO devices marked as irq_safe.
  Chained IRQ handlers can't be forced threaded and PM runtime APIs trigger
 "sleeping function called from invalid context" issues there, so corresponding code has to be reworked.


...


-- 
regards,
-grygorii
