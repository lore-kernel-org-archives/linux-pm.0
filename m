From: Sebastian Parschauer <sebastian.riemer@profitbricks.com>
Subject: Re: cpuidle: Kernel panics with AMD Opteron 6300 entering C2 - clock
 related
Date: Thu, 18 Jun 2015 16:09:15 +0200
Message-ID: <5582D10B.8030301@profitbricks.com>
References: <55814696.1050803@profitbricks.com> <55828DBD.5000109@linaro.org> <5582A2DC.7060001@profitbricks.com> <5582A9C8.8050200@profitbricks.com> <5582C761.7070302@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wg0-f52.google.com ([74.125.82.52]:34756 "EHLO
	mail-wg0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754448AbbFROJS (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 18 Jun 2015 10:09:18 -0400
Received: by wgfq1 with SMTP id q1so18170497wgf.1
        for <linux-pm@vger.kernel.org>; Thu, 18 Jun 2015 07:09:17 -0700 (PDT)
In-Reply-To: <5582C761.7070302@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linux-pm@vger.kernel.org

On 18.06.2015 15:28, Daniel Lezcano wrote:
> On 06/18/2015 01:21 PM, Sebastian Parschauer wrote:
>> On 18.06.2015 12:52, Sebastian Parschauer wrote:
>>> On 18.06.2015 11:22, Daniel Lezcano wrote:
>>>> On 06/17/2015 12:06 PM, Sebastian Parschauer wrote:
>>>>> Hi cpuidle maintainers,
>>>>>
>>>>> we notice kernel panics with CPUs from the AMD Opteron 6300 series and
>>>>> kernel 3.12 when entering C2. In that C-state the clock is shut
>>>>> down but
>>>>> the flag CPUIDLE_FLAG_TIMER_STOP isn't set. We use the TSC clock
>>>>> source
>>>>> for performance as our servers host KVM VMs. During the panics
>>>>> interrupts are enabled again and the timer interrupt corrupts the
>>>>> instruction pointer and/or the stack pointer.
>>>>>
>>>>> Would it help to set the flag CPUIDLE_FLAG_TIMER_STOP for C2?
>>>>> Or how to fix this?
>>>>
>>>> Did you try the flag ? Does it fix it ?
>>>
>>> Thanks for your reply. Unfortunately we can't roll out new kernels fast
>>> (VMs have to be migrated). But we've disabled the C2 state via sysfs for
>>> all CPU cores and all servers and had one more kernel panic with the
>>> same call trace although C2 was (or should have been) disabled. We use
>>> the menu governor and a v3.12.40 kernel.
>>>
>>> It's strange to me coming into the same code path with state index 2 as
>>> parameter again. I think I'll prepare a kernel with some debug messages
>>> when transitioning from one state to another and deploy it to a test
>>> system.
>>>
>>> Is there any better method to debug the cpuidle driver?
>>>
>>> How do you guys test it?
>>>
>>> Can we provide any missing additional information?
>>>
>>> Maybe something else corrupts the memory in an interrupt and the cpuidle
>>> driver is just the one noticing an unrelated problem.
>>
>> Sorry, I had a closer look at the most recent crash again. It happened
>> at entering C1 with disabled C2. So maybe our problem is not cpuidle
>> related.
> 
> As mentioned in the previous email, disabling the idle state index 2 in
> the kernel does not prevent the firmware to auto-promote to this state.
> 
> By the way, I am not sure this is really the C2 state but the idle state
> index 2. Could you give the C state name you have in the sysfs directory ?

state0: POLL
state1: C1
state2: C2

We also see it in the crash dump that C2 is drv->states[2].

Thanks for the detailed information! That helps a lot. Yes, we have the
possibility to set the max. allowed C-state in the BIOS. We'll do a
research on this. We are only rarely in C2 and can't afford to disable
C1. So setting C1 as the maximum C-state in the BIOS could be an option.
Thanks!

Cheers,
Sebastian
